# Apology Website

A personalized static website hosted on AWS S3 with automated GitHub Actions deployment.

## Prerequisites

- AWS Account with appropriate credentials
- GitHub account
- Git installed locally

## Setup Instructions

### 1. Create GitHub Repository

```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
git push -u origin main
```

### 2. Configure GitHub Secrets

Go to your GitHub repository → Settings → Secrets and variables → Actions

Add these secrets:
- `AWS_ACCESS_KEY_ID`: Your AWS access key
- `AWS_SECRET_ACCESS_KEY`: Your AWS secret key
- `S3_BUCKET_NAME`: A globally unique bucket name (e.g., `apology-website-oyindamola-12345`)

### 3. Deploy

The website will automatically deploy when you push to the `main` branch:

```bash
git add .
git commit -m "Update website"
git push
```

Or trigger manually from GitHub Actions tab → Deploy to S3 → Run workflow

### 4. Access Your Website

After the GitHub Action completes:
1. Go to Actions tab in your repository
2. Click on the latest workflow run
3. The website URL will be displayed in the summary

Alternatively, the URL format is:
```
http://YOUR-BUCKET-NAME.s3-website-us-east-1.amazonaws.com
```

## Manual Deployment (Optional)

If you prefer to deploy manually without GitHub Actions:

### 1. Configure AWS Credentials

```bash
aws configure
```

### 2. Configure Terraform Variables

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` and set your bucket name.

### 3. Deploy

```bash
terraform init
terraform apply
```

## Website Features

- Multi-page scrolling experience
- Personalized apology letter
- Animated floating petals
- Responsive design for mobile and desktop
- Beautiful typography and styling

## Updating the Website

If you make changes to the HTML, CSS, or JavaScript files:

```bash
terraform apply
```

Terraform will automatically detect changes and update the S3 bucket.

## Cleanup

To remove all AWS resources:

```bash
terraform destroy
```

Type `yes` when prompted to confirm.

## Cost

S3 static website hosting is very inexpensive:
- Storage: ~$0.023 per GB per month
- Data transfer: First 100GB free per month
- Requests: Minimal cost for personal use

For a small static site with light traffic, expect costs under $1/month.
