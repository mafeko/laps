#! /bin/bash

SRC_PATH="/data/timelaps"
DST_PATH="100.66.102.123/mnt/data-volume/timelaps-1/"

rsync --remove-source-files -options "$SRC_PATH" "$DST_PATH"