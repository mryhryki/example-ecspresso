#!/usr/bin/env bash
THIS_DIR="$(cd "$(dirname "${BASH_SOURCE}")"; pwd)"
cd "${THIS_DIR}"

# Prepare
VERSION="$(date +"%Y%m%d-%H%M%S")-$(git rev-parse HEAD | cut -c 1-8)"
printf 'export const version = "%s";' "${VERSION}" > "${THIS_DIR}/version.ts"

# Build image
docker build -t "example_ecspresso:latest" .

# Docker login
aws ecr-public get-login-password --region "us-east-1" |
    docker login --username "AWS" --password-stdin "public.ecr.aws/mryhryki"

# Add docker tag for ECR tag
docker tag "example_ecspresso:latest" "public.ecr.aws/mryhryki/example_ecspresso:latest"
docker tag "example_ecspresso:latest" "public.ecr.aws/mryhryki/example_ecspresso:${VERSION}"

# Push to ECR Public
docker push "public.ecr.aws/mryhryki/example_ecspresso:latest"
docker push "public.ecr.aws/mryhryki/example_ecspresso:${VERSION}"
