#!/bin/bash
# Steffen Tilsch 2015

if [ ! $1 ];then
  echo  "$0 -c     creates crc32-checksum files"
  echo  "$0 -v     verifies crc32-checksum files"
  exit 1
fi

INPUT=$1

red=$(tput setaf 1)             # red
green=$(tput setaf 2)           # green
txtrst=$(tput sgr0)             # back to notmal


if [ "$INPUT" = "-c" ];then
  #CREATE
  find . -type f  | grep -v .crc32| while read FILE 
  do  
    if [ -f "${FILE}.crc32" ] 
    then
      echo "$FILE crc32-file found - nothing to do"
    else
      echo  $(crc32 "$FILE") > "${FILE}.crc32"
      echo "${FILE}.crc32 written"
    fi
  done
elif [ "$INPUT" = "-v" ];then
  # VERIFY
  find . -type f | grep -v .crc32| while read FILE 
  do  
    if [ -f "${FILE}.crc32" ]; then
      NEWHASH=$(crc32 "$FILE")
      OLDHASH=$(cat "${FILE}.crc32")
      if [ "$NEWHASH" = "$OLDHASH" ];then
        echo -e "File $FILE is $(tput setaf 2)OK $(tput sgr0)"
      else 
        echo "$(tput setaf 1)File $FILE is corrupt OLDHASH($OLDHASH) != NEWHASH($NEWHASH)$(tput sgr0)"
      fi
    else
      echo "no ${FILE}.crc32 found!"
    fi
  done
else
  echo bla
fi


