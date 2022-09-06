output "cvm_id" {
  value = tencentcloud_instance.cvm.id
}

output "cvm_private_ip" {
  value = tencentcloud_instance.cvm.private_ip
}

output "cvm_public_ip" {
  value = (
    tencentcloud_instance.cvm.public_ip != ""
    ? tencentcloud_instance.cvm.public_ip
    : "nil"
  )
}