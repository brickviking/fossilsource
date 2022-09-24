#!/bin/bash
# v0.1 iterate through my fossils
# v0.2 Add in some git projects
# v0.3 Added in some more sqlite-related items
# v0.3a TODO: split this up like fossilweb.sh
# v0.4 still working on new fossilstuff function - not live yet
# v0.5 newfossilstuff got the axe. I've got to build a function to
#      cycle through $1
# v0.6 I added tips to Tcl (Tcl Improvement Proposals)
# v0.6a Added extra line between downloads
# Really needs to be run from the source directory first
# Cannot get TH3 source without a commercial licence, so can't run tests for docsrc

#########
# Notes #
#########
# fossil has source code, forums and a book.
# sqlite has source code, forums, docsrc and a testing harness
# tcl and tk each have source code, and tcl has proposals (tcl-tip)

MYHOME="/home/viking/src/c/"

# Obligatory help function
function dohelp() {
  echo "$0: help page"
  echo "$0 fossil{-scm} [code|forum|book]: fetches named section"
  echo "$0 fossil{-scm} all: fetches code, forum and book"
  echo "$0 sqlite [code|forum|docsrc|tests]: fetches named section"
  echo "$0 sqlite all: fetches code, forum, docsrc and test scripts"
  echo "$0 tcl-code: fetches code"
  echo "$0 tcl-tip: fetches proposals"
  echo "$0 tk-code: fetches code"
  echo "$0 {all}: fetches everything"
  exit 0
}

function fossil-code() {
  fossil pull -R fossil.fossil
  echo "==== fossil-code...done ==="
}

function fossil-forum() {
  fossil pull -R fossilforum.fossil 
  echo "==== fossil-forum...done ==="
}

# fossil only. Rarely updated  
function fossil-book() {
  fossil pull -R fossil-book.fossil 
  echo "==== fossil-book...done ==="
}

function fossil-all() {
  cd fossil-scm;
  t=fossil
  "${t}"-code
  "${t}"-forum
  "${t}"-book
  cd -
}

function sqlite-code() {
  fossil pull -R sqlite.fossil
  echo "==== sqlite-code...done ==="
}

function sqlite-forum() {
  fossil pull -R sqliteforum.fossil 
  echo "==== sqlite-forum...done ==="
}

# Rarely updated.
function sqlite-docsrc() {
  fossil pull -R docsrc.fossil 
  echo "==== sqlite-docsrc...done ==="
}

# Rarely updated.
function sqlite-tests() {
  fossil pull -R sqllogictest.fossil 
  echo "==== sqlite-tests...done ==="
}

function sqlite-all() {
  t="sqlite"
  cd "${t}"
  "${t}"-code
  "${t}"-forum
  "${t}"-docsrc
  "${t}"-tests
  unset $t
  cd .. # gets us back to ${MYHOME}
}

# Updates tcl sourcecode
function tcl-code() {
  fossil pull -R tcl.fossil 
  echo "==== tcl-code...done ==="
}

# Updates tcl TIP database
function tcl-tips() {
  fossil pull -R tips.fossil 
  echo "==== tcl-tips...done ==="
}

# Updates tk sourcecode
function tk-code() {
  fossil pull -R tk.fossil 
  echo "==== tk code...done ==="
}

# Updates both tcl and tk sources
function tcl-all() {
  cd tcl
  tcl-code
  tcl-tips   # TCL Improvement Proposals
  cd ../tk
  tk-code
  cd .. # gets us back to ${MYHOME}
}

function all() { # These each have a cd in them
  fossil-all
  sqlite-all
  tcl-all
}
# Takes path arg

pushd "${MYHOME}"
if [ ${#*} -lt 1 ]; then # I want it all
	all # sleep is built in between stages
else #iterate, chuck it in if keyword isn't recognised.
  for t in ${*}; do
# TODO: this does everything. Might not be what we want
    case "${t}" in "fossil") # does effectively fossil-all
      cd "${t}-scm" # Yes, the directory name has -scm appended
#      "${t}"-book    # should comment this out, doesn't get updated very often
      "${t}"-code
      "${t}"-forum
      cd -
    ;;
    "book")
      cd fossil-scm
      fossil-book 
      cd -
    ;;
    "sqlite") 
      cd "${t}"
      "${t}"-code
      "${t}"-forum
      "${t}"-docsrc
      "${t}"-tests
      cd -
    ;;
    "tcl")
      cd "${t}"
      "${t}"-code
      "${t}"-tips    # TCL Improvement Proposal
      cd -
    ;;
    "tk") cd "${t}"
      ${t}-code  # Only the code at the moment.
    ;;
    esac # end of case ${t}
  done
fi
popd
