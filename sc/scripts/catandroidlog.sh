adb devices
adb logcat -d  -s Unity > UnityLog.log 
adb logcat -c

cat UnityLog.log | grep -E -v  '.+unity   :'  > UnityLog.log 