set -e

cd ../base
./generate.sh

cd ../simulation
./generate.sh

cd ../simulationx

./generate.sh

cd ../osb

./generate.sh

