####文件nomad.hcl#####
log_level = "INFO"
data_dir = "/var/lib/nomad"
bind_addr = "0.0.0.0"
leave_on_terminate = true
region = "区域"
datacenter = "数据中心名称"
advertise {
  http = "主机IP:4646"
  rpc = "主机IP:4647"
  serf = "主机IP:4648"
}
telemetry {
  publish_allocation_metrics = true
  publish_node_metrics       = true
}

