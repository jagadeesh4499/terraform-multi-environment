resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh_${var.tags.Environment}"
  description = "Allows only ssh connections i.e, port number 22"
  egress { # usually we allow everything in egress
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"] # allows from any anyone i.e, any IP address
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = merge(
    var.common_tags,
    var.tags,
    {
      Name = "allow_ssh_${var.tags.Environment}"
    }
  )
}
resource "aws_instance" "expense" {
  for_each = var.instances # This variable is a map
  # for each will give us a special variable called each.
  ami                    = data.aws_ami.ami_id.id # This AMI ID may change over the time
  instance_type          = each.value
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  tags = merge(
    var.common_tags,
    var.tags,
    {
      Name = each.key
    }
  )
}