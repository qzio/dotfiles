
# use rust version of find if present
if [ $(command -v fdfind) ] ; then
  alias f='fdfind'
elif [ $(command -v fd) ] ; then
  alias f='df'
else
  alias f='find'
fi

# use nvim if present
if [ $(command -v nvim) ] ; then
  alias vim='nvim'
elif [ $(command -v vim) ] ; then
  alias vim='vim'
else
  alias vim='vi'
fi

# use the best grep-like command
if [ $(command -v rg) ] ; then
  alias g='rg -i'
elif [ $(command -v ag) ] ; then
  alias g=ag
elif [ $(command -v ack) ] ; then
  alias g=ack
else
  alias g='grep -i'
fi
