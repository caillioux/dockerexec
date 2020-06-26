#!/bin/sh
console="bin/console"

if [ ! -f $console ]; then
  # symfony 2
  if [ -f "app/console" ]; then
    console="app/console"
  else
    echo "Cannot find console executable"
    exit
  fi;
fi;

if [ ! -f ".container" ]; then
  php $console "$@"
  exit $?;
fi


dockerexec php $console "$@"
