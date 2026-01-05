
resource "aws_cloudwatch_dashboard" "observability_dashboard" {
  dashboard_name = "regain-prod-observability-dashboard"

  dashboard_body = templatefile("${path.module}/dashboard.json.tmpl", {
    
    # ===== ALB / ECS =====
    ecs_lb      = "app/regain-frontend-alb/abcd1234efgh5678"
    ecs_cluster = "regain-prod-cluster"
    aws_acc_id  = "123456789012"

    # ===== CloudFront =====
    cloudfront_distribution_id = "E2ABCDEF123456"

    # ===== WAF =====
    waf_web_acl_name = "regain-prod-web-acl"

    # ===== RDS =====
    db_id = "regain-prod-db"

    # ===== Redis (if present in template) =====
    redis_cluster_id = "regain-prod-redis"
  })
}
