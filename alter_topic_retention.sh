#!/bin/bash


KAFKA_TOPIC=$1
RETENTION_IN_MS=${2:-300000}

[ -v $KAFKA_TOPIC ] && { echo "Please provide kafka topic name you wish to alter retention?" ; exit 1 ; }

CMD="--alter --add-config retention.ms=$RETENTION_IN_MS --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 --command-config /tmp/root.properties --topic $KAFKA_TOPIC"

docker run --rm -it -v $(pwd):/tmp --network kafka_default --entrypoint /opt/bitnami/kafka/bin/kafka-configs.sh bitnami/kafka:3.1.0 $CMD |awk 'BEGIN{IFS="=";IRS=" "} /^[ ]*retention.ms/{print $1}'|xargs
[ $? -eq 0 ] && printf "Completed updating config for topic $KAFKA_TOPIC.."
echo " Ok!"
