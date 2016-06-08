# gitCheckRemote
This script is designed to scrape through the directory in which it was called 
and sub directories and find all git repos within.

It will then check for 'issues' with each git repo, from remote changes 
needing to be pulled, to uncommitted files, etc.

It will then allow you to specify what options you want to take based on the issues it found including a pull all command. (this can also be done using a flag)

# Usage

the file [gitCheckRemote](./gitCheckRemote.sh) is the full script. Any other script files are for reference only. 

# Locations of Shameless Code Stealing

- <http://stackoverflow.com/questions/11981716/how-to-quickly-find-all-git-repos-under-a-directory>
- <http://stackoverflow.com/questions/3497123/run-git-pull-over-all-subdirectories>
- <https://astrofloyd.wordpress.com/2013/02/10/gitcheck-check-all-your-git-repositories-for-changes/>
