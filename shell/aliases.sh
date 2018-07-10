alias g=grep

if [ $(command -v rg) ] ; then
  alias g=rg
elif [ $(command -v ag) ] ; then
  alias g=ag
elif [ $(command -v ack) ] ; then
  alias g=ack
fi
