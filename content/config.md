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
