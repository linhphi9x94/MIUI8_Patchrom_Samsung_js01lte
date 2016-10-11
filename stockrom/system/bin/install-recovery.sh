#!/system/bin/sh
if [ -f /system/etc/recovery-transform.sh ]; then
  exec sh /system/etc/recovery-transform.sh 10461184 7dcd7786832f1782d863e161005b7895a596d6d5 7655424 815756ed0b1c30c68509b37ce65b85cbbfaff87e
fi

if ! applypatch -c EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery:10461184:7dcd7786832f1782d863e161005b7895a596d6d5; then
  applypatch -b /system/etc/recovery-resource.dat EMMC:/dev/block/platform/msm_sdcc.1/by-name/boot:7655424:815756ed0b1c30c68509b37ce65b85cbbfaff87e EMMC:/dev/block/platform/msm_sdcc.1/by-name/recovery 7dcd7786832f1782d863e161005b7895a596d6d5 10461184 815756ed0b1c30c68509b37ce65b85cbbfaff87e:/system/recovery-from-boot.p && log -t recovery "Installing new recovery image: succeeded" || log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
