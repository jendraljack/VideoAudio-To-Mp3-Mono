#!/system/bin/sh
folder="$(dirname $(realpath $0))"
if [ -z "$1" ]
then
echo "usage: bash $0 media"
kill -9 $$
fi
##
ffmpeg -i "$@" 2>&1|grep -i "Audio"|busybox cut -d ' ' -f 1- > $folder/info.log
cat $folder/info.log|busybox tr ',' '\x0a' > $folder/info2.log
cat $folder/info2.log|busybox sort -n -r > $folder/info3.log
cat $folder/info3.log|grep -i "kb/s"|busybox awk '{print $1}' > $folder/kbps
bitrate="$(cat $folder/kbps)k"
filename=$@
output=${filename%.*}
busybox echo -e "Media info\n$(cat $folder/info.log)\n\n"
echo "Building new script..."
sleep 4
echo "#!/system/bin/sh" > $folder/02-$(basename $0)
echo "ffmpeg -i \"$@\" -ac 1 -ab $bitrate \"$output.mp3\"" >> $folder/02-$(basename $0)
$(readlink /proc/$$/exe) "$folder/02-$(basename $0)"
### Author: KambingHitam
## perintah head hanya 2 string yang di-print, baris pertama dan kedua
### bagaimana caranya hanya print string yg ke 2/baris kedua??
### apa alternativ perintah "head"
### ada yang bisa bantu..?