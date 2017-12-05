[![Build Status](https://travis-ci.org/zepptron/rpi-prometheus.svg?branch=master)](https://travis-ci.org/zepptron/rpi-prometheus)


# rpi-socat
Socat for Docker Swarm on Raspberry Pi

<h3>Usage:</h3>

create an overlay network in your docker swarm and adjust the following snippet to your needs:

```
docker service create -d \
--name dockerd-export \
--mode global \
--constraint 'node.role==worker' \
--network bloggo \
-e IN="172.18.0.1:9323" \
-e OUT="9323" \
zepp/rpi-socat:latest
```

` -e IN=xxx ` is for the inputstream from the Hostgateway and `-e OUT` is the outputstream for other containers.
` --mode global ` means that the container runs on every available worker node (constraint).
