#!/bin/bash
# v0.0.1 FossilWeb - brings up all fossil servers on 8100/8110/8120
# v0.1.0 Starts up what we choose
# v0.1.2 Removed book from "all" as this very rarely gets updated
# v0.1.3 TODO: Add code to check for already running servers, dump if so

# TODO: we need to bring this back up to date. It's been a really long
#       time since July 2022
# Forget it, server mode works far better.
FOSSILHOME="/home/viking/src/c/fossil-scm"

# First the source code
code() {
  echo -ne "Starting fossil code server: "
  fossil server --port 8100 fossil.fossil &
}

# Now the forums
forum() {
  echo -ne "Starting fossil forum server: "
  fossil server --port 8110 fossilforum.fossil &
}

# and last, the book files. need ui for this
book() {
  echo -ne "Starting fossil book server: "
  fossil server --port 8120 fossil-book.fossil &
}

# Everything except book. Seems a bit redundant.
all() {
  code
  sleep 5
  forum
  sleep 5
  # book # doesn't really need this, so we'll call it specifically
}

# Better provide help, can't call it help because of the builtin
dohelp() {
  echo "$0: help screen. Starts fossil server from files on commandline"
  echo "$0 [all|code|forum|book] ..."
  exit 0
}

# Change to correct directory
pushd "${FOSSILHOME}"

if [ ${#*} -lt 1 ]; then # I want it all
  all # sleep is built in between stages
else #iterate, chuck it in if keyword isn't recognised.
  for t in ${*}; do
    case $t in "-h"|"--help") dohelp ;;
      "code") code ;;
      "forum") forum ;;
      "book") book ;;
      "all") all ;; # doesn't include book, call that separately
      *) dohelp ;; # This exits, no matter what the state of other ${*}
		esac
		sleep 5 # Allow each server to start up before anything else happens
	done
fi

# We all done sah.
popd
