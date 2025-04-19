- Launch an EC2 instance and install Terraform, and AWSCLI
- Clone this Git Repo in that instance
- Copy your pemfile in the current directory

#### Commands
```
terraform init
terraform plan -var "pemfile=devops_mumbai" -var "servercount=2" -out ansiblelab    # Here we mention instance count as 3, in script it is 1
terraform apply "ansiblelab"
terraform destroy --auto-approve
```