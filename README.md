# Auto Deploymemnt of EKS Infrastructure on AWS with Terraform

## Project Content
* **tf-eks-demo**: Contains terraform scripts to deploy infrastructure in declarative format. 

We create the following infrastructure on AWS with the instructions given below.
- EC2 Instances
- EKS Cluster
- Worker Nodes autoscaling group


There are 2 ways we can deploy EKS cluster on AWS

#### Eksctl tool: 
* It's a new CLI tool from AWS to create EKS clusters. It uses CloudFormation in background to create the clusters.

#### Terraform: 
* Its another popular IaC (Infrastructure as Code) tool to create infrastructure in declarative way. Using this tool 
  we can create servers, clusters or any other infra on on-premises, AWS, Azure, GCP, IBM Cloud and many more.
  It is much useful when your organization has hybrid/multi-cloud environment.

## Creating EKS cluster with Terraform Scripts
 - Prerequisite: kubectl & aws-iam-authenticator cli tools need to be installed on laptop.
 
There are terraform scripts in "tf-eks-demo" folder. By running the following commands terraform creates
EC2 instance and EKS cluster for us in the desired/specified (eu-west-2) region and saves terraform state in s3 bucket. All the required configs are defined in respective script, 
like IAM roles, policies, security groups, etc.
Before executing the below scripts the user must have created an IAM role and needs to be configured
on his laptop. Else the access_key & secret_key needs to be configured in terraform script.

````
terraform init   //to initialize terraform 
terraform plan   //to review the tf scripts and to make the plan by terraform
terraform apply  //final command to execute the provision of infra on cloud or on-premise
```` 
The deployment of infra will take at least 15 min.

To execute further commands the following CLI tools needs to be installed on laptop
* kubectl - To connect and co-ordinate with Kubernetes cluster.
* aws-iam-authenticator - To connect with AWS cloud with IAM roles in a secured way.

Once the cluster is up and running, we need to run the following commands to get configurations of EKS and 
to connect with AWS cloud

The below commands needs to be executed to copy the EKS configuration to kubectl cli tool to get conenct with Kubernetes
````
terraform output kubeconfig > ~/.kube/config 
aws eks --region eu-west-2 update-kubeconfig --name terraform-eks-demo
````
The below command to get config details of authentication with AWS & deploy the config map deployment.
````
terraform output config-map-aws-auth > config-map-aws-auth.yaml  
kubectl apply -f config-map-aws-auth.yaml  

# To check for successfull connection / authorization to eks cluster
kubectl get nodes 
kubectl cluster-info 

### Deploying sample nginx pod as deployment for Kubernetes on this cluster once authenticated to new cluster created as part of above instructions:

cd nginx directory

#this will create a deployment with nginx pods in it
kubectl apply -f deployment.yaml

# this will expose nginx service with a loadbalancer as service type 
kubectl apply -f service.yaml

this can be checked by lb name appearing when ran this command
kubectl get service

To undeploy infra on, first check and delete any manually cretaed resources / policies, if incase someone created and then run the following command. This will ensure all the infra is deleted
````
cd tf-eks-demo


terraform destroy 
````
