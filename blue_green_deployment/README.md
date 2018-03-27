# Blue/Green Deployment with Helm and Istio

The constructs of the blue/green deployment using Istio and Helm can be summarized by the following:

- Three different Helm releases
    - Skeleton: includes the base components like services, ingress, and route rules
    - Blue: bits deployment (pods)
    - Green: bits deployment (pods)

## Stage 0: Skeleton

Description: Deploy the base components for routing traffic. These components do not change frequently, and are not part of either the blue or the green deployments.

```
$ helm install --name skeleton --set skeleton=true helloworldtelephone/
```

![stage0](images/00_skeleton.png)
