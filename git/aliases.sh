alias git-fetch-and-rebase='git fetch --prune --tags --all && git co master && git rebase origin/master'
alias git-fupstream='git co master && git rebase -i upstream/master && git push origin master'
alias glog='git log --pretty=format:"%h %s" --graph'
alias gp='git push'
