set -e

cd ../base
./regenerate.sh

cd ../simulation
./regenerate.sh

cd ../simulationx

./regenerate.sh
