# Wisecow DevOps Deployment (AccuKnox Assessment)

This project demonstrates containerization, Kubernetes deployment, CI/CD automation, infrastructure provisioning, TLS security, and monitoring automation for the Wisecow application.

It was implemented as part of the AccuKnox DevOps Trainee Practical Assessment.

---

# Architecture Overview

Developer Push → GitHub → GitHub Actions → DockerHub → AWS EC2 (K3s Kubernetes) → Wisecow Application

Components used:

* Infrastructure Provisioning: Terraform
* Containerization: Docker
* Container Registry: DockerHub
* Orchestration: Kubernetes (K3s)
* CI/CD: GitHub Actions
* Ingress Controller: Traefik
* Secure Communication: TLS via Kubernetes Ingress
* Monitoring Scripts: Bash automation

---

# Project Structure

```
wisecow
│
├ Dockerfile
├ wisecow.sh
│
├ k8s
│ ├ deployment.yaml
│ ├ service.yaml
│ └ ingress.yaml
│
├ terraform
│ ├ provider.tf
│ ├ vpc.tf
│ ├ internet.tf
│ ├ security.tf
│ ├ ec2.tf
│ └ outputs.tf
│
├ scripts
│ ├ system_monitor.sh
│ └ app_health_check.sh
│
└ .github/workflows
└ ci-cd.yaml
```

---

# Infrastructure Provisioning

Terraform provisions the AWS infrastructure required for the application.

Resources created:

* VPC
* Subnet
* Internet Gateway
* Security Group
* EC2 Instance

Commands used:

```
terraform init
terraform plan
terraform apply
```

Region: ap-south-1

---

# Containerization

The Wisecow application is containerized using Docker.

Build image:

```
docker build -t nikkaman07/wisecow:latest .
```

Push to DockerHub:

```
docker push nikkaman07/wisecow:latest
```

---

# Kubernetes Deployment

The application is deployed on a K3s Kubernetes cluster running on AWS EC2.

Deployment includes:

* Kubernetes Deployment
* Kubernetes Service
* Kubernetes Ingress

Deploy resources:

```
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl apply -f k8s/ingress.yaml
```

---

# TLS Secure Communication

Secure HTTPS communication is implemented using Kubernetes Ingress.

Traefik is used as the ingress controller.

TLS secret creation:

```
kubectl create secret tls wisecow-tls \
--cert=tls.crt \
--key=tls.key \
-n wisecow
```

Application access:

```
https://<server-ip>
```

---

# CI/CD Pipeline

GitHub Actions automates:

1. Docker image build
2. Docker image push to DockerHub
3. SSH connection to EC2
4. Rolling restart of Kubernetes deployment

Workflow file:

```
.github/workflows/ci-cd.yaml
```

Pipeline triggers on pushes to the `main` branch.

---

# Automation Scripts

Two Bash scripts were created to automate monitoring tasks.

### System Health Monitoring

Monitors:

* CPU usage
* Memory usage
* Disk usage

Logs alerts when thresholds are exceeded.

Script:

```
scripts/system_monitor.sh
```

---

### Application Health Checker

Checks application uptime using HTTP response codes.

Script:

```
scripts/app_health_check.sh
```

---

