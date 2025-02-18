#!/usr/bin/env sh
set -eEuo pipefail
source ./log.sh

function init() {

  OS=""
  TMP_DIR=$(mktemp -d)
  REPO="https://github.com/sennadx/sdx-developer-toolkit.git"
  BRANCH="develop"
  ANSIBLE_CFG="ansible.cfg"
  ANSIBLE_PLAYBOOK="dummy.yml"

}

function check_os() {

  [[ -f /etc/os-release ]] &&
    OS=$(grep '^ID=' /etc/os-release | cut -d= -f2)

  # mac os não possui /etc/os-release

}

function checkout() {

  [[ -d "$3" ]] && cd "$3" && git clone "$1" -b "$2"

}

function tasks() {

  #cp ~/workspace/sennadx/sdx-developer-toolkit/dummy.yml .
  #cp ~/workspace/sennadx/sdx-developer-toolkit/ansible.cfg .
  #cp ~/workspace/sennadx/sdx-developer-toolkit/roles/cloud/tasks/main.yml .

  cp /sdx-developer-toolkit/dummy.yml .
  cp /sdx-developer-toolkit/ansible.cfg .
  cp /sdx-developer-toolkit/roles/cloud/tasks/main.yml .

  ANSIBLE_CONFIG=${ANSIBLE_CFG} \
    ansible-playbook $ANSIBLE_PLAYBOOK

}

function automation() {

  [[ -d "$1" ]] && cd "$1" && tasks

}

function fedora_requirements() {

  sudo dnf group install -y standard c-development \
    development-libs development-tools --with-optional && \
  sudo dnf install -y ansible ansible-collection-ansible-posix

}

function ubuntu_requirements() {

  apt update && DEBIAN_FRONTEND=noninteractive apt install -y zip \
    git build-essential ubuntu-standard ubuntu-minimal python3 ansible

}


function requirements() {

  echo ""
  echo "Installing Developer Toolkit requirements"
  log info "This is a info message"
  log warn "This is a warning message"
  echo ""

  case "$1" in

  'fedora')
    fedora_requirements
    ;;

  'ubuntu' | 'linuxmint')
    ubuntu_requirements
    ;;

  esac

}

function cleanup() {

  rm -rf $TMP_DIR

}

function main() {

  init

  check_os

  requirements "${OS}"

  #checkout "${REPO}" "${BRANCH}" "${TMP_DIR}"

  automation "${TMP_DIR}"

  cleanup

}

main
