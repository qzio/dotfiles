alias g='grep -i'

if [ $(command -v rg) ] ; then
  alias g='rg -i'
elif [ $(command -v ag) ] ; then
  alias g=ag
elif [ $(command -v ack) ] ; then
  alias g=ack
fi
