## Docker installation instruction for macos

```bash
$ brew install docker docker-machine
$ brew cask install virtualbox
-> need password
-> possibly need to address System Preference setting
$ docker-machine create --driver virtualbox default
$ docker-machine env default
$ eval "$(docker-machine env default)"

$ docker run hello-world
$ docker-machine stop default
```

## Docker commands

```bash
$ docker build -t pg .
$ docker run -it -p 22:22 -p 5432:5432 pg /bin/bash
$ docker tag pg pg:v0.1
```

## Connect to psql
$ psql postgres postgres -h 172.17.0.2
$ psql postgres postgres -h 127.0.0.1
$ psql postgres postgres -h localhost

## Connect using ssh
$ ssh admin@172.17.0.2
$ ssh admin@127.0.0.1
$ ssh admin@localhost
