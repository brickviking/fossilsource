#!/bin/bash
# v0.0.1 FossilWeb - brings up all fossil servers on 8100/8110/8120
# v0.1.0 Starts up what we choose
# v0.1.2 Removed book from "all" as this very rarely gets updated
# v0.1.3 TODO: Add code to check for already running servers, dump if so
# v0.1.4 name change about three versions ago to suit tcl instead of fossil
# v0.1.5 made notes about starting on ports 8300/10/20

TCLHOME="/home/viking/src/c/tcl"
TKHOME="/home/viking/src/c/tk"

# First the source code
tcl-code() {
  cd "${TCLHOME}"
  echo -ne "Starting Tcl fossil server: "
  fossil server --port 8300 tcl.fossil &
  cd -
}

tcl-tips() {
  cd "${TCLHOME}"
  echo -ne "Starting Tcl Improvement Proposals fossil server: "
  fossil server --port 8310 tips.fossil &
  cd -
}

tk-code() {
  cd "${TKHOME}"
  echo -ne "Starting Tk fossil server: "
  fossil server --port 8320 tk.fossil &
  cd -
}

# Everything
all() {
  tcl-code
  sleep 5
  tcl-tips
  sleep 5
  tk-code
  sleep 5
}

# Better provide help, can't call it help because of the builtin
dohelp() {
	echo "$0: help screen. Starts fossil server for Tcl code from files on commandline"
  echo "$0 [all|tcl-code|tcl-tip|tk-code]"
  echo "all: launch all servers, spaced out by five seconds"
  echo "tcl-code: tcl source code"
  echo "tcl-tips: Tcl Improvement Proposals"
  echo "tk-code: tk source code"
#	echo "forum: tcl forums - read-only"
#	echo "docsrc: source for generating tcl document tree"
#	echo "tests: sql logic test harness"
	exit 0
}

# Change to correct directory
pushd "${TCLHOME}"

if [ ${#*} -lt 1 ]; then # I want it all
	all # sleep is built in between stages
else #iterate, chuck it in if keyword isn't recognised.
  for t in ${*}; do
    case $t in "-h"|"--help") dohelp ;;
      "tcl-code") tcl-code ;;
      "tcl-tips"|"tips") tcl-tips ;;
      "tk-code") tk-code ;;
      "all") all ;;
      "*") dohelp ;; # This exits, no matter what the state of other ${*}
    esac
    sleep 5 # Allow each server to start up before anything else happens
  done
fi

# We all done sah.
popd
