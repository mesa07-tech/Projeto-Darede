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

resource "aws_iam_role" "cluster" {
  name = "eks-cluster-example"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
          "sts:TagSession"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster.name
}

resource "aws_eks_cluster" "darede-cluster" {
  name     = var.cluster_name
  role_arn = var.service_role_arn


  vpc_config {
    subnet_ids         = var.public_subnets
    security_group_ids = [aws_security_group.sec-eks.id]
<<<<<<< HEAD
  }

  upgrade_policy {
    support_type = "STANDARD"
  }

=======
  } 

  
>>>>>>> e9cd40fd21bb0dbaa8c2b89405ec66588e9b3448
}

resource "aws_eks_addon" "core_dns" {
  cluster_name = aws_eks_cluster.darede-cluster.name
  addon_name   = "coredns"
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name = aws_eks_cluster.darede-cluster.name
  addon_name   = "vpc-cni"
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name = aws_eks_cluster.darede-cluster.name
  addon_name   = "kube-proxy" 
}


resource "aws_eks_node_group" "eks-node-group" {
  depends_on      = [aws_eks_cluster.darede-cluster]
  cluster_name    = aws_eks_cluster.darede-cluster.name
  node_group_name = var.nodes_name
  node_role_arn   = var.instance_role_arn
  subnet_ids      = var.public_subnets

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }

  capacity_type = "ON_DEMAND"
  instance_types = ["t3.medium"]
  ami_type       = "AL2_x86_64"


}

<<<<<<< HEAD
=======
resource "aws_eks_addon" "vpc-cni" {
  cluster_name = aws_eks_cluster.darede-cluster.name
  addon_name   = "vpc-cni"
}

resource "aws_eks_addon" "kube-proxy" {
  cluster_name = aws_eks_cluster.darede-cluster.name
  addon_name   = "kube-proxy"
}



>>>>>>> e9cd40fd21bb0dbaa8c2b89405ec66588e9b3448

data "aws_eks_cluster_auth" "darede-cluster" {
  name = aws_eks_cluster.darede-cluster.name
}
