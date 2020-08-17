#!/bin/bash

#after registering service to consul client, it can be quired by dns service.
dig @127.0.0.1 -p 8600 counting.service.consul
