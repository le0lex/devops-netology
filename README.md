#IDE commit
#task 3 new branch fix
# devops-netology
netology repository

new string


C
локальные длиректории и поддиректории  .terraform
**/.terraform/*

файлы с раширением .tfstate и содержащие это расширение
# .tfstate files
*.tfstate
*.tfstate.*
файлы crash.log и файлы содержащие что угодно между crash и log
# Crash log files
crash.log
crash.*.log

файлы заканчивающиеся на .tfvars .tfvars.json
# Exclude all .tfvars files, which are likely to contain sensitive data, such as
# password, private keys, and other secrets. These should not be part of version 
# control as they are data points which are potentially sensitive and subject 
# to change depending on the environment.
*.tfvars
*.tfvars.json

перечисленные два файла и заканчивающиеся на _override.tf b _override.tf.json
# Ignore override files as they are usually used to override resources locally and so
# are not checked in
override.tf
override.tf.json
*_override.tf
*_override.tf.json

# Include override files you do wish to add to version control using negated pattern
# !example_override.tf

# Include tfplan files to ignore the plan output of command: terraform plan -out=tfplan
# example: *tfplan*

# Ignore CLI configuration files
.terraformrc
terraform.rc
