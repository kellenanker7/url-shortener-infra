data "aws_route53_zone" "kellenanker_dot_com" {
  name = "kellenanker.com."
}

resource "aws_route53_record" "this" {
  name = "${var.name}.kellenanker.com"
  zone_id = data.aws_route53_zone.kellenanker_dot_com.zone_id
  type = "A"

  alias {
    name                   = aws_lb.this.dns_name
    zone_id                = aws_lb.this.zone_id
    evaluate_target_health = true
  }
}
