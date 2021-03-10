# Fetch linux AMI ID using SSM Parameter endpoint
data "aws_ssm_parameter" "linux-AMI" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

# Add generated key-pair 
resource "aws_key_pair" "instance-key-pair" {
  key_name   = "frankfurt1"
  public_key = file("C:\\Users\\CharlesIkenyei\\.ssh\\id_rsa.pub")
}

# Provision EC2-Instance
resource "aws_instance" "web-server" {
  ami                         = data.aws_ssm_parameter.linux-AMI.value
  availability_zone           = element(data.aws_availability_zones.az-available.names, 0)
  instance_type               = var.instance-type
  key_name                    = aws_key_pair.instance-key-pair.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.allow_tls.id]
  subnet_id                   = aws_subnet.pub-subnet.id

  tags = {
    Name = "web-server"
  }
  depends_on = [aws_main_route_table_association.main-rt]

}
