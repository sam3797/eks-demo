resource "aws_eks_cluster" "my-eks-cluster" {
 name = "my-eks-cluster"
 role_arn = aws_iam_role.eks-iam-role.arn
 
 vpc_config {
  #cluster_security_group_id = aws_security_group.my-sg-1.id
  security_group_ids = [aws_security_group.my-sg-1.id]
  subnet_ids = [aws_subnet.main-subnet-1.id, aws_subnet.main-subnet-2.id]
 }

 depends_on = [
  aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
  aws_iam_role_policy_attachment.eks-policy
 ]

}

# resource "aws_eks_addon" "example" {
#   cluster_name = aws_eks_cluster.my-eks-cluster.name
#   addon_name   = "vpc-cni"
# }

# resource "aws_eks_addon" "example-1" {
#   cluster_name      = aws_eks_cluster.my-eks-cluster.name
#   addon_name        = "coredns"
# }

# resource "aws_eks_addon" "example-2" {
#   cluster_name = aws_eks_cluster.my-eks-cluster.name
#   addon_name   = "kube-proxy"
# }


resource "aws_eks_node_group" "worker-node-group" {
  cluster_name  = aws_eks_cluster.my-eks-cluster.name
  node_group_name = "my-workernodes-group"
  node_role_arn  = aws_iam_role.worker-nodes-role.arn
  subnet_ids   = [aws_subnet.main-subnet-1.id, aws_subnet.main-subnet-2.id]
  instance_types = ["t2.micro"]
 
  scaling_config {
   desired_size = 2
   max_size   = 2
   min_size   = 2
  }
 
  depends_on = [
   aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
   aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
   aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly
  ]
 }