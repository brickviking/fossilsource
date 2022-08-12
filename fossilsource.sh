#!/bin/bash
# v0.1 iterate through my fossils
# v0.2 Add in some git projects
# Really needs to be run from the source directory first

#FIRSTHOME= ( fossil "/home/viking/src/c"
#git "/home/viking/src/c"
#git "/h3/viking/src/c++/hosts"
#)

# Takes path arg
function fossilstuff() {
	pushd /home/viking/src/c
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

