[![Build Status](https://travis-ci.org/zepptron/rpi-prometheus.svg?branch=master)](https://travis-ci.org/zepptron/rpi-prometheus)


# rpi-socat
Socat for Docker Swarm on Raspberry Pi

You'll need this if you‘d like to get the metrics of the docker daemon into prometheus. Since every docker installation has it's own metrics you'll need something small between your running daemon and prometheus to differentiate and not only get the ones from the hostmachine where prometheus is actually running.

<h3>Usage:</h3>

create or use your existing overlay network in your docker swarm and adjust the following snippet to your needs before running it.

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
