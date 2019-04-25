#!/usr/bin/env bash

set -eu -o pipefail

declare -a images=(
  base
  java
  cassandra
  disque
  elasticsearch
  memcached
  minio
  nginx
  postfix
  postgres
  redis
  #spark
)

build() {
  local image="${1}"
  local repo="${2}"
  pushd .
  cd "${image}"
  for version in *; do
    if [ -d $version ]; then
      pushd .
      cd "${version}"
      sudo docker build --tag=${repo}/${image}:${version} .
      popd
    fi
  done
  popd
}

build_all() {
  local repo="${1}"
  for image in "${images[@]}"; do
    build "${image}" "${repo}"
  done
}

push() {
  local image="${1}"
  local repo="${2}"
  pushd .
  cd "${image}"
  for version in *; do
    if [ -d $version ]; then
      sudo docker push ${repo}/${image}:${version}
    fi
  done
  popd
}

push_all() {
  local repo="${1}"
  for image in "${images[@]}"; do
    push "${image}" "${repo}"
  done
}

usage() {
  echo "Usage: $0 <action> <image> <repo>"
  exit 1
}

main() {
  local action="${1}"
  local image="${2}"
  local repo="${3}"

  if [ -z "${action}" ] \
    || [ -z "${image}" ]; then
    usage
  fi

  case "${action}" in
    build)
      if [ "${image}" == "all" ]; then
        build_all "${repo}"
      else
        build "${image}" "${repo}"
      fi
      ;;
    push)
      if [ "${image}" == "all" ]; then
        push_all "${repo}"
      else
        push "${image}" "${repo}"
      fi
      ;;
    *)
      echo "Invalid action ${action}!"; exit 1
      ;;
  esac
}

main $*
