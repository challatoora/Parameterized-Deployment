#!/bin/bash

# echo "================================"
# echo "       DEV DEPLOYMENT"
# echo "================================"

# echo "Deploying application to DEV environment"
# echo "DEV deployment completed successfully"


#!/bin/bash

DEV_SERVER="32.192.179.104"

echo "================================"
echo "       DEV DEPLOYMENT"
echo "================================"

echo "Connecting to DEV server: $DEV_SERVER"

ssh -o StrictHostKeyChecking=no ec2-user@$DEV_SERVER << 'EOF'

echo "Connected to DEV EC2"
echo "DEV deployment started"
echo "DEV deployment completed successfully"

EOF