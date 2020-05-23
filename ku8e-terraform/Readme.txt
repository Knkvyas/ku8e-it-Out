To execute Infrastructure Construction-
Go inside environment folder -> Prod -> Execute here below commands
i) Terraform validate
ii) Terraform apply

We can create Test Environment folder in same environment directory. 


---------------------
Terraform works by detecting current infrastructure tests and calculating differences between known state and desired state. To avoid blind changes, Terraform outputs by default its migration plan between its current state and target and asks the user for confirmation.

There are two useful commands for supporting this check:

terraform plan
