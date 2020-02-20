FROM ubuntu:bionic

RUN apt-get update && \
	apt-get -y upgrade && \
	apt-get install -y \
	vim \
	aptitude \
	curl \
	dnsutils \
    python3 \
    git \
    telnet

RUN	apt-get install -y python3-pip 
RUN pip3 install ansible boto3
RUN apt-get install -y mysql-client
RUN apt-get install -y unzip wget openssh-server
#RUN apt-get install -y unzip wget

# AWS CLI
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" && \
    unzip awscli-bundle.zip && \
    python3 awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws


# KOPS - kubernetes
RUN wget https://github.com/kubernetes/kops/releases/download/1.10.0/kops-linux-amd64 && \
    chmod +x kops-linux-amd64 && \
    mv kops-linux-amd64 /usr/local/bin/kops 

# Install kubernetes
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

# Terraform
RUN wget https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.18_linux_amd64.zip && \
    unzip terraform_0.12.18_linux_amd64.zip && \
    mv terraform /usr/local/bin/

# Set bash CLI
RUN echo "PS1='\[\033[1;36m\]\h \[\033[1;34m\]\W\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]\n   🐳  '" >> /root/.bashrc
#RUN echo "PS1='🐳  \[\033[1;36m\]\h \[\033[1;34m\]\W\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]'" >> /root/.bashrc

# AWS IAM authenticator
RUN curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/aws-iam-authenticator && \
    chmod +x ./aws-iam-authenticator && \
    mv ./aws-iam-authenticator /usr/local/bin/

# install helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh

# cfssl
RUN wget -q --show-progress --https-only --timestamping \
    https://pkg.cfssl.org/R1.2/cfssl_linux-amd64 \
    https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64 && \
    chmod +x cfssl_linux-amd64 cfssljson_linux-amd64 && \
    mv cfssl_linux-amd64 /usr/local/bin/cfssl && \
    mv cfssljson_linux-amd64 /usr/local/bin/cfssljson && \
    cfssl version

# consul
RUN wget https://releases.hashicorp.com/consul-template/0.24.1/consul-template_0.24.1_linux_amd64.tgz && \
    tar -xvf consul-template_0.24.1_linux_amd64.tgz && \
    mv ./consul-template /usr/local/bin/

