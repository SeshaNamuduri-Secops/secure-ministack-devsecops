# Secure Local AWS Serverless Platform with IaC, DevSecOps & ServiceNow ITSM

A local AWS-compatible serverless DevSecOps laboratory built with MiniStack, Docker, Terraform, IAM, GitHub Actions, security scanning tools, and ServiceNow ITSM integration.

> **Environment note:** This project uses MiniStack as a local AWS-compatible environment. It is a laboratory/portfolio implementation and does not represent a production AWS deployment.

---

## Project Overview

This project demonstrates how cloud-style infrastructure, security controls, infrastructure as code, DevSecOps automation, and IT service management can be combined into a single workflow.

The platform provides:

- Local AWS-compatible S3 storage
- Python-based Lambda serverless processing
- IAM least-privilege access control
- Terraform infrastructure as code
- CloudFormation template validation
- Automated security and IaC scanning
- GitHub Actions CI
- ServiceNow Incident Management
- ServiceNow Change Management

---

## Architecture

```text
                         Developer
                             |
                             v
                       GitHub Repository
                             |
                             v
                     GitHub Actions CI
                             |
          +------------------+------------------+
          |                  |                  |
          v                  v                  v
       Bandit            pip-audit          Gitleaks
          |                  |                  |
          +------------------+------------------+
                             |
                    Terraform / Checkov
                             |
                    CloudFormation lint
                             |
                             v
                    Local MiniStack
                             |
                 +-----------+-----------+
                 |                       |
                 v                       v
                S3                    Lambda
                 |                       |
                 +-----------+-----------+
                             |
                             v
                       IAM Authorization
                             |
                    +--------+--------+
                    |                 |
                    v                 v
               Developer       DeveloperLead
               Get / Put       Get / Put / Delete
                    |                 |
                    v                 v
                AccessDenied        Allowed
                    |
                    v
              Security Event
                    |
                    v
             ServiceNow Incident


             Infrastructure Change
                    |
                    v
             ServiceNow Change
We'll replace it with a professional README that accurately reflects what we built.
Step 1 — Replace README completely
Copy-paste this entire block:
cat > README.md <<'EOF'
# Secure Local AWS Serverless Platform with IaC, DevSecOps & ServiceNow ITSM

A local AWS-compatible serverless DevSecOps laboratory built with MiniStack, Docker, Terraform, IAM, GitHub Actions, security scanning tools, and ServiceNow ITSM integration.

> **Environment note:** This project uses MiniStack as a local AWS-compatible environment. It is a laboratory/portfolio implementation and does not represent a production AWS deployment.

---

## Project Overview

This project demonstrates how cloud-style infrastructure, security controls, infrastructure as code, DevSecOps automation, and IT service management can be combined into a single workflow.

The platform provides:

- Local AWS-compatible S3 storage
- Python-based Lambda serverless processing
- IAM least-privilege access control
- Terraform infrastructure as code
- CloudFormation template validation
- Automated security and IaC scanning
- GitHub Actions CI
- ServiceNow Incident Management
- ServiceNow Change Management

---

## Architecture

```text
                         Developer
                             |
                             v
                       GitHub Repository
                             |
                             v
                     GitHub Actions CI
                             |
          +------------------+------------------+
          |                  |                  |
          v                  v                  v
       Bandit            pip-audit          Gitleaks
          |                  |                  |
          +------------------+------------------+
                             |
                    Terraform / Checkov
                             |
                    CloudFormation lint
                             |
                             v
                    Local MiniStack
                             |
                 +-----------+-----------+
                 |                       |
                 v                       v
                S3                    Lambda
                 |                       |
                 +-----------+-----------+
                             |
                             v
                       IAM Authorization
                             |
                    +--------+--------+
                    |                 |
                    v                 v
               Developer       DeveloperLead
               Get / Put       Get / Put / Delete
                    |                 |
                    v                 v
                AccessDenied        Allowed
                    |
                    v
              Security Event
                    |
                    v
             ServiceNow Incident


             Infrastructure Change
                    |
                    v
             ServiceNow Change

Technology Stack
Area	Technology
Local cloud platform	MiniStack
Containers	Docker / Docker Compose
Object storage	S3-compatible service
Serverless	AWS Lambda-compatible runtime
Programming	Python
IAM	AWS-compatible IAM
IaC	Terraform
Template validation	CloudFormation + cfn-lint
Code security	Bandit
Dependency security	pip-audit
Secret detection	Gitleaks
IaC security	Checkov
CI	GitHub Actions
ITSM	ServiceNow
API integration	REST API


1. MiniStack Environment
MiniStack is deployed locally using Docker Compose.
The platform exposes the AWS-compatible endpoint:
http://localhost:4566

The MiniStack container provides the local AWS-compatible services used by this project.
2. S3 Storage
A secure bucket named:
secure-files-bucket

was created and tested.
Validated operations include:
- Upload
- Get
- Download
- Copy
- Delete
S3 security configuration includes:
- Public access blocking
- Bucket versioning
- Lifecycle management for non-current versions
3. Lambda Serverless Function
The project contains a Python Lambda function:
secure-s3-operations

The function supports:
put
get
download
copy
delete

The Lambda communicates with the S3-compatible MiniStack endpoint using boto3.
4. IAM Least Privilege
Two IAM users were configured with different permissions.
Developer
Allowed:
s3:GetObject
s3:PutObject

DeveloperLead
Allowed:
s3:GetObject
s3:PutObject
s3:DeleteObject

The access controls were tested.
The Developer account received AccessDenied when attempting an unauthorized delete operation, while DeveloperLead was permitted to perform the operation.
This demonstrates practical least-privilege authorization rather than only defining policies.
5. Infrastructure as Code
Terraform manages the local infrastructure configuration.
Terraform resources include:
- S3 bucket
- S3 public access block
- S3 versioning
- S3 lifecycle configuration
- IAM users
- IAM user policies
Terraform was formatted, initialized and validated successfully.
Existing MiniStack resources were imported into Terraform state before validating the configuration.
6. CloudFormation
A CloudFormation template is included under:
infrastructure/cloudformation/template.yaml

The template was validated using the MiniStack CloudFormation API and through the CI validation workflow.
The template is used for validation/documentation and is not deployed over the already-existing S3 bucket.
7. DevSecOps Security Controls
The project integrates multiple security checks.
Bandit
Python source code security scanning.
The Lambda handler completed the targeted Bandit scan without identified security issues.
pip-audit
Python dependency vulnerability scanning.
Result:
No known vulnerabilities found

Gitleaks
Repository secret scanning.
Result:
No leaks found

Checkov
Terraform infrastructure security scanning.
The final configured lab scan achieved:
32 passed
0 failed

Seven checks that are not appropriate for this local MiniStack laboratory context are explicitly excluded in the CI workflow.
8. GitHub Actions CI
The repository contains:
.github/workflows/ci.yml

The workflow performs:
1. Repository checkout
2. Python environment setup
3. Dependency installation
4. Python syntax validation
5. Bandit security scanning
6. pip-audit dependency scanning
7. Terraform formatting validation
8. Terraform validation
9. Checkov IaC security scanning
10. CloudFormation linting
The workflow has been successfully executed through GitHub Actions.
9. ServiceNow ITSM Integration
ServiceNow is used to demonstrate ITSM handling of security and infrastructure events.
Incident Management
A security event representing an unauthorized S3 delete attempt was recorded as a ServiceNow Incident.
Example:
MiniStack unauthorized S3 access attempt

Change Management
An infrastructure change was created through the ServiceNow Table API:
CHG0030001
Deploy Secure MiniStack infrastructure configuration

This demonstrates the relationship between DevSecOps infrastructure changes and ITSM change management.
10. End-to-End Security / ITSM Flow
IAM Security Event
       |
       v
Access Control / AccessDenied
       |
       v
ServiceNow Incident

Infrastructure changes follow:
Terraform / Infrastructure Change
       |
       v
ServiceNow Change Request

11. Repository Structure
secure-ministack-devsecops/
|
├── .github/
│   └── workflows/
│       └── ci.yml
|
├── infrastructure/
│   ├── cloudformation/
│   │   └── template.yaml
│   └── terraform/
│       ├── main.tf
│       ├── s3.tf
│       └── iam.tf
|
├── lambda/
│   ├── handler.py
│   └── requirements.txt
|
├── documentation/
│   └── screenshots/
|
├── scripts/
├── security/
├── servicenow/
├── tests/
│
├── docker-compose.yml
├── .gitignore
└── README.md

12. Evidence
Selected implementation screenshots are available under:
documentation/screenshots/

Evidence covers:
- MiniStack startup
- AWS CLI connectivity
- S3 operations
- Lambda
- IAM
- Terraform
- Security scanning
- GitHub Actions
- ServiceNow Incident
- ServiceNow Change Request
Project Outcome
This project demonstrates practical experience across:
Cloud-style infrastructure + Serverless + IAM Security + Infrastructure as Code + DevSecOps + CI + Security Scanning + ITSM
The implementation is intentionally local and reproducible using MiniStack rather than claiming a production AWS deployment.
