# Jenkins CI/CD Pipeline with Terraform

## Project Overview
A basic CI/CD pipeline using **Jenkins** to build, test, and deploy a Python Flask application, with **Terraform** to provision AWS S3 infrastructure.

## Technologies
- Python and Flask
- Jenkins
- Git and GitHub
- Terraform
- AWS S3

## Project Structure
```text
jenkins-terraform-assignment/
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── .terraform.lock.hcl
├── app.py
├── test_app.py
├── requirements.txt
├── Jenkinsfile
├── deploy.ps1
├── run_deploy.py
└── .gitignore
```

## Implementation

### 1. Clone the Repository
```bash
git clone https://github.com/atharvag25/jenkins-terraform-assignment.git
cd jenkins-terraform-assignment
```

### 2. Install Dependencies
```bash
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
```

### 3. Run Tests
```bash
python -m pytest -v
```

### 4. Configure Jenkins
- Open Jenkins at `http://localhost:8080`.
- Create a Pipeline job.
- Connect the GitHub repository.
- Select **Pipeline script from SCM**.
- Choose Git and set the script path to `Jenkinsfile`.
- Run the pipeline.

The pipeline performs:
1. Source code checkout
2. Dependency installation
3. Automated testing
4. Flask application deployment

### 5. Verify Deployment
- Application: `http://127.0.0.1:5001`
- Health check: `http://127.0.0.1:5001/health`

### 6. Provision AWS Infrastructure with Terraform
Configure AWS CLI credentials before proceeding.

```powershell
cd terraform
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

Type `yes` when Terraform requests confirmation.

Terraform provisions an AWS S3 bucket with:
- Bucket versioning enabled
- AES-256 server-side encryption
- Public access blocked

View the provisioned resource details:
```powershell
terraform output
```

## Cleanup
To remove the Terraform-managed infrastructure:

```powershell
terraform destroy
```

Confirm with `yes` when prompted.

## Repository
[GitHub – Jenkins Terraform Assignment](https://github.com/atharvag25/jenkins-terraform-assignment)

**Note:** Do not commit AWS credentials, Terraform state files, or local environment folders.
