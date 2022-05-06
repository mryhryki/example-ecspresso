# example-ecspresso

[kayac/ecspresso: ecspresso is a deployment tool for Amazon ECS](https://github.com/kayac/ecspresso)

## Setup environment

```shell
$ cd terraform/

$ terraform init
$ terraform apply

$ cd ../docker_image/
$ ./build_and_push_image.sh
```

## Build and push docker image

```shell
$ cd docker_image/
$ ./build_and_push_image.sh
```

## Deploy

```shell
$ ecspresso deploy
```
