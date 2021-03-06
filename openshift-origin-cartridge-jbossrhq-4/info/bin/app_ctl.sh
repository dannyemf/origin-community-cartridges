#!/bin/bash -e

source "/etc/openshift/node.conf"
source ${CARTRIDGE_BASE_PATH}/abstract/info/lib/util

# Import Environment Variables
for f in ~/.env/*
do
    . $f
done

translate_env_vars

if ! [ $# -eq 1 ]
then
    echo "Usage: \$0 [start|restart|graceful|graceful-stop|stop|threaddump]"
    exit 1
fi
echo "app_ctl $1" >> /log/log
validate_run_as_user

case "$1" in
    start)
        #exec 1>&- # close stdout
        #app_ctl_impl.sh start >/dev/null 2>&1
        #exec 1>&2 # redirect stdout to stderr
        app_ctl_impl.sh start
    ;;
    *)
        app_ctl_impl.sh $1
    ;;
esac
