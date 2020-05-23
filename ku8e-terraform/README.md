# Note
To execute Infrastructure Construction-
Go inside environment folder -> Prod -> Execute here below commands
i) Terraform validate
ii) Terraform apply

We can create Test Environment folder in same environment directory. 


## Terraform Commands 

Terraform works by detecting current infrastructure tests and calculating differences between known state and desired state. To avoid blind changes, Terraform outputs by default its migration plan between its current state and target and asks the user for confirmation.
```sh
terraform plan
```
### Apply 
This outputs the migration plan and is particularly useful for letting someone else validate the change or to verify that there are no unwanted changes.
```sh
terraform apply
```
Terraform applies a migration plan. You also can specify the plan to apply to be sure there are no changes between the review and the effective change.

### Command-line parameter variables

For command-line parameter, you can use the var key like this:
```sh
terraform apply -var zone=europe-west1-a
```

### Variables file
Variables can also be defined in a dedicated file (for example, staging.tfvar or production.tfvars).
```sh
terraform apply -var-file=production.tf
```
