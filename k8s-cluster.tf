resource "aws_eks_cluster" "test-cluster" {
  name     = var.cluster-name
  role_arn = aws_iam_role.test-cluster-role.arn

  vpc_config {
    security_group_ids = [aws_security_group.test-cluster-group.id]
    subnet_ids         = module.vpc.public_subnets
  }

  depends_on = [
    aws_iam_role_policy_attachment.test-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.test-cluster-AmazonEKSServicePolicy,
  ]
}

