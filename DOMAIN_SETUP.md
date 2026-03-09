# Custom Domain Setup Guide

## Option 1: Use Custom Domain (www.buslat.com)

If you own or plan to buy `buslat.com`:

### Step 1: Register Domain
- Register `buslat.com` through AWS Route 53, GoDaddy, Namecheap, or any registrar
- Cost: ~$10-15/year

### Step 2: Set S3 Bucket Name
Use the exact domain as your bucket name:
```
S3_BUCKET_NAME = www.buslat.com
```

### Step 3: Configure DNS

**If using AWS Route 53:**
1. Create a hosted zone for `buslat.com`
2. Add a CNAME record:
   - Name: `www`
   - Type: `CNAME`
   - Value: `www.buslat.com.s3-website-us-east-1.amazonaws.com`

**If using another registrar (GoDaddy, Namecheap, etc.):**
1. Go to DNS settings
2. Add a CNAME record:
   - Host: `www`
   - Points to: `www.buslat.com.s3-website-us-east-1.amazonaws.com`
   - TTL: 3600

### Step 4: Wait for DNS Propagation
- Takes 5 minutes to 48 hours
- Check status: `nslookup www.buslat.com`

### Step 5: Access Your Site
Visit: `http://www.buslat.com`

---

## Option 2: Use S3 URL (No Domain Required)

If you don't want to buy a domain, use a descriptive bucket name:

### Good Bucket Names:
```
apology-for-buslat
dear-buslat-from-oyindamola
buslat-apology-2026
forgive-me-mom-buslat
```

Set as your `S3_BUCKET_NAME` secret in GitHub.

Your URL will be:
```
http://YOUR-BUCKET-NAME.s3-website-us-east-1.amazonaws.com
```

**Pros:**
- Free (no domain cost)
- Works immediately
- No DNS configuration needed

**Cons:**
- Longer URL
- Less memorable

---

## Recommendation

**For this use case, I recommend Option 2** (S3 URL without custom domain):

**Suggested bucket name:**
```
dear-buslat-from-oyindamola
```

**Your URL would be:**
```
http://dear-buslat-from-oyindamola.s3-website-us-east-1.amazonaws.com
```

This is:
- Free
- Works immediately
- Still personal and meaningful
- Easy to share

You can always add a custom domain later if needed!

---

## HTTPS Support (Optional)

S3 website endpoints don't support HTTPS by default. For HTTPS, you need:
1. CloudFront distribution
2. ACM SSL certificate
3. Custom domain

Let me know if you want me to add CloudFront + HTTPS support!
