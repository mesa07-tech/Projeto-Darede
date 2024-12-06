output "cluster_name" {
  description = "Nome Cluster: "
  value       = aws_eks_cluster.darede-cluster.name
}

output "cluster_endpoint" {
  description = "Endpoint do cluster EKS"
  value       = aws_eks_cluster.darede-cluster.endpoint
}

output "cluster_arn" {
  description = "ARN do cluster EKS"
  value       = aws_eks_cluster.darede-cluster.arn
  
}

output "cluster_certificate_authority_data" {
  description = "Certificado do cluster EKS"
  value       = aws_eks_cluster.darede-cluster.certificate_authority.0.data  
}

