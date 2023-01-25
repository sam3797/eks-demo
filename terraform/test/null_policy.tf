resource "null_resource" "policy" {
triggers = {
    always_run = timestamp()
}
provisioner "local-exec" {
    on_failure  = fail
    when = create
    #interpreter = ["/bin/bash", "-c"]
    command     = "curl -o iam_policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.4.2/docs/install/iam_policy.json"
}
}