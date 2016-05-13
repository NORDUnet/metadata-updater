#/bin/bash
CERT=$1
METADATA=$2
NODE_NAME="urn:oasis:names:tc:SAML:2.0:metadata:EntitiesDescriptor"

xmlsec1 --verify --pubkey-cert-pem $CERT --id-attr:ID $NODE_NAME  $METADATA
