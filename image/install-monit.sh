#!/bin/bash
set -e

monit_version="5.13"
monit_base_url="https://www.mmonit.com/monit/dist/binary/${monit_version}/"
monit_tarball="monit-${monit_version}-linux-x64.tar.gz"
monit_sha256="${monit_tarball}.sha256"
monit_user="monit"
monit_group="monit"
monit_user_home="/home/monit"
monit_user_shell="/bin/false"
monit_include_path="/home/monit/monit.d"
monit_include_perms="0750"
monit_install_root="/opt"

/usr/sbin/useradd -c "Monit daemon" -m -d "${monit_user_home}" \
  -s "${monit_user_shell}" -r -U "${monit_user}"

cd /tmp

curl -OO "${monit_base_url}/${monit_tarball}" \
  "${monit_base_url}/${monit_sha256}"

sha256sum --quiet -c "${monit_sha256}"

tar -C "${monit_install_root}" -zxvf "${monit_tarball}"

ln -s "${monit_install_root}/monit-${monit_version}" \
  "${monit_install_root}/monit"

install -o "${monit_user}" -g "${monit_group}" -m "${monit_include_perms}" \
  -d "${monit_include_path}"

rm "/tmp/${monit_tarball}" "/tmp/${monit_sha256}"
