
resource "aws_key_pair" "public_key" {
    key_name   = "unique_public_key"
    public_key = file("~/.ssh/id_rsa.pub")  
}

resource "aws_instance" "ubuntu_server" {
    ami = "ami-023a307f3d27ea427"
    instance_type = "t2.micro"
    key_name = aws_key_pair.public_key.key_name

    tags = {
        Name = "Ubuntu Server"
    }
}

resource "aws_s3_bucket" "terraform_bucket" {
    bucket = "terraform-state-bucket-6010"
    force_destroy = true
}

resource "aws_dynamodb_table" "terraform_state_lock" {
    name = "terraform-state-lock"
    hash_key = "LockID"
    billing_mode = "PAY_PER_REQUEST"

    attribute {
        name = "LockID"
        type = "S"
    }
  
}

output "ubuntu_server_public_ip" {
  value = aws_instance.ubuntu_server.public_ip
  
}