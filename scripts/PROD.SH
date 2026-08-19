# #!/bin/bash

# echo "================================"
# echo "      PROD DEPLOYMENT"
# echo "================================"

# echo "Deploying application to PROD environment"
# echo "PROD deployment completed successfully"

#!/bin/bash

PROD_SERVER="44.200.210.73"

echo "================================"
echo "       PROD DEPLOYMENT"
echo "================================"

echo "Deploying to PROD server: $PROD_SERVER"

ssh -o StrictHostKeyChecking=no ec2-user@$PROD_SERVER << 'EOF'

echo "Connected to PROD EC2"
echo "PROD deployment started"

echo "PROD deployment completed successfully"

EOF