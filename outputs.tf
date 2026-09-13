output "public_ip" {
  value = aws_instance.web.public_ip
}
output "url" {
  value = "http://${aws_instance.web.public_ip}"
}

output "subnet_ids" {
  value = { for k, s in aws_subnet.net : k => s.id }
}