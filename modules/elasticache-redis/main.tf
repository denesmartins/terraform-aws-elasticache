

resource "aws_elasticache_replication_group" "redis" {
  replication_group_id          = "${var.replication_group_id}-redis-${var.environment}"
  description                   = var.replication_group_description
  node_type                     = var.node_type
  port                          = var.port
  parameter_group_name          = var.parameter_group_name
  automatic_failover_enabled    = var.automatic_failover_enabled
  subnet_group_name             = aws_elasticache_subnet_group.redis_subnet_group.name
  snapshot_retention_limit      = var.snapshot_retention_limit
  engine_version                = var.engine_version
  maintenance_window            = var.maintenance_window
  transit_encryption_enabled    = var.transit_encryption_enabled
  at_rest_encryption_enabled    = var.at_rest_encryption_enabled
  replicas_per_node_group       = var.cluster_mode_enabled ? var.replicas_per_node_group : null
  num_node_groups               = var.cluster_mode_enabled ? var.num_node_groups : null

  security_group_ids = [
    aws_security_group.elasticache_sg.id,
  ]
  tags = var.tags
}

resource "aws_security_group" "elasticache_sg" {
  name        = "${var.app_name}-elasticache-${var.environment} SG"
  description = "${var.app_name} ${var.environment} Security Group"
  vpc_id      = var.vpc_id
  tags = var.tags
}

resource "aws_security_group_rule" "elasticache_sg_rule" {
  security_group_id = aws_security_group.elasticache_sg.id
  from_port         = var.port
  to_port           = var.port
  protocol          = "tcp"
  type              = "ingress"
  cidr_blocks       = var.cidr_blocks
}

resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "${var.app_name}-redis-subnet-group-${lower(var.environment)}"
  subnet_ids = var.subnet_ids
}
