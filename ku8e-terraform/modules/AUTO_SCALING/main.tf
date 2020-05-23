resource "aws_launch_configuration" "ecs-launch-configuration" {
    name                        = var.launch-config-name
    image_id                    = var.launch-image
    instance_type               = var.launch-instance-type
    # iam_instance_profile        = "${aws_iam_instance_profile.ecs-instance-profile.id}"

    root_block_device {
      volume_type = "standard"
      volume_size = 100
      delete_on_termination = true
    }

    lifecycle {
      create_before_destroy = true
    }

    security_groups             = [var.security-groups]
    associate_public_ip_address = var.associate-public-ip-address
    key_name                    = var.key
    # user_data                   = <<EOF
    #                               #!/bin/bash
    #                               echo ECS_CLUSTER=${var.ecs_cluster} >> /etc/ecs/ecs.config
    #                               EOF
}



resource "aws_autoscaling_group" "ecs-autoscaling-group" {
    name                        = "ecs-autoscaling-group"
    max_size                    = var.max-instance-size
    min_size                    = var.min-instance-size
    desired_capacity            = var.desired-capacity
    vpc_zone_identifier         = [var.subnets[0],var.subnets[1]]
    launch_configuration        = aws_launch_configuration.ecs-launch-configuration.name
    health_check_type           = "ELB"
  
    tag {
    key                 = "eks_testing"
    value               = "eks-deploy"
    propagate_at_launch = false
  }
  }
