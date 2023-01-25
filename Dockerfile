FROM ubuntu:focal
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get -y install curl jq


WORKDIR /es-query
ADD .  /es-query/

ENTRYPOINT ["/bin/bash"]
