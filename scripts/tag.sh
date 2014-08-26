#!/bin/sh

TAG_PATH=$(cd "$(dirname "$0")"; pwd)
cd $TAG_PATH
cd ../src

ctags -R --c++-kinds=+p --fields=+iaS --extra=+q
