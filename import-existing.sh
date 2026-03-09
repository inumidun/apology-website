#!/bin/bash

# Script to import existing AWS resources into Terraform
# Run this locally if you already have resources created

echo "Importing existing AWS resources into Terraform..."
echo ""

# Get bucket name from terraform.tfvars or prompt
if [ -f terraform.tfvars ]; then
    BUCKET_NAME=$(grep bucket_name terraform.tfvars | cut -d'"' -f2)
    echo "Found bucket name in terraform.tfvars: $BUCKET_NAME"
else
    read -p "Enter your S3 bucket name: " BUCKET_NAME
fi

echo ""
echo "Attempting to import resources for bucket: $BUCKET_NAME"
echo ""

# Import S3 bucket
echo "1. Importing S3 bucket..."
terraform import aws_s3_bucket.website "$BUCKET_NAME" 2>/dev/null
if [ $? -eq 0 ]; then
    echo "   ✓ S3 bucket imported successfully"
else
    echo "   ℹ S3 bucket already in state or doesn't exist"
fi

# Import S3 website configuration
echo "2. Importing S3 website configuration..."
terraform import aws_s3_bucket_website_configuration.website "$BUCKET_NAME" 2>/dev/null
if [ $? -eq 0 ]; then
    echo "   ✓ Website configuration imported successfully"
else
    echo "   ℹ Website configuration already in state or doesn't exist"
fi

# Import S3 public access block
echo "3. Importing S3 public access block..."
terraform import aws_s3_bucket_public_access_block.website "$BUCKET_NAME" 2>/dev/null
if [ $? -eq 0 ]; then
    echo "   ✓ Public access block imported successfully"
else
    echo "   ℹ Public access block already in state or doesn't exist"
fi

# Import S3 bucket policy
echo "4. Importing S3 bucket policy..."
terraform import aws_s3_bucket_policy.website "$BUCKET_NAME" 2>/dev/null
if [ $? -eq 0 ]; then
    echo "   ✓ Bucket policy imported successfully"
else
    echo "   ℹ Bucket policy already in state or doesn't exist"
fi

echo ""
echo "Import complete! Now run:"
echo "  terraform plan"
echo "  terraform apply"
