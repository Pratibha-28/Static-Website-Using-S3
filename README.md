
# Static Website Hosting Using S3 And Terraform

## Description

This project is of simple static website hosting using  AWS S3 and terraform.

Static web page will load images.

Terraform script will create S3 bucket for hosting static website and other S3 bucket for storing website S3 bucket logging.

## Below are the steps for running terraform script on Windows.

### `System Prerequisites`
Below tool's setup should be available.
- Terraform Installation
- AWS CLI configuration using AWS programmatic user having appropriate access level.(In this project context `S3FullAccess` policy will work for CLI user)

**1. Run Terraform Script**
``` 
git clone https://github.com/Pratibha-28/Static-Website-Using-S3.git 

cd Static-Website-Using-S3/terraform-scripts/static-website/

terraform init
```
![image](https://user-images.githubusercontent.com/19345296/128269054-a43d1ca1-f250-4137-8a27-18c63c0de34f.png)

```
terraform plan -var-file input.tfvars
```
![image](https://user-images.githubusercontent.com/19345296/128269160-666f983a-c1cb-4fd7-b336-3c849d448f8d.png)

```
terraform apply -var-file input.tfvars
```
![image](https://user-images.githubusercontent.com/19345296/128269223-0c876950-4950-4cf1-8617-0994b5c02bc5.png)

Copy the website_endpoint from output

To remove/delete the AWS resources created by terraform script
```
terraform plan -var-file input.tfvars -destroy

terraform apply -var-file input.tfvars -destroy
```
![image](https://user-images.githubusercontent.com/19345296/128269663-2f187845-09c9-4e6a-b7a8-f60b36df49a7.png)

**2. Upload Website content in S3**

```
cd Static-Website-Using-S3/test-s3-static-web/

aws s3 sync . s3://test-s3-static-web

```

**3. Access the Website**

![image](https://user-images.githubusercontent.com/19345296/128268769-d8818ccc-bc45-4907-90a0-b85233720afe.png)


## References
- https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html
- https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

