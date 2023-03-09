#!/bin/sh
PROJ_DIR=/trac-env
: ${TRAC_PORT:=80}

set -e

check_interactive() {
    if [ ! -t 0 ] ; then
        echo Need to run setup from an interactive terminal!
        exit 1
    fi
}

if [ "$1" = "setup" -o ! -e "${PROJ_DIR}/VERSION" ] ; then
    check_interactive
    trac-admin $PROJ_DIR initenv
fi

PASS_FILE="${PROJ_DIR}/passwd"

if [ "$1" = "setup" -o ! -e $PASS_FILE ] ; then
    check_interactive
    python3 /htpasswd.py -t sha256 -c $PASS_FILE admin
    trac-admin $PROJ_DIR permission add admin TRAC_ADMIN
fi

if [ "$1" = "adduser" ] ; then
    check_interactive
    if [ -z "$2" ] ; then
        echo Missing user name
        exit 1
    fi
    python3 /htpasswd.py -t sha256 $PASS_FILE $2
    exit 0
fi

tracd -p "$TRAC_PORT" --basic-auth="$(basename $PROJ_DIR),$PASS_FILE,trac" $PROJ_DIR
