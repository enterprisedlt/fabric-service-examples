#!/bin/bash

# before running this script do:
# export PATH=$PATH:<path to fabric-service-node/bin>

./clean-docker.sh

# pack chain-code to deploy-able tarball and spread to organizations:
fabric-service-pack-chaincode.sh ./chain-code/example example-1.0.tgz
cp -v ./chain-code/example/example-1.0.tgz ./test-network/org1/chain-code/
cp -v ./chain-code/example/example-1.0.tgz ./test-network/org2/chain-code/

# start ORG1
fabric-service-start.sh ./test/org1
fabric-service-bootstrap.sh ./test/org1
#fabric-service-create-contract.sh ./test/org1 ./dummy-contract.json

#fabric-service-create-user.sh ./test/org1 abc
#fabric-service-get-user-key.sh ./test/org1 abc abc ./abc.p12

# make invite from ORG1
fabric-service-create-invite.sh ./test/org1 ./test/invite_1.json

# join ORG2 using invite
./fabric-service-start.sh ./test/org2
fabric-service-join.sh ./test/org2 ./test/invite_1.json


## make invite from ORG2
#fabric-service-create-invite.sh ./test/org2 ./test/invite_2.json
#
## join ORG3 using invite
#./fabric-service-start-dev.sh ./test/org3
#fabric-service-join.sh ./test/org3 ./test/invite_2.json

## make invite from ORG3
#fabric-service-create-invite.sh ./test/org3 ./test/invite_3.json
#
## join ORG2 using invite
#./fabric-service-start-dev.sh ./test/org4
#fabric-service-join.sh ./test/org4 ./test/invite_3.json

##
#fabric-service-message-send.sh ./test/org1 org2 hey1
#fabric-service-message-send.sh ./test/org2 org3 hey2
#fabric-service-message-send.sh ./test/org3 org1 hey3
#
#fabric-service-messages-list.sh ./test/org1
#fabric-service-messages-list.sh ./test/org2
#fabric-service-messages-list.sh ./test/org3
