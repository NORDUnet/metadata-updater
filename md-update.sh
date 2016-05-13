#!/bin/bash
NODE_NAME="urn:oasis:names:tc:SAML:2.0:metadata:EntitiesDescriptor"

while getopts c:o: flag; do
  case $flag in
    c)
      CERT=$OPTARG
      ;;
    o)
      OUT=$OPTARG
      ;;
    ?)
      exit
      ;;
  esac
done
shift $((OPTIND-1))
URL=$1

if [ -z "$URL" ] || [ -z "OUT" ]; then
  echo "Usage: $(basename $0) [-c CERT_FILE] -o OUT_FILE URL"
  exit 1
fi

cleanup() {
  local file=$1
  if [ -f $file ]; then
    rm $file
  fi
}

FILE_NAME=$(basename "$OUT")
TMP=$(mktemp -t $FILE_NAME.XXXXXX)

wget -q -O $TMP $URL

if [ $? -eq 0 ]; then

  if [ -f "$CERT" ]; then
    xmlsec1 --verify --pubkey-cert-pem $CERT --id-attr:ID $NODE_NAME  $TMP > /dev/null 2>&1

    if [ $? -ne 0 ]; then
      cleanup $TMP
      exit 1
    fi
  fi

  cp $TMP $OUT
fi

cleanup $TMP
