#!/bin/bash


CMD="--describe --all-groups --state --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 --command-config /tmp/root.properties"

docker run --rm -it -v $(pwd):/tmp --network kafka_default --entrypoint /opt/bitnami/kafka/bin/kafka-consumer-groups.sh bitnami/kafka:3.1.0 $CMD
