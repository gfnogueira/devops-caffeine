# 📌 AWS Architecture Diagrams - PoC

## 📖 Overview
This Proof of Concept (PoC) demonstrates how to generate AWS architecture diagrams using [Diagrams by mingrammer](https://diagrams.mingrammer.com/). The repository includes:
- Infrastructure diagrams for various AWS services such as **EKS, VPC, RDS, and IAM**.
- Automated generation of diagrams using **Python and Graphviz**.
- A **CI/CD pipeline in Bitbucket** to generate and publish diagrams to Confluence automatically.

## 🚀 How It Works
1. **Python scripts** use the `diagrams` library to generate architecture diagrams.
2. **A shell script** automates the execution of `diagram.py` files and saves the generated `.png` files.
3. **Bitbucket Pipelines** run the scripts automatically in a CI/CD environment.
4. **Diagrams are uploaded to Confluence** for easy visualization and documentation.

---

## 📂 Repository Structure
```
diagrams/
│── aws/                             # AWS-specific diagrams
│   ├── eks/services-rds/            # Diagrams related to RDS within EKS
│   │   ├── diagram.py               # Code to generate the diagram
│   ├── security/iam-cross-account/  # IAM cross-account assume role diagrams
│   │   ├── diagram.py               # Code to generate the diagram
│   ├── vpc/vpc-base/                # VPC and networking diagrams
│   │   ├── diagram.py               # Code to generate the diagram
│   ├── databases/                   # Database architecture (RDS, DynamoDB, etc.)
│── scripts/                         # Automation scripts
│── README.md                        # Documentation
│── bitbucket-pipelines.yml          # CI/CD pipeline for automatic diagram generation and Confluence upload
```



---

## ⚙️ Running the Diagram Generation Script
To generate diagrams manually, run:
```bash
chmod +x scripts/generate_diagrams.sh
./scripts/generate_diagrams.sh
```
This script will:
- Find all `diagram.py` files.
- Execute each script to generate the `.png` diagrams.
- Store the output in the `artifacts/` directory.

---

## 🛠 CI/CD Pipeline in Bitbucket
### 🏗 Bitbucket Pipelines Configuration
The pipeline automates diagram generation and uploads the results to Confluence.
It runs **Python 3.9** and installs **Graphviz** for rendering diagrams.

**Pipeline configuration (.bitbucket-pipelines.yml):**
```yaml
image: python:3.9

pipelines:
  default:
    - step:
        name: "Generate and Publish Diagrams"
        script:
          - apt-get update && apt-get install -y graphviz curl zip jq
          - pip install diagrams
          - mkdir -p artifacts
          - TIMESTAMP=$(date +%Y%m%d-%H%M%S)

          - echo "🚀 Running diagram generation script..."
          - chmod +x scripts/generate_diagrams.sh
          - ./scripts/generate_diagrams.sh

          - echo "📤 Uploading diagrams to Confluence..."
          - chmod +x scripts/upload_to_confluence.sh
          - ./scripts/upload_to_confluence.sh

        artifacts:
          - "artifacts/*.png"
          - "artifacts/*.zip"
```
This pipeline:
- Installs required dependencies (`graphviz`, `jq`, `diagrams`).
- Executes the diagram generation script.
- Uploads the diagrams to **Confluence** using an automated API call.

---

## 📌 Example Diagrams
### **EKS Private Network with RDS**
This diagram shows an **EKS cluster** inside a **private subnet**, with RDS databases and IAM role associations.

```python
from diagrams import Diagram, Cluster
from diagrams.aws.compute import ElasticKubernetesService
from diagrams.aws.database import RDSMysqlInstance
from diagrams.aws.network import PrivateSubnet, NATGateway
from diagrams.aws.security import IAMRole

with Diagram("EKS Private Network with RDS", show=False):
    with Cluster("Private Subnet"):
        eks = ElasticKubernetesService("EKS Cluster")
        service1 = ElasticKubernetesService("Service 1")
        service2 = ElasticKubernetesService("Service 2")
        service3 = ElasticKubernetesService("Service 3")
        rds1 = RDSMysqlInstance("RDS MySQL 1")
        rds2 = RDSMysqlInstance("RDS MySQL 2")
        rds3 = RDSMysqlInstance("RDS MySQL 3")
        role1 = IAMRole("IAM Role 1")
        role2 = IAMRole("IAM Role 2")
        role3 = IAMRole("IAM Role 3")
        service1 >> rds1
        service2 >> rds2
        service3 >> rds3
        role1 >> service1
        role2 >> service2
        role3 >> service3
    vpc = PrivateSubnet("Private Subnet")
    nat = NATGateway("NAT Gateway")
    eks >> vpc
    vpc >> nat
```

---

## 📢 Conclusion
This PoC provides an automated way to generate AWS architecture diagrams using **Diagrams by mingrammer**. It integrates with **Bitbucket Pipelines**, making it easy to run in any **CI/CD pipeline**, and automatically uploads the results to **Confluence** for documentation purposes.

🚀 **Next Steps:**
- Extend support for other cloud providers (GCP, Azure).
- Add more diagrams covering **security, compliance, and multi-account architectures**.
- Enhance the automation scripts to support **other CI/CD tools like GitHub Actions or GitLab CI/CD**.

---

### 🔗 References
- [Diagrams by Mingrammer](https://diagrams.mingrammer.com/)
- [Bitbucket Pipelines](https://bitbucket.org/product/features/pipelines)
- [AWS Architecture Best Practices](https://aws.amazon.com/architecture/)

---



