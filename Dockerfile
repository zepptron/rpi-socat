FROM hypriot/rpi-alpine
MAINTAINER zepptron <https://github.com/zepptron>

RUN apk add --no-cache socat 

ENV INPUT="172.18.0.1:9323" \
    OUTPUT="9323"

ENTRYPOINT socat -d -d TCP-L:$OUTPUT,fork TCP:$INPUT