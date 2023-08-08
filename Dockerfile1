FROM ubuntu:latest

# Install geth

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:ethereum/ethereum 
RUN apt-get update
RUN apt-get install -y ethereum

# Install bash
RUN apt-get update && apt-get install bash


# Build arguments whose values are given to env variables to configure the docker images from one node to another
ARG identity_arg
ARG rpcport_arg
ARG peer_arg

# Add a user
RUN adduser --disabled-login --gecos "" prvnode
COPY genesis.json /home/prvnode
COPY password /home/prvnode
COPY ${identity_arg}.prv /home/prvnode
RUN chown -R prvnode:prvnode /home/prvnode
USER prvnode


ENV identity_env $identity_arg
ENV rpcport_env $rpcport_arg
ENV peer_env $peer_arg

# Make the startNode script executable by the eth_user
COPY startNode.sh /home/prvnode
RUN ls -la /home/prvnode

# Set up the working directory
WORKDIR /home/prvnode

# Start a bash session (the user has to run ./startNode.sh from the WORKDIR when he wants to start the node)
# ENTRYPOINT /bin/bash
ENTRYPOINT [ "./startNode.sh" ]
