####文件consul.hcl#####
 consul {
  address = "consul主机IP地址:8500"
  server_service_name = "nomad"
  server_auto_join = true
  client_service_name = "nomad-client"
  client_auto_join = true
  auto_advertise = true
  token   = "consul的token"
}
