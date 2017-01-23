#!/usr/bin/env mksh
__ps1_path_info()
{
  local WD=${PWD/$HOME/~}
  if (( ${#WD} > 25 )) ; then
    print ${WD:0:10}...${WD: -10: -1}
  else
    print $WD
  fi
}

__ps1_user_suffix()
{
  if [ $USER_ID -eq 0 ] ; then
    print '#'
  else
    print '$'
  fi
}
__ps1_git_branch()
{
  git branch 2>/dev/null | sed -n '/^\* \(.*\)/s//(\1)/p'
}
PS1='$(hostname -s):$(__ps1_path_info)$(__ps1_git_branch)$(__ps1_user_suffix) '
