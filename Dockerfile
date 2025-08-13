FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
apt-get install -y nfs-kernel-server nfs-common && \
rm -rf /var/lib/apt/lists/*
  
  # Create export directory
  RUN mkdir -p /export

# Set permissions
RUN chown nobody:nogroup /export

# Add default exports file
RUN echo "/export *(rw,sync,no_subtree_check,no_root_squash)" > /etc/exports

EXPOSE 2049/tcp 2049/udp 111/tcp 111/udp

CMD ["/usr/sbin/rpcbind", "-w", "&&", "/usr/sbin/rpc.nfsd", "&&", "/usr/sbin/exportfs", "-r", "&&", "/usr/sbin/rpc.mountd", "-F"]