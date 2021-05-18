#!/bin/sh

container=`(cat .container|head -1|cut -d ':' -f 1) 2>/dev/null`
workdir=`(cat .container|head -1|cut -d ':' -f 2) 2>/dev/null`
verbose=''

if [ -z "$container" ]; then
  echo "Have you filled '.container' file with your running container name or id?"
  exit 1
fi

status=`docker inspect  -f '{{.State.Status}}' $container`
if [ "$status" != "running" ]; then
  echo "Container $container not running"
  exit 1
fi

for param in "$@"
do
  if [ "-v" = "$param" ]; then
    verbose=1
  else
    user_command="${user_command} \"${param}\""
  fi
done

user=`id -u`
group=`id -u`

full_command="$user_command"
if [ ! -z "$workdir" ]; then
  full_command="cd $workdir;$user_command"
else
  $workdir="WORKDIR"
fi;

if [ "$verbose" = 1 ]; then
  echo "$container:$workdir # $user_command"
fi

docker exec -ti --user=$user:$group $container bash -c "$full_command"
