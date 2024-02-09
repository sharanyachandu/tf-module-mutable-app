resource "null_resource" "app" {
#    triggers      = {  ver = var.APP_VERSION}  // Whenever these is a change in the versio only during that time it will run.
   triggers     = {  timestamp =    timestamp() }  // This will run all the time
   count        = var.SPOT_INSTANCE_COUNT  + var.OD_INSTANCE_COUNT  

# Declaring the remote provisioner inside the resource
    provisioner "remote-exec" {
        connection {                   
            type     = "ssh"
            user     = local.SSH_USERNAME
            password = local.SSH_PASSWORD
            host     = element(local.INSTANCE_IPS, count.index)   
        }

        inline = [
            "ansible-pull -U https://github.com/sharanyachandu/ansible.git robot-pull.yml -e MONGODB_ENDPOINT=${data.terraform_remote_state.db.outputs.MONGODB_ENDPOINT} -e ENV=${var.ENV} -e COMPONENT=${var.COMPONENT} -e APP_VERSION=${var.APP_VERSION}"
        ]
    }
} 

# Provisioners are create time by default, which means they only run during the infrastructure creation or if the provisioner is a failure in the previous run.
# In our case, if you've deployed 0.0.4 and wish to upgrade to 0.0.5, it won't run nor it work work.
