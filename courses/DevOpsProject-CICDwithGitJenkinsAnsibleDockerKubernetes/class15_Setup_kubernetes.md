## Launch Instance
- AMI: Ubuntu Server 18.04 LTS
- Instance Type: t2.micro
- SG ports: 22;8080

## Install AWSCLI
```
sudo apt install python3-pip
pip3 install awscli
```

## Install Kubectl
```
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
```

## Install Kops
```
curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x kops-linux-amd64
sudo mv kops-linux-amd64 /usr/local/bin/kops
```

## Create IAM Role
- Select type of trusted entity: AWS service
- Choose a use case: EC2
- Policy: AmazonEC2FullAccess, AmazonS3FullAccess, AmazonRoute53FullAccess, IAMFullAccess
- Name: K8s-Role

## Attach Instance
1) Console:
	- Services > EC2 > Instances > Actions (Check server)> Instance Settings > Attach/Replace IAM Role:
		- IAM role: K8s-Role
2) AWS CLI:
```
$ aws configure
>> AWS Access Key ID [None]: 
>> AWS Secret Access Key [None]: 
>> Default region name [None]: us-east-1
>> Default output format [None]: 
```

## Create a Route53 private hosted zone (you can create Public hosted zone if you have a domain)
- Services > Route 53 > Create Hosted Zone
	- Domain Name: edynsoncoronado.com
	- Type: private hosted zone
	- VPC ID: Virginia

## Create an S3 Bucket
```
aws s3 mb s3://demo.k8s.edynsoncoronado.com
```

## Expose environment variable
```
export KOPS_STATE_STORE=s3://demo.k8s.edynsoncoronado.com
```

## Create sshkeys
```
ssh-keygen
```

## Create kubernetes cluster definitions on S3 bucket
```
kops create cluster --cloud=aws --zones=us-east-1d --name=demo.k8s.edynsoncoronado.com --dns-zone=edynsoncoronado.com --dns private
```

## Create kubernetes cluser
```
kops update cluster --name demo.k8s.edynsoncoronado.com --yes
```

## Validate your cluster
```
kops validate cluster
```
* Please wait about 5-10 minutes for a master to start, dns-controller to launch, and DNS to propagate.
* ssh -i ~/.ssh/id_rsa admin@api.demo.k8s.edynsoncoronado.com

## To list nodes
```
$ kubectl get nodes
NAME                           STATUS   ROLES    AGE     VERSION
ip-172-20-47-67.ec2.internal   Ready    master   6m56s   v1.16.7
ip-172-20-58-6.ec2.internal    Ready    node     5m25s   v1.16.7
ip-172-20-60-77.ec2.internal   Ready    node     5m17s   v1.16.7

```

## To delete cluster
```
kops delete cluster demo.k8s.edynsoncoronado.com --yes
```