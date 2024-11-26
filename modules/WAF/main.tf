resource "aws_wafv2_web_acl" "darede_waf" {
  name        = var.waf_name
  description = "ACL"
  scope       = var.waf_scope 

  default_action {
    allow {}
  }

  # Regra 1: SQL Injection
  rule {
    name     = "SQL-Regra"
    priority = 1

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

        rule_action_override {
          name = "SQLi_QUERYARGUMENTS"
          
          action_to_use {
            count {}
          }
        }
      } 
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "SQL-Metrica"
      sampled_requests_enabled   = true
    }
  }

  # Regra 2: Bloquear requisições de outros países
  rule {
    name     = "block-countries"
    priority = 2

    statement {
      geo_match_statement {
        country_codes = ["CN", "RU"]
      }
    }

    action {
      block {}
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "BlockCountriesMetric"
      sampled_requests_enabled   = true
    }
  }

  # Regra 3: Bloquear User Agents ruins
  rule {
    name     = "Block-bad-user-agents"
    priority = 3

    statement {
      byte_match_statement {
        search_string = "Badbot"
        field_to_match {
          single_header {
            name = "user-agent"
          }
        }

        text_transformation {
          priority = 0
          type     = "LOWERCASE"
        }

        positional_constraint = "CONTAINS"
      }
    }

    action {
      block {}
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "BadUserAgentsMetric"
      sampled_requests_enabled   = true
    }
  }

  # Regra 4: Lista de IPs anônimos
  rule {
    name     = "AnonymousIPList"
    priority = 4

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAnonymousIPList"
        vendor_name = "AWS"
      }
    }

    action {
      block {}
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AnonymousIP-metricas"
      sampled_requests_enabled   = true
    }
  }


  # Configuração de visibilidade geral para o Web ACL
  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "WEBACL"
    sampled_requests_enabled   = true
  }

}

resource "aws_wafv2_web_acl_association" "association" {
  resource_arn = var.resource_arn
  web_acl_arn  = aws_wafv2_web_acl.darede_waf.arn  
}