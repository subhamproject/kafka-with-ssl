#!/bin/bash

set -o nounset \
    -o errexit
PASS="password"
printf "Deleting previous (if any)..."
mkdir -p secrets
mkdir -p tmp
echo " OK!"
# Generate CA key
printf "Creating CA..."
openssl req -new -x509 -keyout tmp/kafka-ca.key -out tmp/kafka-ca.crt -days 3650 -subj '/CN=Kafka CA/OU=Devops/O=Devopsforall/L=Hyderabad/C=IN' -passin pass:$PASS -passout pass:$PASS >/dev/null 2>&1

echo " OK!"

for i in 'kafka1' 'kafka2' 'kafka3' 'producer' 'consumer' 'zk1' 'zk2' 'zk3' 'root' 'Dev'
do
	if [[ ! -f secrets/$i.keystore.jks ]] && [[ ! -f secrets/$i.truststore.jks ]];then
	printf "Creating cert and keystore of $i..."
	# Create keystores
	keytool -genkey -noprompt \
				 -alias $i \
				 -dname "CN=$i, OU=Devops, O=Devopsforall, L=Hyderabad, C=IN" \
				 -keystore secrets/$i.keystore.jks \
				 -keyalg RSA \
				 -storepass $PASS \
				 -keypass $PASS  >/dev/null 2>&1

	# Create CSR, sign the key and import back into keystore
	keytool -keystore secrets/$i.keystore.jks -alias $i -certreq -file tmp/$i.csr -storepass $PASS -keypass $PASS >/dev/null 2>&1

	openssl x509 -req -CA tmp/kafka-ca.crt -CAkey tmp/kafka-ca.key -in tmp/$i.csr -out tmp/$i-ca-signed.crt -days 1825 -CAcreateserial -passin pass:$PASS  >/dev/null 2>&1

	keytool -keystore secrets/$i.keystore.jks -alias CARoot -import -noprompt -file tmp/kafka-ca.crt -storepass $PASS -keypass $PASS >/dev/null 2>&1

	keytool -keystore secrets/$i.keystore.jks -alias $i -import -file tmp/$i-ca-signed.crt -storepass $PASS -keypass $PASS >/dev/null 2>&1

	# Create truststore and import the CA cert.
	keytool -keystore secrets/$i.truststore.jks -alias CARoot -import -noprompt -file tmp/kafka-ca.crt -storepass $PASS -keypass $PASS >/dev/null 2>&1
  echo " OK!"
     else
	printf "Keystore: $i.keystore.jks and truststore: $i.truststore.jks already exist..skipping creating it again.."
	echo " OK!"
  fi
done

echo "$PASS" > secrets/cert_creds
rm -rf tmp

echo "SUCCEEDED"
