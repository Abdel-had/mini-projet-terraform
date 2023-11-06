Author: Abdel-had HANAMI

Context: DevOps Bootcamp - class 12

Training Center: eazytraining.fr

Date of Publication: November 7, 2023

LinkedIn: https://www.linkedin.com/in/abdel-had-hanami/

---
# Infrastructure as Code with Terraform

This project uses Terraform to deploy a web application on AWS by provisioning an EC2 instance with Ubuntu Bionic, an EBS volume, a public IP address, and a security group.

## Project Structure

The project is divided into reusable modules to facilitate the management and maintenance of the infrastructure:

- `modules/ebs_volume`: Defines an EBS volume.
- `modules/ec2_instance`: Configures an EC2 instance with Ubuntu Bionic, installs nginx, and uses an SSH key for access.
- `modules/public_ip`: Assigns a public IP to the EC2 instance and records this address in `ip_ec2.txt`.
- `modules/security_group`: Creates a security group that allows HTTP, HTTPS, and SSH traffic.
- `app`: Folder containing the application configuration that uses the modules to deploy the EC2 instance.

## Prerequisites

- Terraform v0.12+ installed on your local machine.
- AWS CLI configured with the appropriate credentials.
- An S3 bucket for the Terraform backend (already created and configured in `app/main.tf`).
- An SSH key named `devops-abdelhad` must be available and configured in AWS.

## Quick Start

1. Clone this repository to your local machine.

    ```
    git clone https://github.com/Abdel-had/mini-projet-terraform.git
    ```

2. Ensure your AWS credentials are correctly configured.

    On Windows:

    ```ps1
    $env:AWS_ACCESS_KEY_ID = "PUT_YOUR_OWN"
    $env:AWS_SECRET_ACCESS_KEY = "PUT_YOUR_OWN"
    ```

    On Linux:

    ```sh
    export AWS_ACCESS_KEY_ID="PUT_YOUR_OWN"
    export AWS_SECRET_ACCESS_KEY="PUT_YOUR_OWN"
    ```


3. Navigate to the project folder (**app**) and initialize Terraform with the command:

   ```sh
   terraform init
   ```

4. Apply the Terraform configuration:

   ```sh
   terraform apply
   ```

5. Confirm the actions proposed by Terraform when prompted.

## Configuration

Default variables are defined in the `variables.tf` files of each module. To customize these, I have overridden them in `app/main.tf` when calling the modules. You can create a `terraform.tfvars` file in the `app` folder or pass variables directly via the command line.

Example content for `app/terraform.tfvars`:

```hcl
instancetype = "t2.micro"
ebs_size = 10
sg_name = "app-sg"
```

## Outputs

After execution, Terraform will display the IDs of the created resources, including the EC2 instance ID and the name of the security group. You will also find the public IP address of the instance in the `app/ip_ec2.txt` file.

## Cleanup

To destroy the infrastructure created by Terraform (and avoid additional charges), run:

```sh
terraform destroy
```

## Security

- Never version your private keys or Terraform state files.
- Use restrictive IAM policies to control access to AWS resources.

## Support

If you encounter any problems or have questions, please open an issue in the project repository.