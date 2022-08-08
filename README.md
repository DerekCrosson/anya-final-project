# GCP setup Polkadot Network

# Prerequisites

* A [Google Cloud Platform](https://cloud.google.com/) account (new accounts get $300 in free credits for 90 days)
* [Terraform](https://www.terraform.io/) installed on your development machine
* [Ansible](https://www.ansible.com/) installed on your development machine
* [Packer](https://www.packer.io/) installed on your development machine

Add notes for creating a project, a service account and credentials and a remote state bucket manually.

## Manual tasks (once-off) - bash scripts coming soon
### Create a storage bucket for the remote state

[![Watch the video](https://i9.ytimg.com/vi/nOmxVlHdFng/mq1.jpg?sqp=CJytxpcG&rs=AOn4CLD4tJJfdmJpTbvs4qbRqDiCn2SpLw)](https://youtu.be/nOmxVlHdFng)

### Create a service account

[![Watch the video](https://i9.ytimg.com/vi/nOmxVlHdFng/mq1.jpg?sqp=CJytxpcG&rs=AOn4CLD4tJJfdmJpTbvs4qbRqDiCn2SpLw&retry=4)](https://youtu.be/nOmxVlHdFng)

### Create and download the service account keys

[![Watch the video](https://i9.ytimg.com/vi/VipHgpVFY5k/mq1.jpg?sqp=CJytxpcG&rs=AOn4CLAWXmy-ujXBJTJrtO6uKdxHXy-zVQ)](https://youtu.be/VipHgpVFY5k)

# Infrastructure
TODO

# Provisioning
TODO

# Nodes
TODO

# Observability
TODO

# Testing
TODO

# CI/CD
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

3. Run terraform code