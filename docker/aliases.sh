#alias dm='docker-machine'
alias dcompose='docker-compose'

o()
{
  echo "previous org: $CHEF_ORG"
  export CHEF_ORG=$1
  echo "now: CHEF_ORG=$CHEF_ORG"
}

m_DEPRECATED()
{
  eval $(docker-machine env $1)
}

# Enter a container, denter <grep on something from docker ps>
denter()
{
  dexec $1 bash
}

dexec()
{
  grep_for=$1
  container_id=$(docker ps |grep $grep_for | cut -d ' ' -f 1)
  docker exec -t -i $container_id $2
}

# Display stats about a container, dstats <grep on something from docker ps>
dstats()
{
  grep_for=$1
  container_id=$(docker ps |grep $grep_for | cut -d ' ' -f 1)
  docker stats $container_id
}

# Display logs(stdout) from a container, dlogs <grep on something from docker ps>
dlogs()
{
  grep_for=$1
  container_id=$(docker ps |grep $grep_for | cut -d ' ' -f 1)
  docker logs $2 $3 $4 $container_id
}

# Stop a container, dstop <grep on something from docker ps>
dstop()
{
  grep_for=$1
  container_id=$(docker ps |grep $grep_for | cut -d ' ' -f 1)

  docker stop $container_id
}

# Kill a container, dkill <grep on something from docker ps>
dkill()
{
  grep_for=$1
  container_id=$(docker ps |grep $grep_for | cut -d ' ' -f 1)

  docker kill $container_id
}

# Remove a bunch of <none> images.
d_rmi_all_none()
{
  for h in `docker images|grep none|awk '{print $3}'`; do
    docker rmi $h
  done
}
# Remove a bunch of <none> containers.
d_rm_all_none()
{
  echo "not doing this"
}

# Remove <none> images and containers
d_remove_all_none()
{
  d_rm_all_none
  d_rmi_all_none
}

dsyslog()
{
  local name=$1
  local lines=50
  if [ ! -n "$name" ] ; then
    name=logstash
  fi
  if [ -n "$2" ] ; then
    lines=$2
  fi
  dexec $name "tail -f -n $lines /var/log/syslog"
}

# tinycore linux doesn't have the host command...
hostn()
{
   nslookup $1|grep $1|grep Address|awk '{print $3}'
}

# denter, but attach instead of exec
dattach()
{
  grep_for=$1
  container_id=$(docker ps |grep $grep_for | cut -d ' ' -f 1)
  docker attach $container_id
}
