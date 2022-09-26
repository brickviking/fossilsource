#!/bin/bash
# v0.0.1 FossilWeb - brings up all fossil servers on 8100/8110/8120
# v0.0.2 Sqlite fossil servers adjusted to start on 8200/10/20/30
# v0.1.0 Starts up what we choose
# v0.1.2 Removed book from "all" as this very rarely gets updated
# v0.1.3 TODO: Add code to check for already running servers, dump if so
# v0.1.4 name change about three versions ago to suit sqlite instead of fossil
# v0.1.5 Added, then removed TCL Improvement Proposals (TIP), shifted to tclweb.sh

SQLITEHOME="/home/viking/src/c/sqlite"

# First the source code
code() {
  echo -ne "Starting SQlite3 code fossil server: "
  fossil server --port 8200 sqlite.fossil &
}

# Now the forums
forum() {
  echo -ne "Starting SQlite3 forum fossil server: "
  fossil server --port 8210 sqliteforum.fossil &
}

# and the doc source files
docsrc() {
  echo -ne "Starting SQlite3 docsrc fossil server: "
  fossil server --port 8220 docsrc.fossil &
}

# and the SQL Logic Tests
tests() {
  echo -ne "Starting SQlite3 test code fossil server: "
  fossil server --port 8230 sqllogictest.fossil &
}

# Everything
all() {
  code
  sleep 5
  forum
  sleep 5
  docsrc
  sleep 5
  tests
  sleep 5
}

# Better provide help, can't call it help because of the builtin
dohelp() {
  echo "$0: help screen. Starts fossil server from files on commandline"
  echo "$0 [all|code|forum|docsrc|test] ..."
  echo "all: launch everything below, spaced out by five seconds"
  echo "code: sqlite source code"
  echo "forum: sqlite forums - read-only"
  echo "docsrc: source for generating sqlite document tree"
  echo "tests: sql logic test harness"
  exit 0
}

# Change to correct directory
pushd "${SQLITEHOME}"

if [ ${#*} -lt 1 ]; then # I want it all
  all # sleep is built in between stages
else #iterate, chuck it in if keyword isn't recognised.
  for t in ${*}; do
    case $t in "-h"|"--help") dohelp ;;
      "code") code ;;
      "forum") forum ;;
      "docsrc") docsrc ;;
      "tests") tests ;;
      "all") code
        forum
        docsrc
        tests
       ;;
      *) dohelp ;; # This exits, no matter what the state of other ${*}
    esac
    sleep 5 # Allow each server to start up before anything else happens
  done
fi

# We all done sah.
popd