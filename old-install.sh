#!/bin/bash

CURRENT_TIME=`date +%Y%m%d%k%M`
FORCE=0
if [ "$1" == "-f" ] ; then
  echo "will force override all files/directories."
  FORCE=1
fi
CURRENT_DIR=`dirname $0`
R=$(readlink -f $CURRENT_DIR)
CURRENT_DIR=$R/
echo $CURRENT_DIR

linkit()
{
  if [ -f $2 ] || [ -d $2 ]; then
    echo "$2 already exists"
    if [ $FORCE -eq 1 ] ; then
      echo "creating a copy and removing original"
      echo "mv $2 $2.$CURRENT_TIME.backup"
      mv $2 $2.$CURRENT_TIME.backup
    fi
  else
    echo "ln -sf $1 $2"
    ln -sf $1 $2
  fi
}


echo "will cd too $CURRENT_DIR"

cd $CURRENT_DIR

for symlink_source in `find . -name "*.symlink" `; do
  filename=$(basename "$symlink_source")
  TARGET="$HOME/.${filename%.*}"
  full_source=$( readlink -f $symlink_source )
  linkit $full_source $TARGET
done ;
