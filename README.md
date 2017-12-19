[![Build Status](https://travis-ci.org/zepptron/rpi-prometheus.svg?branch=master)](https://travis-ci.org/zepptron/rpi-prometheus)


# rpi-socat
Socat for Docker Swarm on Raspberry Pi

You'll need this if you‘d like to get the metrics of the Docker daemon into [Prometheus](https://github.com/zepptron/rpi-prometheus). Since every docker installation has it's own metrics you'll need something small between your running daemon and prometheus to differentiate and not only get the ones from the hostmachine where prometheus is actually running.

<h3>Prerequisites:</h3>
Please take care that you have the correct docker_gwbridge IP in use if you're about to use it in the docker daemon/prometheus context. 

```
$ ip addr show | grep docker_gwbridge
4: docker_gwbridge: <BROADCAST,MULTICAST,UP,LOWER_UP> 
    inet 172.18.0.1/16 scope global docker_gwbridge
```

Also take care that your docker daemon is actually publishing some metrics to an endpoint. This can be done by enabling the experimental flag in a new json file.

```
$ cat /etc/docker/daemon.json
{
  "metrics-addr" : "0.0.0.0:9323",
  "experimental" : true
}
```

After inserting this just restart your docker daemon with ` systemctl restart docker.service ` and curl the address ` curl localhost:9323/metrics` and make sure that you see some metrics. Thats all.

<h3>Usage:</h3>

Simply create or use your existing overlay network in your docker swarm and adjust the following snippet to your needs before running it. 

```
docker service create -d \
    --name dockerd-export \
    --mode global \
    --network bloggo \
    -e INPUT="172.18.0.1:9323" \
    -e OUTPUT="9323" \
    zepp/rpi-socat:latest
```

` -e INPUT=xxx ` is for the inputstream from the Hostgateway and `-e OUTPUT` is the output.
` --mode global ` means that the container runs on every available node, including masters. You can set a constraint to run it only on workernodes with ` --constraint 'node.role==worker' ` if you like.


Please feel free to contribute.
