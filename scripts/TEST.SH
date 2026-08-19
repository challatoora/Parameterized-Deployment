# #!/bin/bash

# echo "================================"
# echo "          TESTING"
# echo "================================"

# echo "Running application tests"
# echo "Tests completed successfully"

#!/bin/bash

TEST_SERVER="100.58.244.119"

echo "================================"
echo "       TEST DEPLOYMENT"
echo "================================"

echo "Deploying to TEST server: $TEST_SERVER"

ssh -o StrictHostKeyChecking=no ec2-user@$TEST_SERVER << 'EOF'

echo "Connected to TEST EC2"
echo "TEST deployment started"

echo "TEST deployment completed successfully"

EOF