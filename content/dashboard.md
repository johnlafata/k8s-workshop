# Dashboard

- Demo the dashboard with a walkthrough

- Dashboard access: https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/ 

- URL for dashboard is 

  - http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/overview

- If the dashboard has errors around access, then run:

```
kubectl create clusterrolebinding dashboard-admin --clusterrole=cluster-admin  --serviceaccount=kube-system:kubernetes-dashboard
```