# Configmaps and secrets
## ConfigMaps Overview

ConfigMaps are Kubernetes objects used to store non-confidential configuration data in key-value pairs. They allow you to decouple configuration from application code, making applications more portable and easier to manage.

### Key Features:
- Store configuration data separately from container images
- Can be consumed as environment variables, command-line arguments, or configuration files
- Data is stored as UTF-8 strings
- Maximum size of 1MB per ConfigMap

### ConfigMap Example

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
    name: app-config
    namespace: default
data:
    # Simple key-value pairs
    database_host: "mysql.example.com"
    database_port: "3306"
    log_level: "info"
    
    # Multi-line configuration file
    app.properties: |
        server.port=8080
        spring.datasource.url=jdbc:mysql://mysql.example.com:3306/mydb
        spring.jpa.hibernate.ddl-auto=update
        
    # JSON configuration
    config.json: |
        {
            "api": {
                "timeout": 30,
                "retries": 3
            }
        }
```

### Using ConfigMap in a Pod

```yaml
apiVersion: v1
kind: Pod
metadata:
    name: app-pod
spec:
    containers:
    - name: app
        image: myapp:latest
        env:
        # Use ConfigMap as environment variables
        - name: DB_HOST
            valueFrom:
                configMapKeyRef:
                    name: app-config
                    key: database_host
        volumeMounts:
        # Mount ConfigMap as files
        - name: config-volume
            mountPath: /etc/config
    volumes:
    - name: config-volume
        configMap:
            name: app-config
```
## Secrets Overview

Secrets are similar to ConfigMaps but are specifically designed to store sensitive data such as passwords, tokens, and keys. They provide an additional layer of security for confidential information.

### Key Differences from ConfigMaps:
- Data is base64 encoded (not encrypted by default)
- Stored in etcd with encryption at rest (when configured)
- More restrictive access controls
- Mounted as tmpfs volumes for better security

### Secret Example

```yaml
apiVersion: v1
kind: Secret
metadata:
    name: app-secret
    namespace: default
type: Opaque
data:
    # Base64 encoded values
    database-password: bXlwYXNzd29yZA==
    api-key: YWJjZGVmZ2hpams=
stringData:
    # Plain text (automatically base64 encoded)
    username: admin
```

## How ConfigMaps and Secrets Work Together

ConfigMaps and Secrets are complementary and often used together in the same application:

### Combined Usage Example

```yaml
apiVersion: v1
kind: Pod
metadata:
    name: web-app
spec:
    containers:
    - name: webapp
        image: nginx:latest
        env:
        # Non-sensitive config from ConfigMap
        - name: APP_ENV
            valueFrom:
                configMapKeyRef:
                    name: app-config
                    key: environment
        # Sensitive data from Secret
        - name: DB_PASSWORD
            valueFrom:
                secretKeyRef:
                    name: app-secret
                    key: database-password
        volumeMounts:
        - name: config-vol
            mountPath: /etc/config
        - name: secret-vol
            mountPath: /etc/secrets
    volumes:
    - name: config-vol
        configMap:
            name: app-config
    - name: secret-vol
        secret:
            secretName: app-secret
            defaultMode: 0400  # Read-only for owner
```

### Best Practices for Using Both:
- Use ConfigMaps for application settings, feature flags, and non-sensitive configuration
- Use Secrets for passwords, API keys, certificates, and other sensitive data
- Combine both in the same Pod when applications need both types of data
- Apply appropriate RBAC policies to control access to both resources
