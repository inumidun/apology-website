# Troubleshooting Guide

## Error: BucketAlreadyExists

### Problem
```
Error: creating S3 Bucket: BucketAlreadyExists
```

This means either:
- You already created a bucket with this name
- Someone else in the world is using this bucket name (S3 names are globally unique)

### Solution 1: Use a Different Bucket Name (Easiest)

Update your GitHub Secret `S3_BUCKET_NAME` to a new unique name:

**Try these names:**
```
dear-buslat-oyindamola-2026
apology-for-buslat-march-2026
buslat-forgiveness-site-xyz123
oyindamola-to-buslat-website
```

**Steps:**
1. Go to your GitHub repository
2. Settings → Secrets and variables → Actions
3. Click on `S3_BUCKET_NAME`
4. Click **Update**
5. Enter a new unique name
6. Click **Update secret**
7. Go to Actions tab and re-run the workflow

### Solution 2: Delete Existing Bucket

If you created the bucket before and want to reuse the name:

**Via AWS Console:**
1. Go to https://s3.console.aws.amazon.com
2. Find your bucket (search for the name)
3. Select the bucket
4. Click **Empty** button
5. Type "permanently delete" and confirm
6. Click **Delete** button
7. Type the bucket name and confirm
8. Re-run GitHub Actions workflow

**Via AWS CLI:**
```bash
# Empty the bucket first
aws s3 rm s3://YOUR-BUCKET-NAME --recursive

# Delete the bucket
aws s3 rb s3://YOUR-BUCKET-NAME

# Delete CloudFront OAC if it exists
aws cloudfront list-origin-access-controls --query "OriginAccessControlList.Items[?Name=='YOUR-BUCKET-NAME-oac'].Id" --output text | xargs -I {} aws cloudfront delete-origin-access-control --id {}
```

---

## Error: OriginAccessControlAlreadyExists

### Problem
```
Error: creating CloudFront Origin Access Control: OriginAccessControlAlreadyExists
```

This means you have an existing CloudFront OAC with the same name.

### Solution

**Via AWS Console:**
1. Go to CloudFront console
2. Click **Origin access** in left sidebar
3. Find the OAC with your bucket name
4. Delete it
5. Re-run GitHub Actions workflow

**Via AWS CLI:**
```bash
# List all OACs
aws cloudfront list-origin-access-controls

# Delete specific OAC (replace ID)
aws cloudfront delete-origin-access-control --id YOUR-OAC-ID --if-match ETAG
```

**Or just use a different bucket name** (Solution 1 above) - this will create a new OAC automatically.

---

## Error: Access Denied

### Problem
```
Error: Access Denied
```

### Solution
Check your AWS credentials:
1. Verify GitHub Secrets are set correctly:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - No extra spaces or line breaks
2. Verify IAM user has these permissions:
   - `AmazonS3FullAccess`
   - `CloudFrontFullAccess`
3. Try creating new access keys in AWS IAM

---

## Error: GitHub Actions Failing

### Problem
Workflow fails with various errors

### Solution
1. Check the Actions tab for detailed error logs
2. Look for the specific error message
3. Verify all 3 secrets are set:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - `S3_BUCKET_NAME`
4. Make sure bucket name is:
   - Lowercase only
   - No spaces
   - Only letters, numbers, and hyphens
   - 3-63 characters long

---

## CloudFront Takes Too Long

### Problem
CloudFront deployment taking more than 15 minutes

### Solution
This is normal for first deployment. CloudFront can take:
- First deployment: 10-20 minutes
- Subsequent updates: 2-5 minutes

Just wait patiently. Check AWS CloudFront console to see status.

---

## Website Shows 403 Forbidden

### Problem
CloudFront URL shows "403 Forbidden" error

### Solution
1. Wait 15 minutes after first deployment
2. Check GitHub Actions completed successfully (all green checkmarks)
3. Verify S3 bucket policy was applied
4. Try accessing in incognito/private browser window
5. Clear browser cache

---

## Website Not Updating

### Problem
Made changes but website still shows old content

### Solution
CloudFront caches content. Options:

**Option 1: Wait**
- Cache expires after 1 hour
- Just wait and it will update

**Option 2: Invalidate Cache**
```bash
# Get distribution ID
aws cloudfront list-distributions --query "DistributionList.Items[?Comment=='Apology website for Buslat'].Id" --output text

# Create invalidation
aws cloudfront create-invalidation --distribution-id YOUR-DIST-ID --paths "/*"
```

**Option 3: Hard Refresh**
- Chrome/Firefox: Ctrl + Shift + R (Windows) or Cmd + Shift + R (Mac)
- Safari: Cmd + Option + R

---

## Quick Fixes Checklist

- [ ] Bucket name is globally unique (add random numbers if needed)
- [ ] All 3 GitHub secrets are set correctly
- [ ] AWS IAM user has S3 and CloudFront permissions
- [ ] Waited 15 minutes after first CloudFront deployment
- [ ] Tried accessing in incognito/private mode
- [ ] Checked GitHub Actions logs for specific errors

---

## Still Having Issues?

1. Check the specific error message in GitHub Actions logs
2. Search for the error in this guide
3. Try using a completely different bucket name with random numbers
4. Verify AWS credentials are correct and have proper permissions
5. Make sure you're in the correct AWS region (us-east-1)

## Need to Start Fresh?

Delete everything and start over:

```bash
# Delete S3 bucket
aws s3 rb s3://YOUR-BUCKET-NAME --force

# List and delete CloudFront distributions
aws cloudfront list-distributions

# Delete OAC
aws cloudfront list-origin-access-controls
```

Then follow SETUP.md from the beginning with a new bucket name.
