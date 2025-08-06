output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.this.dns_name
}

output "tg_arn" {
  description = "Target group ARN"
  value       = aws_lb_target_group.this.arn
}
