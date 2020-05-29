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