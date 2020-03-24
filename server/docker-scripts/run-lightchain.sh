set -e

DATADIR="/srv/lightchain"

if [ -z "${NETWORK}" ]; then
	echo "Using default network standalone"
	NETWORK="standalone"
fi

if [ ! -d "${DATADIR}/database" ]; then
	echo "Initialize lightchain node in ${DATADIR}"
	lightchain init --datadir=${DATADIR} --${NETWORK}
fi

nohup lightchain run --datadir=${DATADIR} \
  --rpc --rpcaddr=0.0.0.0 --rpcport=8545 \
  --rpcapi=eth,net,web3,personal,debug

sleep 5

echo "Ligtchain Running..."
#Keeps container alive
tail -f /dev/null