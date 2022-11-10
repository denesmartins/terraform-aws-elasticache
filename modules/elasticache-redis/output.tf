
output "redis_id" {
  value = aws_elasticache_replication_group.redis.id
}

output "redis_endpoint" {
  value = aws_elasticache_replication_group.redis.configuration_endpoint_address
}

output "redis_primary_endpoint_address" {
  value = aws_elasticache_replication_group.redis.primary_endpoint_address
}


output "redis_sg" {
  value = aws_security_group.elasticache_sg.id
}
