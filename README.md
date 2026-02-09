Project Title: End-to-End GitOps CI/CD Pipeline for Reddit-Clone Application
​Executive Summary
​I have engineered a robust, secure, and fully automated DevSecOps pipeline. This project demonstrates the implementation of Infrastructure as Code (IaC), GitOps principles, and Cloud-Native Observability to deploy a scalable application on AWS EKS.
​Phase 1: Infrastructure & Environment Setup (IaC)
​Provisioning: Used Terraform to automate the creation of Jenkins and SonarQube instances.
​Jenkins Configuration: * Installed essential plugins: NodeJS, Docker, SonarQube Scanner, Quality Gates, and Eclipse Temurin.
​Configured Global Tool Configuration for JDK, Docker, and NodeJS.
​SonarQube Integration: * Established a secure handshake between Jenkins and SonarQube using API tokens.
​Configured Webhooks to enable SonarQube to notify Jenkins upon Quality Gate completion.
​Phase 2: The CI (Continuous Integration & Security) Pipeline
​The CI pipeline is triggered automatically via GitHub Webhooks.
​Code Analysis: Runs SonarQube Static Analysis to ensure code quality.
​DevSecOps (Security): * Executed Trivy FileSystem Scan to detect vulnerabilities in the source code.
​Used Quality Gates to halt the pipeline if the code doesn't meet security standards.
​Artifact Management: * Built a Docker image with a dynamic tag based on the Jenkins BUILD_NUMBER.
​Pushed the image to Docker Hub.
​Performed a Trivy Image Scan on the pushed image to ensure container security.
​Notification: Integrated Gmail SMTP to send automated email alerts upon CI completion.
​Phase 3: Kubernetes Infrastructure & Monitoring
​Cluster Management: Deployed an Amazon EKS Cluster using eksctl and configured kubectl.
​IAM Roles: Attached necessary IAM policies to the Jenkins EC2 instance for seamless AWS resource management.
​Observability Stack: * Deployed Prometheus and Grafana via Helm Charts.
​Exposed services using LoadBalancer (LB) to monitor the cluster externally.
​Configured Grafana Dashboard (ID: 15760) for real-time Kubernetes performance metrics.
​Phase 4: The CD (Continuous Delivery) & GitOps Flow
​ArgoCD Orchestration: * Installed ArgoCD on the EKS cluster and configured the ArgoCD CLI.
​Connected the Ops Repository (containing Kubernetes manifests) to ArgoCD.
​Automated CD Pipeline: * Created a dedicated CD Job triggered by the CI Job via API Token.
​The CD Job automatically updates the deployment.yaml in the Ops Repo with the new Image Tag.
​GitOps Sync: ArgoCD detects the change in the Git repository and automatically synchronizes the state, deploying the Reddit-Clone-App to the EKS cluster.
​Key Technical Competencies Demonstrated:
​Automation: Zero-human intervention from code commit to deployment.
​Security: Multi-layer scanning (Code & Container) using Trivy.
​GitOps: Managing infrastructure state via Git (ArgoCD).
​Monitoring: Proactive cluster health tracking with Prometheus/Grafana.
​Tech Stack:
​Cloud: AWS (EKS, EC2, IAM) | IaC: Terraform | CI/CD: Jenkins, ArgoCD | Containers: Docker | Security: SonarQube, Trivy | Monitoring: Prometheus, Grafana | Package Manager: Helm
