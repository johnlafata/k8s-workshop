# Scheduling

## Labels and Selectors

- Labels are simple key value pairs that you can assign to resources

```

"environment" : "dev", "environment" : "qa", "environment" : "production"

"tier" : "frontend", "tier" : "backend", "tier" : "cache"

"partition" : "customerA", "partition" : "customerB"

```

- Labels classify things

- Selectors allow you to use the labels to filter things

  - Based on equality
  ```
    environment = production
    tier != frontend
  ```

  - Set based
  ```
    environment in (production, qa)
    tier notin (frontend, backend)
    partition
    !partition
  ```

## Scheduling Decisions


### Node Selection

- Attach a label to a node

- Define a `nodeSelector` for the pod!

### Affinity

Three "levels" of affinities!

- Preferred during scheduling ignored during execution

- Required while scheduling and but ignore during execution

- Required for scheduling and also during execution

#### Node affinity

- A pod can be defined to have affinity for certain nodes

#### Pod Affinity

- Schedule pods together

#### Pod Anti-Affinity

- These pods hate each other

#### Taints & Tolerations

- Taints are applied to nodes to repel pods that don't tolerate them
- Tolerations are applied to pods to allow scheduling on tainted nodes
- Common taint effects:
  - `NoSchedule` - pods won't be scheduled on the node
  - `PreferNoSchedule` - system will try to avoid scheduling pods on the node
  - `NoExecute` - pods will be evicted from the node if already running

Example taint:
```bash
kubectl taint nodes node1 key1=value1:NoSchedule
```

Example toleration in pod spec:
```yaml
tolerations:
- key: "key1"
  operator: "Equal"
  value: "value1"
  effect: "NoSchedule"
```

- Master nodes typically have taints to prevent regular workloads from scheduling
- Useful for dedicating nodes to specific workloads or creating node pools