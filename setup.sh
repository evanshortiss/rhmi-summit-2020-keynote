PROJECT_NAME=keynote-rhmi-demo

echo "Creating project named $PROJECT_NAME on the cluster"
sleep 2

oc new-project $PROJECT_NAME

echo "Verifying operator sources contain \"strimzi-kafka-operator\""
KAFKAS=$(oc get packagemanifests -n openshift-marketplace | grep "strimzi-kafka-operator" | wc -l | awk '{print $1}')

if [ "$KAFKAS" -eq "0" ]; then
    echo "Kafka operator(s) not found. Aborting."
    exit 1
fi


echo "Configuring AMQ Streams (Kafka) cluster"
sleep 2

# generate the subscription using the correct source (differs in OCP vs. OSD)
KAFKA_PROVDER=$(oc get packagemanifests/strimzi-kafka-operator -n openshift-marketplace -o jsonpath={.metadata.labels.opsrc-owner-name})
sed 's/SOURCE_NAME/community-operators/g' ./amq-streams/operator.subscription.yml > /tmp/operator.subscription.yml

oc apply -f amq-streams/operator.group.yml -n $PROJECT_NAME
oc apply -f /tmp/operator.subscription.yml -n $PROJECT_NAME # note the/tmp file is used

echo "Giving the operator a while to get setup. Please wait."
sleep 15
echo "Creating Kafka cluster and topic"
oc apply -f amq-streams/kafka.cluster.yml -n $PROJECT_NAME
oc apply -f amq-streams/kafka.topic.yml -n $PROJECT_NAME

echo "Kafka resources applied, it may take a few minutes for these to be ready"