#!/bin/bash
# Steffen Tilsch 2015

function help {
  echo  "$0 -c     creates crc32-checksum files"
  echo  "$0 -v     verifies crc32-checksum files"
  exit 1
}

if [ ! "$1" ];then
  help
fi


INPUT=$1
LOGFILE=/tmp/$(basename "$0").log
ERRFILE=/tmp/$(basename "$0").err
cat /dev/null > "$ERRFILE"
DATE=$(date +"%Y.%m.%d_%H:%M:%S")
echo $DATE >> "$LOGFILE"

# check if crc32 is installed
command -v crc32 >/dev/null 2>&1 || { 
  echo "crc32 is not installed. Please install first." | tee -a "$ERRFILE"
  exit 1 
}

#red    $(tput setaf 1)
#green  $(tput setaf 2)
#normal $(tput sgr0)    

#CREATE
if [ "$INPUT" = "-c" ];then
  find . -type f | grep -v .crc32 | sort | while read FILE_WITH_PATH
  do  
    FPATH=${FILE_WITH_PATH%/*}
    FNAME=${FILE_WITH_PATH##*/}
    CRCPATH="${FPATH}/.${FNAME}.crc32"
    if [ -f "${CRCPATH}" ] 
    then
      echo "$FILE_WITH_PATH crc32-file found - nothing to do" | tee -a "$LOGFILE"
    else
      crc32 "$FILE_WITH_PATH" > "$CRCPATH"
      echo $DATE >> "$CRCPATH"
      echo "$CRCPATH written" | tee -a "$LOGFILE"
    fi
  done


# VERIFY
elif [ "$INPUT" = "-v" ];then
  find . -type f | grep -v .crc32 | sort | while read FILE_WITH_PATH
  do  
    FPATH=${FILE_WITH_PATH%/*}
    FNAME=${FILE_WITH_PATH##*/}
    CRCPATH="${FPATH}/.${FNAME}.crc32"
    if [ -f "$CRCPATH" ]; then
      NEWHASH=$(crc32 "$FILE_WITH_PATH")
      OLDHASH=$(head -1 "$CRCPATH")
      if [ "$NEWHASH" = "$OLDHASH" ];then
        echo -e "File $FILE_WITH_PATH is $(tput setaf 2)OK $(tput sgr0)"
        echo -e "File $FILE_WITH_PATH is OK" >> "$LOGFILE"
      else 
        echo "$(tput setaf 1)File $FILE_WITH_PATH is corrupt oldhash($OLDHASH) != newhash($NEWHASH)$(tput sgr0)"  
        echo "File $FILE_WITH_PATH is corrupt oldhash != newhash($NEWHASH)"  |tee -a "$LOGFILE" "$ERRFILE"   >/dev/null
      fi
    else
      echo "$(tput setaf 1)File $CRCPATH missing!$(tput sgr0)" 
      echo "File $CRCPATH missing!" |tee -a "$LOGFILE" "$ERRFILE"   >/dev/null
    fi
  done

# All other inputs
else
  help | tee -a "$LOGFILE" "$ERRFILE"
fi
