# Kubernetes Security Context Best Practices

## What is Security Context?

Security Context defines privilege and access control settings for Pods and containers, controlling how they run and what system resources they can access.

## When Do You Need Security Context?

- **Production environments** - Always recommended
- **Multi-tenant clusters** - Essential for isolation
- **Applications handling sensitive data** - Required for compliance
- **Container images from unknown sources** - Critical for security
- **Privileged operations** - When you need to restrict or grant specific permissions

## Essential Security Context Settings

### Pod-Level Security Context

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
    name: secure-app
spec:
    template:
        spec:
            securityContext:
                runAsNonRoot: true
                runAsUser: 1000
                runAsGroup: 1000
                fsGroup: 1000
                seccompProfile:
                    type: RuntimeDefault
```

### Container-Level Security Context

```yaml
spec:
    containers:
    - name: app
        image: myapp:latest
        securityContext:
            allowPrivilegeEscalation: false
            readOnlyRootFilesystem: true
            runAsNonRoot: true
            capabilities:
                drop:
                - ALL
                add:
                - NET_BIND_SERVICE
```

## Best Practices

### 1. Start with These Defaults
- `runAsNonRoot: true` - Prevent root execution
- `allowPrivilegeEscalation: false` - Block privilege escalation
- `readOnlyRootFilesystem: true` - Make filesystem immutable
- `capabilities.drop: [ALL]` - Remove all Linux capabilities

### 2. Progressive Implementation
1. **Basic**: Non-root user + no privilege escalation
2. **Intermediate**: Add read-only filesystem + drop capabilities
3. **Advanced**: Custom seccomp/AppArmor profiles + specific UIDs


## Key Considerations

- Test security contexts in development first
- Use init containers for filesystem setup if read-only root is enabled
- Consider using Pod Security Standards for cluster-wide policies
- Monitor for security context violations in logs
- Balance security with application functionality

## Privileged Operations Requiring Explicit Permission

When using Pod Security Standards with `enforce=restricted`, the following operations require explicit RBAC permissions or security context configurations:

### Host-Level Access Operations

**hostNetwork: true**
- **Operation**: Allows pod to use the host's network namespace
- **Risk**: Pod can access all network interfaces and services on the node
- **Permission**: Requires `use` verb on `podsecuritypolicies` or custom RBAC rules
- **Use case**: Network monitoring tools, CNI plugins

**hostPID: true**
- **Operation**: Shares the host's process namespace with the pod
- **Risk**: Pod can see and potentially interact with all host processes
- **Permission**: Requires elevated cluster permissions
- **Use case**: System monitoring, debugging tools

**hostIPC: true**
- **Operation**: Uses the host's inter-process communication namespace
- **Risk**: Access to host's shared memory and semaphores
- **Permission**: Requires specific security policy exemption
- **Use case**: Legacy applications requiring shared memory

### Volume Mount Operations

**hostPath volumes**
- **Operation**: Mounts directories from the host filesystem
- **Risk**: Direct access to host files, potential privilege escalation
- **Permission**: Requires `use` verb on restricted security policies
- **Use case**: Log collection, device access

**Privileged volume types**
- **Operation**: Mounting /proc, /sys, or other sensitive filesystems
- **Risk**: Kernel parameter modification, system information exposure
- **Permission**: Custom SecurityContextConstraints or PSP
- **Use case**: System agents, hardware monitoring

### Capability Management

**Adding Linux capabilities**
- **Operation**: Granting specific kernel capabilities beyond baseline
- **Risk**: Varies by capability (network admin, file ownership, etc.)
- **Permission**: Explicit allowlist in security policies
- **Common needs**: `NET_ADMIN`, `SYS_TIME`, `CHOWN`

**Running as UID 0 (root)**
- **Operation**: Executing container processes as root user
- **Risk**: Full container privileges, potential breakout
- **Permission**: `runAsNonRoot: false` must be explicitly allowed
- **Workaround**: Use init containers with proper user switching

### Container Runtime Controls

**allowPrivilegeEscalation: true**
- **Operation**: Permits gaining more privileges than parent process
- **Risk**: Potential privilege escalation attacks
- **Permission**: Must be explicitly set in security context
- **Alternative**: Use init containers for privileged setup tasks

**privileged: true**
- **Operation**: Runs container in privileged mode
- **Risk**: Nearly equivalent to root access on host
- **Permission**: Requires exemption from restricted policy
- **Use case**: Container runtime management, hardware access