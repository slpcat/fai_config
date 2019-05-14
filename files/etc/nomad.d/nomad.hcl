log_level = "INFO"
data_dir = "/var/lib/nomad"
bind_addr = "0.0.0.0"
leave_on_terminate = true
region = "区域"
datacenter = "数据中心名称"
#advertise {
#  http = "主机IP:4646"
#  rpc = "主机IP:4647"
#  serf = "主机IP:4648"
#}
telemetry {
  collection_interval = "5s"
  disable_hostname = true
  prometheus_metrics = true
  publish_allocation_metrics = true
  publish_node_metrics = true
}
autopilot {
    cleanup_dead_servers = true
    last_contact_threshold = "200ms"
    max_trailing_logs = 250
    server_stabilization_time = "10s"
    enable_redundancy_zones = false
    disable_upgrade_migration = false
    enable_custom_upgrades = false
}
plugin "docker" {
  config {
    endpoint = "unix:///var/run/docker.sock"

    #auth {
    #  config = "/etc/docker-auth.json"
    #  helper = "docker-credential-aws"
    #}

    gc {
      image       = true
      image_delay = "2d"
      container   = true
    }

    volumes {
      enabled      = true
      #selinuxlabel = "z"
    }

    allow_privileged = true
    #allow_caps       = ["CHOWN", "NET_RAW"]

    # allow_caps can also be set to "ALL"
      allow_caps = ["ALL"]
  }
}
