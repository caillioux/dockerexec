# Dockerexec

Small bash script to ease docker container interaction from your terminal.

## Goal

`dockerexec.sh` script aims to ease developer's interactions with docker containers running on their local machine.

It allows you to execute a command in your container from your host, with your host user, and displays containers output.

## Limitations

That said, it's only designed to be working with a `shell` environment, and tested on a Ubuntu 18.04 installation, let me know by a PR if you need tweaks for other configurations.

## Usage

### .container

First of all, create a `.container` file in your php project with a single line

```
container:path
```

A sample file is provided in `example` directory.

`container` should be either the container name or id you want to execute a command in.

`path` should be the absolute path in the container where your command have to be executed

Note that `path` is optional. When not provided, your command will be executed in the container WORKDIR (see https://docs.docker.com/engine/reference/builder/#/workdir). 

## Installing on your local environment

You can get full benefit of dockerexec everywhere by having it in your `$PATH`.

For instance, create a `bin` directory in your `$HOME` directory and change your `$PATH` in `.bashrc`

```
# ~/.bashrc
export PATH=$HOME/bin:$PATH
```

Then copy the `dockerexec`, and make it executable

```
cp src/dockerexec.sh ~/bin/dockerexec
chmod +x ~bin/dockerexec
```

You may need to re-open your terminal or reload your bash environment, like this
```
. ~/.bashrc
```

## Usage

Now `dockerexec` is up, go to your project, create as mentionned the `.container` file and run `dockerexec`

```
myproject $ dockerexec ls -a
project_php:/usr/local/share/project #  "pwd"
/apps/sylius
```

For a php project
```
myproject $ dockerexec php -v
project_php:/usr/local/share/project #  "php" "-v"
PHP 7.2.16 (cli) (built: Mar  9 2019 01:55:33) ( NTS )
Copyright (c) 1997-2018 The PHP Group
Zend Engine v3.2.0, Copyright (c) 1998-2018 Zend Technologies
    with Zend OPcache v7.2.16, Copyright (c) 1999-2018, by Zend Technologies
    with blackfire v1.28.4~linux-x64-non_zts72, https://blackfire.io, by Blackfire
```

## PHP and Symfony

When working with PHP and Symfony, you can install scripts `sf` and `dcomposer` in the `~/bin` directory created on installation, or do something equivalent.

* `sf` is a shortcut for dockerexec to launch Symfony `bin/console` in the container
* `dcomposer` is a shortcut to launch `php composer.phar` in the container, you need to download `composer.phar` from getcomposer.org

Have fun, save time.

## Credits

Loïc Caillieux