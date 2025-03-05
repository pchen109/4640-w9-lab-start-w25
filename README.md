# 4640-w9-lab-start-w25

## General Setup
1. **Clone the repository** to your local machine.
2. **Ensure you have the following installed and setup**:
    - Install [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli).
    - Connect to AWS derver with `aws configure` with your Access Key ID and Secret Access Key. 

## STEPS
1. **Generate a new SSH key pair**
    ```bash
    ssh-keygen -t ed25519 -f ~/.ssh/aws
    ```
2. **Import the key to AWS**
    - Open project repo
    - Run
    ```bash
    ./scripts/import_lab_key $HOME/.ssh/aws.pub
    ```
3. **Run Packer**
    ```bash
    packer init ./packer
    packer build ./packer
    ```
3. **Run Terraform**
    ```bash
    terraform -chdir=./terraform init
    terraform -chdir=./terraform apply --auto-approve
    ```

## Clean up
1. **Terminate instances**
    ```bash
    terraform -chdir=./terraform destroy --auto-approve
    ```
2. **Delete SSH Key**
    ```bash
    ./scripts/delete_lab_key
    rm $HOME/.ssh/aws
    rm $HOME/.ssh/aws.pub
    ```
3. **Delete AMI**
    1. Log in to AWS
    2. Navigate to AMI under EC2
    3. Deregister the AMI with the name "lab8"
4. **Delete Snapshots**
    1. Log in to AWS
    2. Navigate to Snapshot under EC2
    3. Delete the snapshots created recently