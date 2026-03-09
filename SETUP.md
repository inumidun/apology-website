# Complete Setup Guide - Deploy Your Website to AWS S3

This guide will walk you through every step to deploy your personalized website to AWS S3 using GitHub Actions.

---

## Prerequisites

Before you begin, make sure you have:
- [ ] A GitHub account (create one at https://github.com if needed)
- [ ] An AWS account (create one at https://aws.amazon.com if needed)
- [ ] Git installed on your computer
- [ ] A text editor or IDE (VS Code, Notepad++, etc.)

---

## Part 1: Get Your AWS Credentials

### Step 1.1: Log into AWS Console
1. Go to https://aws.amazon.com
2. Click **Sign In to the Console**
3. Enter your credentials

### Step 1.2: Create IAM User (if you don't have one)
1. In AWS Console, search for **IAM** in the top search bar
2. Click **Users** in the left sidebar
3. Click **Create user** button
4. Enter username: `github-deployer`
5. Click **Next**

### Step 1.3: Set Permissions
1. Select **Attach policies directly**
2. Search for and check these policies:
   - `AmazonS3FullAccess`
3. Click **Next**
4. Click **Create user**

### Step 1.4: Create Access Keys
1. Click on the user you just created (`github-deployer`)
2. Click **Security credentials** tab
3. Scroll down to **Access keys** section
4. Click **Create access key**
5. Select **Application running outside AWS**
6. Click **Next**
7. Add description: `GitHub Actions deployment`
8. Click **Create access key**

### Step 1.5: Save Your Credentials
**IMPORTANT:** Copy these values immediately - you won't see them again!

```
AWS_ACCESS_KEY_ID: AKIA... (starts with AKIA)
AWS_SECRET_ACCESS_KEY: wJalr... (long random string)
```

Save these in a secure location (password manager, secure note, etc.)

---

## Part 2: Create GitHub Repository

### Step 2.1: Create Repository on GitHub
1. Go to https://github.com
2. Click the **+** icon in top right
3. Click **New repository**
4. Repository name: `apology-website` (or any name you prefer)
5. Description: `A heartfelt apology website for Mom`
6. Select **Private** (recommended) or **Public**
7. **DO NOT** check "Initialize with README"
8. Click **Create repository**

### Step 2.2: Note Your Repository URL
Copy the repository URL shown on the next page. It looks like:
```
https://github.com/YOUR_USERNAME/apology-website.git
```

---

## Part 3: Push Your Code to GitHub

### Step 3.1: Open Terminal/Command Prompt
- **Windows:** Press `Win + R`, type `cmd`, press Enter
- **Mac:** Press `Cmd + Space`, type `terminal`, press Enter
- **Linux:** Press `Ctrl + Alt + T`

### Step 3.2: Navigate to Your Project Folder
```bash
cd path/to/your/project
```
Replace `path/to/your/project` with the actual path where your website files are located.

### Step 3.3: Initialize Git Repository
```bash
git init
```

### Step 3.4: Add All Files
```bash
git add .
```

### Step 3.5: Create First Commit
```bash
git commit -m "Initial commit: Apology website for Buslat"
```

### Step 3.6: Set Main Branch
```bash
git branch -M main
```

### Step 3.7: Connect to GitHub
Replace `YOUR_USERNAME` and `YOUR_REPO` with your actual values:
```bash
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
```

Example:
```bash
git remote add origin https://github.com/oyindamola/apology-website.git
```

### Step 3.8: Push to GitHub
```bash
git push -u origin main
```

If prompted for credentials:
- Username: Your GitHub username
- Password: Use a Personal Access Token (not your password)
  - Create token at: https://github.com/settings/tokens
  - Select **repo** scope
  - Copy and paste the token as password

---

## Part 4: Configure GitHub Secrets

### Step 4.1: Go to Repository Settings
1. Go to your repository on GitHub
2. Click **Settings** tab (top right)
3. In left sidebar, click **Secrets and variables**
4. Click **Actions**

### Step 4.2: Add AWS Access Key ID
1. Click **New repository secret** button
2. Name: `AWS_ACCESS_KEY_ID`
3. Secret: Paste your AWS Access Key ID (from Part 1.5)
4. Click **Add secret**

### Step 4.3: Add AWS Secret Access Key
1. Click **New repository secret** button
2. Name: `AWS_SECRET_ACCESS_KEY`
3. Secret: Paste your AWS Secret Access Key (from Part 1.5)
4. Click **Add secret**

### Step 4.4: Add S3 Bucket Name
1. Click **New repository secret** button
2. Name: `S3_BUCKET_NAME`
3. Secret: Choose a unique bucket name (see options below)
4. Click **Add secret**

**Bucket Name Options:**
- Recommended: `dear-buslat-from-oyindamola`
- Alternative: `apology-for-buslat-2026`
- With numbers: `buslat-apology-12345`
- Custom domain: `www.buslat.com` (only if you own the domain)

**Important:** S3 bucket names must be:
- Globally unique across ALL AWS accounts
- Lowercase letters, numbers, and hyphens only
- Between 3-63 characters
- No spaces or special characters

### Step 4.5: Verify Secrets
You should now see 3 secrets listed:
- ✓ AWS_ACCESS_KEY_ID
- ✓ AWS_SECRET_ACCESS_KEY
- ✓ S3_BUCKET_NAME

---

## Part 5: Deploy Your Website

### Step 5.1: Trigger Deployment
The deployment happens automatically when you push to GitHub, but let's trigger it manually first:

1. Go to your repository on GitHub
2. Click **Actions** tab (top menu)
3. Click **Deploy to S3** workflow in the left sidebar
4. Click **Run workflow** button (right side)
5. Keep branch as `main`
6. Click green **Run workflow** button

### Step 5.2: Watch Deployment Progress
1. You'll see a new workflow run appear
2. Click on it to see details
3. Watch the steps execute (takes about 2-3 minutes)
4. Wait for all steps to show green checkmarks ✓

### Step 5.3: Get Your Website URL
After deployment completes:
1. Scroll down to the **Summary** section
2. You'll see: **🚀 Deployment Successful!**
3. Copy the Website URL shown

The URL format will be:
```
http://YOUR-BUCKET-NAME.s3-website-us-east-1.amazonaws.com
```

Example:
```
http://dear-buslat-from-oyindamola.s3-website-us-east-1.amazonaws.com
```

### Step 5.4: Visit Your Website
1. Open a web browser
2. Paste the URL
3. Your website should load! 🎉

---

## Part 6: Making Updates

### Step 6.1: Edit Files Locally
Make changes to any files (index.html, styles.css, etc.)

### Step 6.2: Commit and Push Changes
```bash
git add .
git commit -m "Updated message for Mom"
git push
```

### Step 6.3: Automatic Deployment
- GitHub Actions will automatically deploy your changes
- Go to **Actions** tab to watch progress
- Changes will be live in 2-3 minutes

---

## Troubleshooting

### Problem: "Bucket name already exists"
**Solution:** Someone else is using that bucket name. Try:
- Add random numbers: `dear-buslat-from-oyindamola-7392`
- Add year: `apology-for-buslat-2026`
- Make it more unique: `oyindamola-apology-to-buslat`

### Problem: GitHub Actions failing with "Access Denied"
**Solution:** Check your AWS credentials:
1. Verify secrets are set correctly (no extra spaces)
2. Make sure IAM user has `AmazonS3FullAccess` policy
3. Try creating new access keys

### Problem: Website shows "Access Denied" or 403 error
**Solution:** The bucket policy might not be applied yet:
1. Wait 2-3 minutes and refresh
2. Check GitHub Actions completed successfully
3. Verify all green checkmarks in Actions tab

### Problem: "git push" asks for password
**Solution:** GitHub no longer accepts passwords:
1. Go to https://github.com/settings/tokens
2. Click **Generate new token (classic)**
3. Select **repo** scope
4. Copy the token
5. Use token as password when prompted

### Problem: Can't find my project folder
**Solution:** 
- Windows: Open File Explorer, navigate to folder, copy path from address bar
- Mac: Right-click folder, hold Option key, click "Copy as Pathname"
- Or use `cd` to navigate: `cd Desktop/apology-website`

### Problem: Website not loading after deployment
**Solution:**
1. Check Actions tab - all steps should be green ✓
2. Wait 2-3 minutes for S3 to propagate
3. Try accessing in incognito/private browser window
4. Check the URL is exactly as shown in Actions summary

---

## Cost Information

Your website will cost approximately:
- **Storage:** $0.023 per GB/month (your site is ~0.001 GB = $0.00002/month)
- **Requests:** $0.0004 per 1,000 requests (first 100GB transfer free)
- **Total:** Less than $0.10/month for typical personal use

**Estimated monthly cost: Less than $1**

---

## Deleting the Website (Optional)

If you want to remove everything:

### Option 1: Via AWS Console
1. Go to AWS S3 Console
2. Find your bucket
3. Select it and click **Empty**
4. Then click **Delete**

### Option 2: Via Terraform (if you have it installed)
```bash
terraform destroy
```

---

## Next Steps

✓ Your website is now live!
✓ Share the URL with Buslat
✓ Make updates anytime by editing files and pushing to GitHub

**Optional Enhancements:**
- Add custom domain (see DOMAIN_SETUP.md)
- Enable HTTPS with CloudFront
- Add more pages or animations
- Customize colors and styling

---

## Need Help?

If you get stuck:
1. Check the Troubleshooting section above
2. Review GitHub Actions logs for error messages
3. Verify all secrets are set correctly
4. Make sure AWS credentials have proper permissions

---

## Summary Checklist

- [ ] Created AWS IAM user with S3 access
- [ ] Saved AWS access key ID and secret key
- [ ] Created GitHub repository
- [ ] Pushed code to GitHub
- [ ] Added 3 secrets to GitHub (AWS keys + bucket name)
- [ ] Ran GitHub Actions workflow
- [ ] Got website URL from Actions summary
- [ ] Visited website and confirmed it works
- [ ] Shared URL with Buslat ❤️

**Congratulations! Your website is live! 🎉**
