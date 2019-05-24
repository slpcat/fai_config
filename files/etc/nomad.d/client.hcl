client {
  enabled = true
  options {
    "driver.raw_exec.enable" = "1"
    "driver.exec.enable" = "1"
    "driver.exec.java" = "1"
    "gc_interval" = "1m"
    "gc_disk_usage_threshold" = "80.0"
    "gc_inode_usage_threshold" = "70.0"
    "gc_max_allocs" = "50"
    "gc_parallel_destroys" = "2"
    "max_kill_timeout" = "30s"
    #default env blacklist: CONSUL_TOKEN VAULT_TOKEN AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN GOOGLE_APPLICATION_CREDENTIALS
    "env.blacklist" = "MY_CUSTOM_ENVVAR"
    #default user blacklist: root Administrator
    "user.blacklist" = "root,ubuntu"
  }
  node_class    = "prod"
  #network_interface = "eth0"
  reserved {
    cpu            = 500
    memory         = 512
    disk           = 1024
    reserved_ports = "22,8500-8600"
  }
  meta {
    "rack" = "B003"
    "key" = "vaule"
    "key2" = "vaule2"
 }
  #file_system {
  #  driver = "zfs" #file system driver name for the client.
  #  options {
  #    pool_name = "allocdirs" #This is the zpool nomad uses to create the alloc dirs
  #    parent_dataset = "allocs" #All the allocdir datasets are created under this.
  #    attr_blacklist = ["dedup", "compression"] #The attributes which we don't want the users to be overriding
  #    # options related to controlling attributes of dataset
  #    # such as dedup, compression type, etc
  #  }
}
