# example-ecspresso

[ecspresso](https://github.com/kayac/ecspresso) の動作を確認するためのリポジトリです。

## Setup environment

AWS環境を作ります。

```shell
$ cd terraform/
$ terraform init
$ terraform apply
```

## Build and push docker image

ダミーのDockerイメージをビルドし、ECR Public にプッシュします。

```shell
$ cd docker_image/
$ ./build_and_push_image.sh
```

## Deploy

```shell
$ ./ecspresso/deploy.sh
```

## Rollback

```shell
$ ./ecspresso/rollback.sh
```

## Destroy environment

```shell
# イメージが残っているとECR Publicリポジトリの削除に失敗するので、先にCLIで消しておきます。
$ aws --region us-east-1 ecr-public delete-repository --repository-name example_ecspresso --force

$ cd terraform/
$ terraform destroy
```

