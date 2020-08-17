#/bin/bash
set -x

# clean up containers 
docker rm -f consul-server consul-client-1 counting-service

#deploy consul server
docker run \
    -d \
    -p 8500:8500 \
    -p 8600:8600/udp \
    --name=consul-server \
    consul agent -server -ui -node=server-1 -bootstrap-expect=1 -client=0.0.0.0

#wait until consul server to be set.
sleep 10

# deploy consul client
# ip used for join is found on consul server using command "docker exec consul-server consul members"
docker run -d\
   --name=consul-client-1 \
   consul agent -node=client-1 -join=172.17.0.2


#run counting service. it is running on localhost:9001
docker run \
   -p 9001:9001 \
   -d \
   --name=counting-service \
   hashicorp/counting-service:0.0.2

#register counting service with the consul client
docker exec consul-client-1 /bin/sh -c "echo '{\"service\": {\"name\": \"counting\", \"tags\": [\"go\"], \"port\": 9001}}' >> /consul/config/counting.json"

#reload conf.
docker exec consul-client-1 consul reload
