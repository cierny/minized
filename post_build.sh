#!/bin/bash
set -e

# Disable some default systemd services from /lib
declare -a rm_lib_svc=(
    "sysinit.target.wants/dev-hugepages.mount"
    "sysinit.target.wants/sys-fs-fuse-connections.mount"
    "sysinit.target.wants/systemd-ask-password-console.path"
    "sysinit.target.wants/systemd-machine-id-commit.service"
    "sysinit.target.wants/systemd-sysctl.service"
    "sysinit.target.wants/systemd-update-done.service"
    "multi-user.target.wants/systemd-ask-password-wall.path"
    "timers.target.wants/systemd-tmpfiles-clean.timer")

for f in "${rm_lib_svc[@]}"; do
    rm -f ${TARGET_DIR}/usr/lib/systemd/system/$f
done

# Disable some default systemd services from /etc
declare -a rm_etc_svc=(
    "ctrl-alt-del.target"
    "sys-fs-fuse-connections.mount"
    "remote-fs.target"
    "systemd-remount-fs.service"
    "systemd-hwdb-update.service"
    "systemd-ask-password-console.path"
    "systemd-machine-id-commit.service"
    "getty.target.wants/getty@tty1.service"
    "multi-user.target.wants/remote-fs.target"
    "multi-user.target.wants/rdisc.service"
    "multi-user.target.wants/ninfod.service"
    "default.target.wants/e2scrub_reap.service"
    "timers.target.wants/e2scrub_all.timer")

for f in "${rm_etc_svc[@]}"; do
    rm -f ${TARGET_DIR}/etc/systemd/system/$f
done
