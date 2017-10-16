#!/bin/sh

# Init workspace
echo ""
echo "- 0) Init workspace"

brew -v 1>&-
if [[$? != 0]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 1>&-;
fi

docker -v && docker-machine -v && docker-compose -v 1>&-
if [[$? != 0]]; then
    brew install docker docker-machine docker-compose 1>&-;
fi

# Flush dockers
echo ""
echo "- 1) Flush all old Dockers"
docker service rm `docker service ls -q`
docker rm -f `docker ps -aq`
docker rmi `docker images -q`

# 1 server for Manager
echo ""
echo "- 2) Create Manager"
docker-machine create --driver virtualbox manager1

# 5 servers for workers
echo ""
echo "- 3) Create Workers"
docker-machine create --driver virtualbox worker1
docker-machine create --driver virtualbox worker2
docker-machine create --driver virtualbox worker3
docker-machine create --driver virtualbox worker4
docker-machine create --driver virtualbox worker5

MANAGER_IP="`docker-machine ip manager1`"

echo ""
echo "- 4) Manager ip is : ${MANAGER_IP}"

# Configure virtualizer
echo ""
echo "- 5) Install visualizer on the manager"
docker-machine ssh manager1 \
    docker run \
        -it -d \
        -p 8080:8080 \
        -e HOST=$MANAGER_IP \
        -e PORT=8080 \
        -v /var/run/docker.sock:/var/run/docker.sock \
        dockersamples/visualizer

echo ""
echo "- 6) Configure Swarm on manager"
docker-machine ssh manager1 \
    docker run -d \
        -v /usr/share/ca-certificates/:/etc/ssl/certs \
        -p 4001:4001 -p 2380:2380 -p 2379:2379 \
        --name etcd quay.io/coreos/etcd etcd \
        -name etcd0 \
        -advertise-client-urls http://${MANAGER_IP}:2379,http://${MANAGER_IP}:4001 \
        -listen-client-urls http://0.0.0.0:2379,http://0.0.0.0:4001 \
        -initial-advertise-peer-urls http://${MANAGER_IP}:2380 \
        -listen-peer-urls http://0.0.0.0:2380 \
        -initial-cluster-token etcd-cluster-1 \
        -initial-cluster etcd0=http://${MANAGER_IP}:2380 \
        -initial-cluster-state new \

open "http://${MANAGER_IP}:8080"