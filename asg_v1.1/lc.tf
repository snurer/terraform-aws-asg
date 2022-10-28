resource "aws_launch_configuration" "main" {
  name            = "${var.env}-main-lc-new"
  image_id        = "ami-08c40ec9ead489470"
  instance_type   = var.instance_type
  user_data       = data.template_file.userdata.rendered
  security_groups = [aws_security_group.main.id]
  key_name        = aws_key_pair.terraform_server_key.key_name
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_key_pair" "terraform_server_key" {
  key_name   = "TerraformServerKey"
  public_key = file("~/.ssh/id_rsa.pub")
}