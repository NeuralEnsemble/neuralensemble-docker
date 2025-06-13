set -e

cd ../osb

./regenerateAll.sh

cd ../osb_models

./regenerate.sh
