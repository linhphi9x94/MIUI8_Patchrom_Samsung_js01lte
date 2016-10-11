#!/sbin/sh
# 
# /system/addon.d/70-gapps.sh
#
. /tmp/backuptool.functions

list_files() {
cat <<EOF
app/GoogleCalendarSyncAdapter/GoogleCalendarSyncAdapter.apk
app/GoogleContactsSyncAdapter/GoogleContactsSyncAdapter.apk
app/GoogleTTS/GoogleTTS.apk
etc/g.prop
etc/permissions/com.google.android.dialer.support.xml
etc/permissions/com.google.android.maps.xml
etc/permissions/com.google.android.media.effects.xml
etc/permissions/com.google.widevine.software.drm.xml
etc/preferred-apps/google.xml
etc/sysconfig/google.xml
etc/sysconfig/google_build.xml
etc/sysconfig/google_vr_build.xml
etc/sysconfig/whitelist_com.android.omadm.service.xml
framework/com.google.android.dialer.support.jar
framework/com.google.android.maps.jar
framework/com.google.android.media.effects.jar
framework/com.google.widevine.software.drm.jar
lib/libjni_keyboarddecoder.so
lib/libjni_latinimegoogle.so
priv-app/ConfigUpdater/ConfigUpdater.apk
priv-app/GoogleBackupTransport/GoogleBackupTransport.apk
priv-app/GoogleFeedback/GoogleFeedback.apk
priv-app/GoogleLoginService/GoogleLoginService.apk
priv-app/GoogleOneTimeInitializer/GoogleOneTimeInitializer.apk
priv-app/GooglePackageInstaller/GooglePackageInstaller.apk
priv-app/GooglePartnerSetup/GooglePartnerSetup.apk
priv-app/GoogleServicesFramework/GoogleServicesFramework.apk
priv-app/Phonesky/Phonesky.apk
priv-app/PrebuiltGmsCore/PrebuiltGmsCore.apk
priv-app/SetupWizard/SetupWizard.apk
EOF
}

# Backup/Restore using /sdcard if the installed GApps size plus a buffer for other addon.d backups (204800=200MB) is larger than /tmp
installed_gapps_size_kb=$(grep "^installed_gapps_size_kb" /tmp/gapps.prop | cut -d= -f2)
if [ ! "$installed_gapps_size_kb" ]; then
  installed_gapps_size_kb=$(cd /system; du -ak $(list_files) | awk '{ i+=$1 } END { print i }')
  echo "installed_gapps_size_kb=$installed_gapps_size_kb" >> /tmp/gapps.prop
fi

free_tmp_size_kb=$(grep "^free_tmp_size_kb" /tmp/gapps.prop | cut -d= -f2)
if [ ! "$free_tmp_size_kb" ]; then
  free_tmp_size_kb=$(df -k /tmp | tail -n 1 | awk '{ print $4 }')
  echo "free_tmp_size_kb=$free_tmp_size_kb" >> /tmp/gapps.prop
fi

buffer_size_kb=204800
if [ $((installed_gapps_size_kb + buffer_size_kb)) -ge "$free_tmp_size_kb" ]; then
  C=/sdcard/tmp-gapps
fi

case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file "$S"/"$FILE"
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file "$S"/"$FILE" "$R"
    done
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Remove Stock/AOSP apps (from GApps Installer)
    rm -rf /system/priv-app/ExtServices
    rm -rf /system/app/PackageInstaller
    rm -rf /system/priv-app/PackageInstaller
    rm -rf /system/priv-app/packageinstaller
    rm -rf /system/app/Provision
    rm -rf /system/priv-app/Provision

    # Remove 'other' apps (per installer.data)
    rm -rf /system/app/CalendarGoogle
    rm -rf /system/app/CloudPrint
    rm -rf /system/app/DeskClockGoogle
    rm -rf /system/app/EditorsDocsStub
    rm -rf /system/app/EditorsSheetsStub
    rm -rf /system/app/EditorsSlidesStub
    rm -rf /system/app/Gmail
    rm -rf /system/app/Gmail2
    rm -rf /system/app/GoogleCalendar
    rm -rf /system/app/GoogleCloudPrint
    rm -rf /system/app/GoogleHangouts
    rm -rf /system/app/GoogleKeep
    rm -rf /system/app/GoogleLatinIme
    rm -rf /system/app/GooglePlus
    rm -rf /system/app/Keep
    rm -rf /system/app/NewsWeather
    rm -rf /system/app/NewsstandStub
    rm -rf /system/app/PartnerBookmarksProvider
    rm -rf /system/app/PrebuiltBugleStub
    rm -rf /system/app/PrebuiltKeepStub
    rm -rf /system/app/QuickSearchBox
    rm -rf /system/app/Vending
    rm -rf /system/priv-app/GmsCore
    rm -rf /system/priv-app/GmsCore_update
    rm -rf /system/priv-app/GoogleHangouts
    rm -rf /system/priv-app/GoogleNow
    rm -rf /system/priv-app/GoogleSearch
    rm -rf /system/priv-app/OneTimeInitializer
    rm -rf /system/priv-app/QuickSearchBox
    rm -rf /system/priv-app/Velvet_update
    rm -rf /system/priv-app/Vending

    # Remove 'priv-app' apps from 'app' (per installer.data)
    rm -rf /system/app/CanvasPackageInstaller
    rm -rf /system/app/ConfigUpdater
    rm -rf /system/app/GoogleBackupTransport
    rm -rf /system/app/GoogleFeedback
    rm -rf /system/app/GoogleLoginService
    rm -rf /system/app/GoogleOneTimeInitializer
    rm -rf /system/app/GooglePartnerSetup
    rm -rf /system/app/GoogleServicesFramework
    rm -rf /system/app/OneTimeInitializer
    rm -rf /system/app/Phonesky
    rm -rf /system/app/PrebuiltGmsCore
    rm -rf /system/app/SetupWizard
    rm -rf /system/app/Velvet

    # Remove 'required' apps (per installer.data)
    rm -rf /system/app/LatinIME/lib//libjni_keyboarddecoder.so
    rm -rf /system/app/LatinIME/lib//libjni_latinimegoogle.so
    rm -rf /system/lib/libjni_keyboarddecoder.so
    rm -rf /system/lib/libjni_latinimegoogle.so
    rm -rf /system/lib64/libjni_keyboarddecoder.so
    rm -rf /system/lib64/libjni_latinimegoogle.so

    # Remove 'user requested' apps (from gapps-config)

  ;;
  post-restore)
    # Recreate required symlinks (from GApps Installer)
    install -d "/system/app/LatinIME/lib/arm"
    ln -sfn "/system/lib/libjni_latinimegoogle.so" "/system/app/LatinIME/lib/arm/libjni_latinimegoogle.so"
    ln -sfn "/system/lib/libjni_keyboarddecoder.so" "/system/app/LatinIME/lib/arm/libjni_keyboarddecoder.so"

    # Re-pre-ODEX APKs (from GApps Installer)

    # Remove any empty folders we may have created during the removal process
    for i in /system/app /system/priv-app /system/vendor/pittpatt /system/usr/srec; do
        find $i -type d | xargs -r rmdir -p --ignore-fail-on-non-empty;
    done;
    # Fix ownership/permissions and clean up after backup and restore from /sdcard
    find /system/vendor/pittpatt -type d -exec chown 0:2000 '{}' \; # Change pittpatt folders to root:shell per Google Factory Settings
    for i in $(list_files); do
      chown root:root "/system/$i"
      chmod 644 "/system/$i"
      chmod 755 $(dirname "/system/$i")
    done
    rm -rf /sdcard/tmp-gapps
  ;;
esac
