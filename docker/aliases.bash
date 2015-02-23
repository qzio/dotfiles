alias dlist='docker images |grep -v none'
alias d='docker'

denter()
{
  grep_for=$1
  container_id=$(docker ps |grep $grep_for | cut -d ' ' -f 1)
  docker exec -t -i $container_id bash
}

dstop()
{
  grep_for=$1
  container_id=$(docker ps |grep $grep_for | cut -d ' ' -f 1)

  docker stop $container_id
}


d_rmi_all_none()
{
  for h in `docker images|grep none|awk '{print $3}'`; do
    docker rmi $h
  done
}
d_rm_all_none()
{
  for h in `docker ps -a |grep -v ':' |awk '{print $1}'|grep -v CONTAINER`; do
    docker rm $h
  done
}

d_remove_all_none()
{
  d_rm_all_none
  d_rmi_all_none
}
