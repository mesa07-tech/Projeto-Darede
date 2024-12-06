resource "aws_security_group" "sec-eks" {
  name   = "${var.cluster_name}-sg-edu"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eks_cluster" "darede-cluster" {
  name     = var.cluster_name
  role_arn = var.service_role_arn


  vpc_config {
    subnet_ids         = var.public_subnets
    security_group_ids = [aws_security_group.sec-eks.id]
  } 

  
}

resource "aws_eks_node_group" "eks-node-group" {
  depends_on      = [aws_eks_cluster.darede-cluster]
  cluster_name    = aws_eks_cluster.darede-cluster.name
  node_group_name = var.nodes_name
  node_role_arn   = var.instance_role_arn
  subnet_ids      = var.public_subnets

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
}

resource "aws_eks_addon" "vpc-cni" {
  cluster_name = aws_eks_cluster.darede-cluster.name
  addon_name   = "vpc-cni"
  addon_version = "v1.19.0" 
}

resource "aws_eks_addon" "coredns" {
  cluster_name = aws_eks_cluster.darede-cluster.name
  addon_name   = "coredns"
}

resource "aws_eks_addon" "kube-proxy" {
  cluster_name = aws_eks_cluster.darede-cluster.name
  addon_name   = "kube-proxy"
}

resource "aws_eks_addon" "pod-identity-webhook" {
  cluster_name = aws_eks_cluster.darede-cluster.name
  addon_name   = "aws-pod-identity-webhook"
}


data "aws_eks_cluster_auth" "darede-cluster" {
  name = aws_eks_cluster.darede-cluster.name
}
