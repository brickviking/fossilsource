#!/bin/bash
# v0.1 iterate through my fossils
# v0.2 Add in some git projects
# v0.3 TODO: split this up like fossilweb.sh
# Really needs to be run from the source directory first

#########
# Notes #
#########
# Do I really want to run code/forum for _both_ sqlite and fossil, or only
# one at a time? If so, how do I do this?
# One possibility is with switches: 
# $ME fossil (-c|-f|-b)
# $ME sqlite (-c|-f)

MYHOME="/home/viking/src/c/"

function blah() { # don't do anything }

function code() {
	fossil pull -R ${t%%-scm}.fossil
}

function forum() {
	fossil pull -R ${t%%-scm}forum.fossil 
}

function book() {
	# only true for fossil, not for sqlite
	fossil pull -R ${t%%-scm}-book.fossil 
	blah
}

# Takes path arg
function fossilstuff() {
	pushd "${MYHOME}"
	for t in fossil-scm sqlite; do  # want subshell - saves us a pushd/popd
		case ${t} in "fossil-scm")
			cd ${t}
			fossil pull -R ${t%%-scm}.fossil
			fossil pull -R ${t%%-scm}forum.fossil 
			fossil pull -R ${t%%-scm}-book.fossil 
			cd ..
		;;
		"sqlite") 
			cd ${t}
			fossil pull -R ${t%%-scm}.fossil
			fossil pull -R ${t%%-scm}forum.fossil 
			cd ..
		;;
		esac		
	done
	popd
}

fossilstuff

