output "vpc_id" {
      value = aws_vpc.Main.id
}

output "public_subnet1_id" {
       value = aws_subnet.publicsubnet1.id
}

output "public_subnet2_id"  {
       value = aws_subnet.publicsubnet2.id 
}

output "private_subnet_id"  {
        value = aws_subnet.privatesubnets.id
}
