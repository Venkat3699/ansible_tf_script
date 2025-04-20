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
#### AWS CLI
```
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    sudo apt install unzip
    unzip awscliv2.zip
    sudo ./aws/install
```

#### Terraform
```
    sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

    wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list

    sudo apt update

    sudo apt-get install terraform -y
```

#### Checking Configuration
- Connect Controller via terminals like Git Bash, Putty and Mobaxterm
```
    ansible all -i hosts.cfg -m shell -a "date"
    ansible all -i hosts.cfg -m ping
```