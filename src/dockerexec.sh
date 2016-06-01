#!/bin/sh

# get container name
container=`cat .container|head -1`
if [ -z "$container" ]; then
  echo "Have you filled a '.container' file with your running container name or id?"
  exit 1
fi

# check container status
status=`docker inspect  -f '{{.State.Status}}' $container`
if [ "$status" != "running" ]; then
  echo "Container $container not running"
  exit 1
fi

# rewrite user command
for param in "$@"
do
  user_command="${user_command} \"${param}\""
done

# get user environment
user=`id -u`
group=`id -u`
path=`pwd`

# get container working directory
target_mount_command="docker inspect -f '{{range \$bind:=.HostConfig.Binds}}{{\$bind}}\\\\n{{end}}' $container |xargs printf|grep '$path:'|sed -e 's/:/ /g'|awk '{print \$2}'"
target_mount=`eval $target_mount_command`

# fingers crossed, launch user command in container
docker exec -ti --user=$user:$group $container bash -c "cd $target_mount;$user_command"

