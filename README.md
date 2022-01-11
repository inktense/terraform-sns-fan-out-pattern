# API Gateway SNS fan out pattern

Fan-Out is a pattern where we spread messages to multiple destinations

**What is it used for:**
- Use cases where availability and scalabilities are requirements.
- To decouple and make the architecture fault-tolerant.
- Services can work and scale independently.

---------------------------------------------------------------
## Implemented use case

 Orders module of a marketplace application where a user submits the order.
 What must happen in the backend:
  - Process the orders.
  - Notify users.
  - Prepare orders for delivery.
  - Generate orders reports.
  - Verify for compliance in certain countries.

We POST the orders to the API Gateway. It then sends them to an SNS topic that takes care of distributing the event to our different queues. They can then be processed independently in different AWS services.

---------------------------------------------------------------

## Pre-requisites

Only using AWS services, an AWS account is required.

You will need to install [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli).

---------------------------------------------------------------
## Deploying to the cloud

```
cd terraform 

tf init 
tf plan 
tf apply
```

---------------------------------------------------------------
## Usefull information

If you want to use Terraform with an AWS profile the only way it worked for me was using the following command:

```
export AWS_PROFILE= <profile>
```
For some reason the method provided in the [documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs) did not work:
```
provider "aws" {
  region                  = "us-west-2"
  shared_credentials_file = "/Users/tf_user/.aws/creds"
  profile                 = "customprofile"
}
```
