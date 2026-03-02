# Kubernetes Deployment for STANS Navigation System

This directory contains Kubernetes manifests for deploying the STANS Navigation System to a Kubernetes cluster.

Prerequisites

- Kubernetes cluster (v1.20+)

- kubectl configured to access your cluster

- Docker image pushed to a container registry

- Domain name configured with DNS

- NGINX Ingress Controller installed

- Cert-Manager installed (for SSL/TLS)

Quick Start

1. Update Image Reference

Update the image reference in deployment.yaml:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

image: ghcr.io/YOUR_USERNAME/STANS:latest

1. Update Domain Name

Update the domain name in ingress.yaml:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

hosts:

- stans-app.com

- <www.stans-app.com>

1. Deploy to Kubernetes

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Apply all manifests

kubectl apply -f .

## Or apply individual files

kubectl apply -f deployment.yaml

kubectl apply -f ingress.yaml

kubectl apply -f configmap.yaml

kubectl apply -f hpa.yaml

kubectl apply -f pdb.yaml

1. Verify Deployment

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Check deployment status

kubectl get deployment stans-app

## Check pods

kubectl get pods -l app=stans-app

## Check service

kubectl get service stans-app-service

## Check ingress

kubectl get ingress stans-app-ingress

## Check HPA

kubectl get hpa stans-app-hpa

1. Access the Application

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Get the ingress IP

kubectl get ingress stans-app-ingress

## Or port-forward for local testing

kubectl port-forward service/stans-app-service 8080:80

Components

1. Deployment

- File: deployment.yaml

- Replicas: 3 (configurable)

- Strategy: RollingUpdate

- Resources:

- Request: 256Mi RAM, 250m CPU

- Limit: 512Mi RAM, 500m CPU

- Probes: Liveness and readiness checks

- Graceful shutdown: 30 seconds

1. Service

- File: deployment.yaml

- Type: ClusterIP

- Port: 80

- Selector: app=stans-app

1. Ingress

- File: ingress.yaml

- Class: nginx

- SSL: Automatic with Cert-Manager

- Hosts: stans-app.com, <www.stans-app.com>

- Annotations: SSL redirect, proxy settings

1. ConfigMap

- File: configmap.yaml

- Purpose: Application configuration

- Environment variables: APP_ENV, API settings, feature flags

1. HorizontalPodAutoscaler

- File: hpa.yaml

- Min replicas: 3

- Max replicas: 10

- Metrics: CPU (70%), Memory (80%)

- Scaling behavior: Configurable up/down policies

1. PodDisruptionBudget

- File: pdb.yaml

- Min available: 2 pods

- Purpose: Ensure availability during updates

Advanced Configuration

Custom Namespace

Create a custom namespace:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

apiVersion: v1

kind: Namespace

metadata:

  name: stans-production

Apply to namespace:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

kubectl apply -f namespace.yaml

kubectl apply -f . -n stans-production

Resource Limits

Adjust resource limits in deployment.yaml:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

resources:

  requests:

    memory: "512Mi"

    cpu: "500m"

  limits:

    memory: "1Gi"

    cpu: "1000m"

Node Affinity

Add node affinity to deployment.yaml:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

spec:

  template:

    spec:

      affinity:

        nodeAffinity:

          requiredDuringSchedulingIgnoredDuringExecution:

            nodeSelectorTerms:

            - matchExpressions:

              - key: kubernetes.io/arch

                operator: In

                values:

                - amd64

Tolerations

Add tolerations for dedicated nodes:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

spec:

  template:

    spec:

      tolerations:

      - key: "dedicated"

        operator: "Equal"

        value: "stans-app"

        effect: "NoSchedule"

Monitoring and Logging

View Logs

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## View all pod logs

kubectl logs -l app=stans-app --all-containers=true

## View specific pod logs

kubectl logs <pod-name>

## Follow logs

kubectl logs -f <pod-name>

## View previous container logs

kubectl logs <pod-name> --previous

Monitor Resources

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Check pod resource usage

kubectl top pods -l app=stans-app

## Check node resource usage

kubectl top nodes

Events

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## View events

kubectl get events --sort-by='.lastTimestamp'

## View events for specific pod

kubectl describe pod <pod-name>

Scaling

Manual Scaling

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Scale to 5 replicas

kubectl scale deployment stans-app --replicas=5

## Scale to 2 replicas

kubectl scale deployment stans-app --replicas=2

Auto Scaling

The HPA automatically scales based on CPU and memory usage. Monitor it:

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Check HPA status

kubectl get hpa stans-app-hpa

## Describe HPA

kubectl describe hpa stans-app-hpa

Updates and Rollouts

Update Image

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Update image

kubectl set image deployment/stans-app stans-app=ghcr.io/YOUR_USERNAME/STANS:v2.0.0

## Or edit deployment

kubectl edit deployment stans-app

Rollout Status

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Check rollout status

kubectl rollout status deployment/stans-app

## View rollout history

kubectl rollout history deployment/stans-app

Rollback

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Rollback to previous version

kubectl rollout undo deployment/stans-app

## Rollback to specific revision

kubectl rollout undo deployment/stans-app --to-revision=2

Pause and Resume

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Pause rollout

kubectl rollout pause deployment/stans-app

## Resume rollout

kubectl rollout resume deployment/stans-app

Troubleshooting

Pod Issues

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Describe pod for details

kubectl describe pod <pod-name>

## Check pod logs

kubectl logs <pod-name>

## Check events

kubectl get events --sort-by='.lastTimestamp'

Service Issues

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Check service endpoints

kubectl get endpoints stans-app-service

## Test service connectivity

kubectl run -it --rm debug --image=busybox --restart=Never -- wget -O- <http://stans-app-service>

Ingress Issues

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Describe ingress

kubectl describe ingress stans-app-ingress

## Check ingress controller logs

kubectl logs -n ingress-nginx <ingress-pod-name>

Common Issues

Image Pull Errors

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Check if image exists

docker pull ghcr.io/YOUR_USERNAME/STANS:latest

## Create image pull secret

kubectl create secret docker-registry regcred \

  --docker-server=ghcr.io \

  --docker-username=YOUR_USERNAME \

  --docker-password=YOUR_TOKEN

## Add secret to deployment

kubectl patch deployment stans-app -p '{"spec":{"template":{"spec":{"imagePullSecrets":[{"name":"regcred"}]}}}}'

CrashLoopBackOff

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Check logs

kubectl logs <pod-name>

## Check resource limits

kubectl describe pod <pod-name>

## Increase resources if needed

Pending Pods

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Check pod status

kubectl describe pod <pod-name>

## Check node capacity

kubectl describe nodes

## Check resource quotas

kubectl get resourcequota

Cleanup

Remove All Resources

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Delete all resources

kubectl delete -f .

## Or delete individual resources

kubectl delete deployment stans-app

kubectl delete service stans-app-service

kubectl delete ingress stans-app-ingress

kubectl delete configmap stans-app-config

kubectl delete hpa stans-app-hpa

kubectl delete pdb stans-app-pdb

Clean Up Persistent Resources

[data-radix-scroll-area-viewport]{scrollbar-width:none;-ms-overflow-style:none;-webkit-overflow-scrolling:touch;}[data-radix-scroll-area-viewport]::-webkit-scrollbar{display:none}

## Delete secrets

kubectl delete secret regcred

## Delete PVCs (if any)

kubectl delete pvc -l app=stans-app

Best Practices

- Always use namespaces for environment isolation

- Set resource requests and limits for all containers

- Use liveness and readiness probes for health checks

- Configure HPA for automatic scaling

- Use PodDisruptionBudgets for high availability

- Implement rolling updates for zero-downtime deployments

- Monitor logs and metrics continuously

- Use ConfigMaps and Secrets for configuration

- Implement proper security policies (NetworkPolicies, RBAC)

- Regularly update cluster and applications

Security Considerations

- Network Policies: Restrict pod-to-pod communication

- RBAC: Use role-based access control

- Secrets Management: Use Kubernetes secrets or external secret managers

- Image Scanning: Scan images for vulnerabilities

- Pod Security Standards: Apply security contexts

- Service Accounts: Use dedicated service accounts

- Audit Logging: Enable audit logging for compliance

Production Checklist

- Configure proper resource limits

- Set up monitoring and alerting

- Configure log aggregation

- Implement backup strategy

- Set up disaster recovery

- Configure SSL/TLS certificates

- Implement security policies

- Set up CI/CD pipeline

- Configure auto-scaling

- Test failover scenarios

- Document runbooks

- Train operations team

Support

- Kubernetes Documentation

- NGINX Ingress Controller

- Cert-Manager

- kubectl Cheat Sheet

License

This Kubernetes configuration is part of the STANS Navigation System project.
