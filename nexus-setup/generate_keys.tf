# Generates a secure private key and encodes it as PEM
resource "tls_private_key" "nexus_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
# Create the Key Pair
resource "aws_key_pair" "nexus_key" {
  key_name   = "nexus_key_pair"  
  public_key = tls_private_key.nexus_key.public_key_openssh
}
# Save file
resource "local_file" "ssh_key" {
  filename = "${aws_key_pair.nexus_key.key_name}.pem"
  content  = tls_private_key.nexus_key.private_key_pem
  file_permission = "400"
}