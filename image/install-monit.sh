#!/bin/sh
set -e

monit_version="5.14"
monit_base_url="https://www.mmonit.com/monit/dist/binary/${monit_version}/"
monit_tarball="monit-${monit_version}-linux-x64.tar.gz"
monit_sha256="${monit_tarball}.sha256"
monit_user="root"
monit_group="root"
monitrc_include_path="/etc/monitrc.d"
monit_include_path="/etc/monit.d"
monit_lib_path="/var/monit"
monit_include_perms="0750"
monit_install_root="/opt"

cd /tmp

# Download monit and monit checksum
curl -OO "${monit_base_url}/${monit_tarball}" "${monit_base_url}/${monit_sha256}"

# Verify checksum
sha256sum -c --quiet "${monit_sha256}"

# Unpack monit in $monit_install_root
tar -C "${monit_install_root}" -zxvf "${monit_tarball}"

# Symlink version-specific monit directory to generic name
ln -s "${monit_install_root}/monit-${monit_version}" \
  "${monit_install_root}/monit"

# Create monit.d and monitrc.d
install -o "${monit_user}" -g "${monit_group}" -m "${monit_include_perms}" \
  -d "${monit_include_path}" "${monitrc_include_path}" "${monit_lib_path}"

# Cleanup
rm "/tmp/${monit_tarball}" "/tmp/${monit_sha256}"
