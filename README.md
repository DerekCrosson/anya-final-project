# GCP setup Polkadot Network - INCOMPLETE
This project is still incomplete and needs about 2 more full days of work to be done.
TODO:
- Fix startup script for self-hosted runners
- ~~Create a Kubernetes cluster to run RPC nodes using Terraform~~
- Deploy helm charts for RPC nodes and for observability using Ansible
- Write/Update documentation and update videos
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

## Add Github Actions Secrets

* GCP_PROJECT_ID - The project ID of the GCP project
* GCP_WORKLOAD_IDENTITY_PROVIDER - The full identifier of the Workload Identity Provider, including the project number, pool name, and provider name (e.g. `projects/123456789/locations/global/workloadIdentityPools/my-pool/providers/my-provider`)
* PERSONAL_ACCESS_TOKEN - A Github Personal Access Token (read:user, repo, workflow)
* SSH_PRIVATE_KEY - The SSH private key that matched the public key variable in the Terraform nodes module variables
* TERRAFORM_SERVICE_ACCOUNT_EMAIL - The email of the service account you are using to manage your Terraform resources and which is allowed to access the compute instances

# Infrastructure

Terraform and Ansible are used to create and provision the infractructure. Terraform also generates the Ansible inventory which is used to keep track of the infrastructure where access may be needed regularly, such as block chain nodes where the software version needs to be updated regularly. These updates can be performed with Ansible.

# CI/CD

All Terraform and Ansible commands are run from Github Actions to make the process easier and automated. In the Terraform workflow Github Actions uses Google Cloud Workload Identity Federation to generate a OAuth2 tokens for the service account which will then generate short-lived access tokens. This will allow the pipeline to run without using keys or secrets to authenticate. Short lived tokens are also removed from the runner as soon as the workflow stops. The Ansible workflow depends on the Terraform workflow and uses SSH with the private key stored in Github Actions secrets. To create/update and provision new infrastructure, just push to the main branch.

# Provisioning
When Terraform creates/updates the infrastructure it also creates/updates the [Ansible inventory](https://github.com/DerekCrosson/anya-final-project/blob/main/ansible/inventory/hosts.ini). The inventory file looks like this:
```
[blockchain_nodes]
polkadot-boot-node-primary node_type=boot node_tier=primary ansible_host=12.345.678.123 ansible_port=22
polkadot-boot-node-secondary node_type=boot node_tier=secondary ansible_host=98.765.42.21 ansible_port=22
polkadot-collator-node-primary node_type=collator node_tier=primary ansible_host=12.98.345.76 ansible_port=22
```

The Github Action workflow which creates the infrastructure will commit the Ansible inventory changes to the repository whenever there is a change and this will be available to the Ansible workflow immediately.

Each line contains the ID of the machine, the type of node it's running, it's tier (I did this so it's easy to identify nodes of the same type) and the SSH port.

When Ansible runs the `polkadot_node` task it uses the information from the inventory to determine which systemd service to create, and to inject the public I.P. address and node tier into the node name in the systemd service.

# Nodes
The following nodes are created:
* 2 x boot nodes (primary and secondary)
* 1 x collator nodes

# Observability
TODO

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
