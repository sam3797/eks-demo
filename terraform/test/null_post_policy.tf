resource "null_resource" "post-policy" {
depends_on=[aws_iam_policy.load-balancer-policy]
triggers = {
    always_run = timestamp()
}
provisioner "local-exec" {
    on_failure  = fail
    #interpreter = ["/bin/bash", "-c"]
    when = create
    command     = <<EOT
        cn=$(echo ${data.terraform_remote_state.eks.outputs.cluster_name})
        ./post-policy.sh
        echo "reannotate nodes"
        ./reannotate-nodes.sh $cn
        echo "done"
     EOT
}
}