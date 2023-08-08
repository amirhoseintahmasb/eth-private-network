FROM centos:7

# Update system packages
RUN yum update -y && yum clean all

# Install geth from the official Ethereum repo
# This assumes that the repo provides a CentOS compatible package
# If not, you might need to install geth from another source or compile it yourself
RUN yum install -y epel-release
RUN yum install -y geth && yum clean all

# Install bash (though it should already be included in CentOS images)
RUN yum install -y bash && yum clean all

# Build arguments whose values are given to env variables to configure the docker images from one node to another
ARG identity_arg
ARG rpcport_arg
ARG peer_arg

# Add a user
RUN adduser prvnode
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
