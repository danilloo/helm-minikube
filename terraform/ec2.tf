/*Template de user data usado para passar variaveis para o user data template. Nesse caso em especifico não foi necessário.*/
data "template_file" "user_data" {
  template = "${file("user_data.sh")}"
  vars = { }
}

resource "aws_instance" "ec2" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  associate_public_ip_address = false
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  iam_instance_profile        = aws_iam_instance_profile.ssm_profile.name
  user_data                   = "${data.template_file.user_data.rendered}"
}