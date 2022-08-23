#!/bin/bash

#https://www.baeldung.com/ops/listing-kafka-consumers

#To list consumer group
./bin/kafka-consumer-groups.sh --list --bootstrap-server localhost:9092

#To see member of group
./bin/kafka-consumer-groups.sh --describe --group new-user --members --bootstrap-server localhost:9092


./bin/kafka-consumer-groups.sh --describe --group new-user --bootstrap-server localhost:9092

./bin/kafka-consumer-groups --bootstrap-server localhost:9093 --group consumergroup --describe --command-config ssl.properties
