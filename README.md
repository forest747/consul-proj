# consul-proj
------------
### go to the consul-server container 

    docker exec -it consul-server sh

### Lists the members of a Consul cluster
    consul members

### Lists all known datacenters

    consul catalog datacenters

### Lists all nodes in the given datacenter

    consul catalog nodes

### Lists all registered services in a datacenter

    consul catalog services
