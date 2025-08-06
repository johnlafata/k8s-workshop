# Kubernetes Secrets Summary

## Overview
Secrets are Kubernetes objects that store sensitive data like passwords, tokens, and keys. They provide a more secure and flexible way to handle confidential information compared to hardcoding it in Pod specifications or container images.

## Key Features
- **Base64 encoded**: Secret data is stored in base64 format
- **Mounted as volumes or environment variables**: Can be consumed by Pods in different ways
- **Namespace scoped**: Secrets belong to specific namespaces
- **Size limit**: Individual secrets are limited to 1MiB

## Common Secret Types
- `Opaque`: Default type for arbitrary user data
- `kubernetes.io/service-account-token`: Service account tokens
- `kubernetes.io/dockercfg`: Docker registry credentials
- `kubernetes.io/tls`: TLS certificates and keys

## Creating Secrets
```yaml
apiVersion: v1
kind: Secret
metadata:
    name: mysecret
type: Opaque
data:
    username: YWRtaW4=  # base64 encoded 'admin'
    password: MWYyZDFlMmU2N2Rm  # base64 encoded password
```

## Using Secrets
- Mount as volume in Pod
- Expose as environment variables
- Use in image pull secrets for private registries

## Security Considerations
- Secrets are not encrypted at rest by default
- Enable encryption at rest for production
- Use RBAC to control access
- Avoid logging secret values