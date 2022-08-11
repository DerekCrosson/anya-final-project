# GCP setup Polkadot Network - INCOMPLETE
This project is still incomplete and needs about 2 more full days of work to be done.
TODO:
- Increase GCP location quotas for disk size so all nodes can be deployed
- Fix Workload Identity Configuration provider attributes so Github Actions can deploy self-hosted runners
- Create an Action to deploy the rest of the infrastructure and commit the latest Ansible inventory to the repo
- Install Polkadot on all VMs (boot nodes and collator nodes)
- Create a Kubernetes cluster to run RPC nodes using Terraform
- Deploy helm charts for RPC nodes and for observability using Ansible
- Write/Update documentation and update videos
- Write some tests
- Write bash scripts for manual tasks and run them using an Action
- Bake my own images using Packer/Create an apt package?

# Prerequisites

* A [Google Cloud Platform](https://cloud.google.com/) account (new accounts get $300 in free credits for 90 days)
* [Terraform](https://www.terraform.io/) installed on your development machine
* [Ansible](https://www.ansible.com/) installed on your development machine
* [Packer](https://www.packer.io/) installed on your development machine

Add notes for creating a project, a service account and credentials and a remote state bucket manually.

## Manual tasks (once-off) - bash scripts coming soon
## Create a storage bucket for the remote state

[![Watch the video](https://i9.ytimg.com/vi/nOmxVlHdFng/mq1.jpg?sqp=CJytxpcG&rs=AOn4CLD4tJJfdmJpTbvs4qbRqDiCn2SpLw)](https://youtu.be/nOmxVlHdFng)

## Create a service account

[![Watch the video](https://i9.ytimg.com/vi/nOmxVlHdFng/mq1.jpg?sqp=CJytxpcG&rs=AOn4CLD4tJJfdmJpTbvs4qbRqDiCn2SpLw&retry=4)](https://youtu.be/nOmxVlHdFng)

## Create and download the service account keys

[![Watch the video](https://i9.ytimg.com/vi/VipHgpVFY5k/mq1.jpg?sqp=CJytxpcG&rs=AOn4CLAWXmy-ujXBJTJrtO6uKdxHXy-zVQ)](https://youtu.be/VipHgpVFY5k)

# Infrastructure
Terraform and Ansible are used to create and provision the infractructure. Terraform also generates the Ansible inventory which is used to keep track of the infrastructure where access may be needed regularly, such as block chain nodes where the software version needs to be updated regularly. These updates can be performed with Ansible.

All Terraform commands are run from a Makefile to make the process easier and so they can be run from the root directory. The idea is to be able to have a single command to setup and configure the entire project which will also be run through CI (Github Actions). Github Actions will use Google Cloud Workload Identity Federation to generate a OAuth tokens for the service account which will then generate short-lived access tokens. This will allow the pipeline to run without using keys or secrets to authenticate. Short lived tokens are also removed from the runner as soon as the workflow stops.

### Initialise Terraform

```zsh
make terraform-init
```

### Generate a plan

```zsh
make terraform-plan
```

### Create/Update infrastructure

```zsh
make terraform-apply
```

### Destroy all infrastructure except remote state bucket
```zsh
make terraform-destroy
```

# Provisioning
TODO

# Nodes
TODO: Write some info and show a diagram

# Observability
TODO

# Testing
TODO

# CI/CD
TODO: Write some info and show a diagram

# Development Environment Setup

1. Install the GCloud SDK on your development machine and configure the CLI. Follow the setup and configuration instructions for your operating system [here](https://cloud.google.com/sdk/docs/install). If you don't already have a project, create one and set it as the default project now.
2. Enable the following APIs:

    ```bash
    # Command to enable services
    gcloud services enable [service_name].googleapis.com

    # Example
    gcloud services enable compute.googleapis.com
    ```

    - [Compute](https://cloud.google.com/compute/docs/reference/rest/v1)

3. Run terraform code