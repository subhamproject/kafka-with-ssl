#!/bin/bash
#https://sleeplessbeastie.eu/2021/11/15/how-to-reset-offset-of-kafka-consumer-group/

CONSUMER_GROUP=$1

[ -v $CONSUMER_GROUP ] && { echo "Please provide consumer group name you wish to describe details?" ; exit 1 ; }


CMD="--describe --group $CONSUMER_GROUP --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 --command-config /tmp/root.properties"

docker run --rm -it -v $(pwd):/tmp --network kafka_default --entrypoint /opt/bitnami/kafka/bin/kafka-consumer-groups.sh bitnami/kafka:3.1.0 $CMD
