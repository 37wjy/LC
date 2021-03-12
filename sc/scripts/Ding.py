import os

def AAA():
    isStatusBarKeyguard = os.popen(
        "adb shell \"dumpsys window policy|grep isStatusBarKeyguard \"").read().strip(
        '\n')
    if "isStatusBarKeyguard=false" in isStatusBarKeyguard:
         os.system('adb shell \"input swipe  300 1000 300 500\"')
    app="com.alibaba.android.rimet"
    os.system(
            "adb shell \"monkey -p %s -c android.intent.category.LAUNCHER 1\"" % (app, ))




AAA()