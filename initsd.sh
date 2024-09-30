#!/user/bin/env bash

SDCARD_PATH=/media/user/bootfs
CONFIGTXT=config.txt
CMDLINE_TXT=cmdline.txt

function detectSD() {
    while true; do
        if [ -d "${SDCARD_PATH}" ]; then
            echo "SD 카드가 발견됨!"
            return
        fi
    done
}

echo before detectSD
detectSD
echo after detectSD

function detectCMDLINE() {
    sleep 1
    if [ -f "${SDCARD_PATH}/${CMDLINE_TXT}" ]; then
        echo "cmdline.txt 가 발견됨!"
        return 0
    else
        return 1
    fi
}

echo "cmdline.txt 'detectCMDLINE'"

isCMDLINE=$(detectCMDLINE)
IPADDR=192.168.81.1

if [ "$isCMDLINE" -eq 0 ]; then
    sed -i "s/111.111.111.111/${IPADDR}/" "${SDCARD_PATH}/${CMDLINE_TXT}"
    if [ $? -eq 0 ]; then
        echo "${CMDLINE_TXT} 문서가 수정되었습니다. 성공"
    else
        echo "${CMDLINE_TXT} 문서가 수정하지 못했습니다. 실패"
    fi
fi

umount /media/user/bootfs
echo "SD 카드를 분리하셔도 됩니다"
