#!/system/bin/sh
folsek="$(dirname $(realpath $0))"
if [ -f "$folsek/media.log" ]
then
rm $folsek/media.log
fi
#
if [ -z "$1"  ]
then
echo "Gunakan: bash $0 folder yang ada video/audio"
kill -9 $$
fi
##
if [ ! -f "$folsek/media2mp3.sh" ]
then
echo "Gak ada program utama/ media2mp3.sh di $folsek"
kill -9 $$
fi
###
if [ ! -z "$(find $@ -name "*.aac" -type f)" ]
then
find $@ -name "*.aac" -type f >> $folsek/media.log
fi
####
if [ ! -z "$(find $@ -name "*.mp4" -type f)" ]
then
find $@ -name "*.mp4" -type f >> $folsek/media.log
fi
#####
if [ ! -z "$(find $@ -name "*.mkv" -type f)" ]
then
find $@ -name "*.mkv" -type f >> $folsek/media.log
fi
######
if [ ! -z "$(find $@ -name "*.wav" -type f)" ]
then
find $@ -name "*.wav" -type f >> $folsek/media.log
fi
#####
if [ ! -z "$folsek/media.log" ]
then
cat $folsek/media.log|busybox sort -n > $folsek/mediaflo.log
echo "#!/system/bin/sh" > $folsek/02-$(basename $0)
cat $folsek/mediaflo.log|busybox awk -v path=$folsek '{print "\$(readlink /proc/\$\$/exe) " path"/media2mp3.sh " $0 "\nbusybox echo -e \"\\nKonversi " $0 " selesai dan dihapus.\\n\"\nrm "$0}' >> $folsek/02-$(basename $0)
sh $folsek/02-$(basename $0)
fi