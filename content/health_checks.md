# Kubernetes Health Checks

## Overview
Kubernetes provides three types of health checks (probes) to monitor application health and manage container lifecycle.

## Types of Probes

### 1. Liveness Probe
- **Purpose**: Determines if a container is running properly
- **Action**: Restarts container if probe fails
- **Use case**: Detect deadlocked applications that need restart

### 2. Readiness Probe
- **Purpose**: Determines if a container is ready to accept traffic
- **Action**: Removes pod from service endpoints if probe fails
- **Use case**: Prevent traffic to pods that aren't ready to serve requests

### 3. Startup Probe
- **Purpose**: Determines if a container application has started
- **Action**: Disables liveness/readiness checks until startup succeeds
- **Use case**: Handle slow-starting containers without affecting other probes

## Probe Mechanisms

### HTTP GET
- Performs HTTP GET request to specified path and port
- Success: HTTP status 200-399
- Configurable headers and scheme (HTTP/HTTPS)

### TCP Socket
- Attempts to open TCP connection to specified port
- Success: Connection established

### Exec
- Executes specified command inside container
- Success: Command exits with status code 0

## Configuration Options
- `initialDelaySeconds`: Delay before first probe
- `periodSeconds`: Probe frequency
- `timeoutSeconds`: Probe timeout
- `successThreshold`: Consecutive successes needed
- `failureThreshold`: Consecutive failures before action