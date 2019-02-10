####文件client.hcl#####
client {
  enabled = true
  options {
    "driver.raw_exec.enable" = "1"
    "driver.exec.enable" = "1"
    "driver.exec.java" = "1"
    "docker.volumes.enabled" = "true"
    "max_kill_timeout" = "30s"
  }
  meta {
    "key" = "vaule"
    "key2" = "vaule2"
 }
 }
