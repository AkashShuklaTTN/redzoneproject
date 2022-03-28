output "private-sg-id" {
  value = aws_security_group.private-sg.id
}

output "public-sg-id" {
  value = aws_security_group.public-sg.id
}
