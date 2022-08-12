#!/bin/bash
# v0.1 iterate through my fossils
# Really needs to be run from the source directory first

FIRSTHOME= ( fossil "/home/viking/src/c"
git "/home/viking/src/c"
git "/h3/viking/src/c++/hosts"
)

# Takes path arg
function fossilstuff() {
	pushd /home/viking/src/c
	for t in fossil-scm sqlite; do  # want subshell - saves us a pushd/popd
			fossil pull -R ${t%%-scm}.fossil
			fossil pull -R ${t%%-scm}forum.fossil 
			cd ..
	done
	popd
}

fossilstuff

