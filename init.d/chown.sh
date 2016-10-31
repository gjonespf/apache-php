#!/bin/bash
chown www-data:www-data /app -R &

#Issues with IO sometimes too slow on aufs, which causes "Text file busy" downstream due to chown here...
#https://github.com/docker/docker/issues/9547
sync; sleep 1;
