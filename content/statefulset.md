# Statefulset

StatefulSets are used for applications that require one or more of the following:

- Stable, unique network identifiers
- Stable, persistent storage
- Ordered, graceful deployment and scaling
- Ordered, automated rolling updates

Unlike Deployments, StatefulSets maintain a sticky identity for each pod. These pods are created from the same spec, but are not interchangeable - each has a persistent identifier that it maintains across any rescheduling.

## Key Features

- **Stable Network Identity**: Each pod gets a predictable hostname based on the StatefulSet name and ordinal index
- **Stable Storage**: Each pod can have its own persistent volume that survives pod rescheduling
- **Ordered Operations**: Pods are created, updated, and deleted in order from 0 to N-1

## Use Cases

StatefulSets are valuable for applications like:
- Databases (MySQL, PostgreSQL, MongoDB)
- Distributed systems (Kafka, Elasticsearch, Zookeeper)
- Applications requiring stable network identities or ordered deployment

* Some exercises will not work on Minikube/Docker Kubernetes - use a volume which is hostPath so that it does not wait for volume provisioning

- Each replica gets a unique identifier

- The deployment and scaling is ordered & graceful

# Deletion Strategies

- Rolling updates

- Partitions