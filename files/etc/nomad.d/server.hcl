server {
  enabled = true
  # Self-elect, should be 3 or 5 for production
  bootstrap_expect = 3
  node_gc_threshold = "24h"
  job_gc_threshold = "4h"
  eval_gc_threshold = "1h"
  deployment_gc_threshold = "1h"
  heartbeat_grace = "10s"
  min_heartbeat_ttl = "10s"
  max_heartbeats_per_second = 50.0
  rejoin_after_leave = true
}
