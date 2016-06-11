#!/bin/bash

#TODO fix remote checking for local only repositories
# Initialise counters:
let count_all=0
let count_changed=0
let count_unchanged=0

# Set to 1 for more verbose output:
let verbose=0

# Find git repos and loop over them:
for repo in `find . -type d -name ".git"` # find returns a relative path with the .git directory at the
do
    let count_all=${count_all}+1

    # cd to the dir that contains .git/:
    dir=`echo ${repo} | sed -e 's/\/.git/\//'` #replaces the /.git on the end of the returned path with /
    cd ${dir}

    # update remote refs
    git remote -v update &> /dev/null

    # command to check if pull is necessary
    pullNeeded=$(git rev-list HEAD..HEAD@{upstream} | wc -l | awk '{print $1}')

    # command to check if push is necessary
    pushNeeded=$(git rev-list HEAD@{upstream}..HEAD | wc -l | awk '{print $1}')

    #printf 'pullNeeded: %s pushNeeded: %s\n' ${pullNeeded} ${pushNeeded}
    # If there are changes, print some status and branch info of this repo:
    if [ ${pullNeeded} -ne "0" ] || [ ${pushNeeded} -ne "0" ]; then
	    printf "\n%s needs attention\n" ${dir}
      printf "\n branch info\n\n"
	    git branch -vvra
      printf "\n status info\n\n"
      git status
	    let count_changed=${count_changed}+1
      printf "%s\n" "--------------------------------------------------------------------------------"
    fi


    # # If verbose, print info in the case of no changes:
    # if [ ${pullNeeded} -eq "0" ] && [ ${pushNeeded} -eq "0" ] && [ ${verbose} -ne 0 ]; then
	  #   printf "Nothing to do for %s\n\n" ${dir}
	  #   let count_unchanged=${count_unchanged}+1
    #   printf "%s\n" "--------------------------------------------------------------------------------"
    # fi

    # cd back:
    cd - &> /dev/null
done
let count_unchanged=${count_all}-${count_changed}
# Report status and exit:
echo -ne "\n\n${count_all} git repositories found: "
echo -ne "${count_changed} have changes, "
echo -ne "${count_unchanged} are unchanged.\n\n"
