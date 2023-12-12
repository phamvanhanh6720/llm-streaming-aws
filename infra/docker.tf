locals {
  region             = "us-east-1"
  build_path         = pathexpand("${path.module}/../app/")
  dkr_ig_src_sha256 = sha256(join("", [for f in fileset(".", "${local.build_path}/**") : file(f)]))
}

resource "null_resource" "docker_build_and_push" {
  triggers = {
    detect_docker_source_changes = var.force_image_rebuild == true ? timestamp() : local.dkr_ig_src_sha256
  }

  provisioner "local-exec" {
    command = <<EOF
	    aws ecr get-login-password --region ${local.region} | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.us-east-1.amazonaws.com
	    docker build -t "${aws_ecr_repository.ecr_repository.repository_url}:latest" -f ${local.build_path}/Dockerfile ${local.build_path}
	    docker push "${aws_ecr_repository.ecr_repository.repository_url}:latest"
	    EOF
  }

  depends_on = [aws_ecr_repository.ecr_repository]
}

data "aws_caller_identity" "current" {}