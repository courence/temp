#!/bin/bash
TEMP=/home/cour/workspace/git/temp
SOURCE_FILE=/home/cour/workspace/git/myflask/database/myflask.db
TEMP_DIR=emcvm/myflask
FILE_NAME=${SOURCE_FILE##*/}
if [ $# != 2 ];then
echo "error params"
exit 1
fi
USER=$1
PASSWD=$2

if [ ! -f $SOURCE_FILE ];then
echo "$SOURCE_FILE is not existed"
exit 1
fi

if [ ! -d $TEMP ];then
echo "$TEMP is not existed"
exit 2
else
cd $TEMP
fi

if [ ! -d $TEMP_DIR ];then
mkdir -p $TEMP_DIR
fi

if [ ! -d $TEMP_DIR ];then
echo "$TEMP/$TEMP_DIR is not existed"
exit 2
fi
cd $TEMP_DIR
rm -rf *

cp $SOURCE_FILE .

if [ $? != 0 ];then
echo "cp error"
exit 3
fi

gpg -o "${FILE_NAME}.tmp" -ear courence ${FILE_NAME}

if [ $? != 0 ];then
echo "gpg error"
exit 3
fi

cd STEMP
git add .
time=`date '+%Y%m%d %H%M%S'`
git commit -m "$time:$TEMP_DIR"
hgitpush $USER $PASSWD
