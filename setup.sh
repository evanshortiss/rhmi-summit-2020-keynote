PROJECT_NAME=keynote-rhmi-demo

echo -n "Creating project named $PROJECT_NAME on the cluster"
sleep 2

oc new-project $PROJECT_NAME

echo -n "Configuring AMQ Streams (Kafka) cluster"
sleep 2

oc apply -f amq-streams/operator.group.yml -n $PROJECT_NAME
oc apply -f amq-streams/operator.subscription.yml -n $PROJECT_NAME
oc apply -f amq-streams/kafka.cluster.yml -n $PROJECT_NAME
oc apply -f amq-streams/kafka.topic.yml -n $PROJECT_NAME

echo "Kafka resources applied, it may take a a few minutes for these to become available"