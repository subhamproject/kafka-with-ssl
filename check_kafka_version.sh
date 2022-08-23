#!/bin/bash


CMD="--version --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 --command-config /tmp/root.properties"

printf "Currently running kafka version.."
echo " OK!"
echo "------------------------------------------------------------"
docker run --rm -it -v $(pwd):/tmp --network kafka_default --entrypoint /opt/bitnami/kafka/bin/kafka-topics.sh bitnami/kafka:3.1.0 $CMD
