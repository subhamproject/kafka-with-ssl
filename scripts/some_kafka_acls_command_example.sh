./kafka–acls.sh —bootstrap–server public_ip_of_kafka_node:9092 —command–config kafka.properties —add —deny–principal User:test —operation Write —topic test —force

./kafka–acls.sh —bootstrap–server public_ip_of_kafka_node:9092 —command–config kafka.properties —add —deny–principal User:test —operation All —topic test —force

./kafka–acls.sh —bootstrap–server public_ip_of_kafka_node:9092 —command–config kafka.properties —add —allow–principal User:test —operation Read —topic test —force

./kafka-acls.sh --bootstrap-server public_ip_of_kafka_node:9092 --command-config kafka.properties --remove --deny-principal User:test --operation Write --topic test --force

./kafka-acls.sh --bootstrap-server public_ip_of_kafka_node:9092 --command-config kafka.properties --remove --deny-principal User:test --operation All --topic test --force

./kafka-acls.sh --bootstrap-server public_ip_of_kafka_node:9092 --command-config kafka.properties --remove --allow-principal User:test --operation Read --topic test --force

./kafka-acls.sh --bootstrap-server public_ip_of_kafka_node:9092 --command-config kafka.properties --add --deny-principal User:write --operation Read --topic instaclustr --resource-pattern-type prefixed --force
