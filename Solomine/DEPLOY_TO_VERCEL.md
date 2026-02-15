# 🚀 Deploy Solomine Web to Vercel

## Your Repository
https://github.com/robjobbed/Solomine

## 🎯 Quick Deploy (2 Minutes)

### Step 1: Push Web Folder to GitHub

```bash
# Make sure you're in the root of your Solomine project
cd ~/path/to/Solomine

# Add all web files
git add web/

# Commit
git commit -m "Add web version"

# Push to GitHub
git push origin main
```

### Step 2: Deploy on Vercel

#### Option A: Vercel Dashboard (Easiest)

1. Go to https://vercel.com/new

2. Click **"Import Git Repository"**

3. Enter your repo: `robjobbed/Solomine`

4. Configure Project:
   - **Framework Preset**: Next.js
   - **Root Directory**: `web` ← IMPORTANT!
   - **Build Command**: `npm run build`
   - **Output Directory**: `.next`
   - **Install Command**: `npm install`

5. Click **"Deploy"**

6. Done! Your site will be live at: `https://solomine-web.vercel.app`

#### Option B: Vercel CLI (Faster)

```bash
# Install Vercel CLI (one time)
npm install -g vercel

# Navigate to web folder
cd web

# Login to Vercel
vercel login

# Deploy
vercel

# Follow prompts:
# - Set up and deploy? Yes
# - Which scope? Your account
# - Link to existing project? No
# - What's your project's name? solomine-web
# - In which directory is your code? ./
# - Override settings? No

# Deploy to production
vercel --prod
```

---

## 🌐 Your Live URLs

After deployment, you'll get:

- **Preview**: `https://solomine-web-git-main-robjobbed.vercel.app`
- **Production**: `https://solomine-web.vercel.app`
- **Custom Domain**: `https://solomine.com` (optional - configure in Vercel)

---

## 📁 Repository Structure

Your repo should look like this:

```
Solomine/
├── iOS App Files...          # Your SwiftUI app
├── web/                      # Web version (deployed separately)
│   ├── app/
│   ├── components/
│   ├── package.json
│   └── ...
├── WEB_VERSION_GUIDE.md
├── README.md
└── ...
```

Vercel will only deploy the `web/` folder!

---

## ⚙️ Vercel Project Settings

### Root Directory
Set to: `web`

This tells Vercel to look in the `web/` folder for your Next.js app.

### Environment Variables (Optional)

Add these in Vercel Dashboard → Settings → Environment Variables:

```
NEXT_PUBLIC_API_URL=https://api.solomine.io
NEXTAUTH_SECRET=your-secret-here
NEXTAUTH_URL=https://solomine-web.vercel.app
```

### Build Settings (Auto-detected)

- Framework: Next.js
- Build Command: `npm run build`
- Output Directory: `.next`
- Install Command: `npm install`
- Node Version: 18.x

---

## 🔄 Auto-Deploy on Push

After initial setup, Vercel will automatically:

1. **Watch your GitHub repo**
2. **Deploy on every push to `main`**
3. **Create preview URLs for PRs**

To update your site:
```bash
# Make changes in web/ folder
cd web
# Edit files...

# Commit and push
git add .
git commit -m "Update web app"
git push origin main

# Vercel auto-deploys! ✨
```

---

## 🎨 Custom Domain (Optional)

### Add Your Domain

1. Buy domain (Vercel, Namecheap, etc.)
2. In Vercel dashboard → Domains
3. Add domain: `solomine.com`
4. Update DNS records (Vercel provides instructions)
5. Done! Site live at your domain

### Recommended Domains
- `solomine.com`
- `solomine.app`
- `solomine.io`
- `getsolomine.com`

---

## 📊 Monitor Your Deployment

### Vercel Dashboard
https://vercel.com/robjobbed/solomine-web

View:
- Deployment status
- Analytics
- Logs
- Performance metrics
- Build times

### GitHub Integration

Vercel comments on PRs with preview URLs:
```
✅ Preview deployed!
🌐 https://solomine-web-pr-123.vercel.app
```

---

## 🐛 Troubleshooting

### Build Fails

**Check root directory:**
- Go to Vercel → Project Settings → General
- Root Directory should be `web`

**Check logs:**
- Click on failed deployment
- View "Build Logs"
- Fix errors shown

### 404 on Routes

**Ensure Next.js app router:**
- Files should be in `web/app/` not `web/pages/`
- Already configured correctly!

### Environment Variables Not Working

**Add in Vercel:**
1. Project Settings → Environment Variables
2. Add each variable
3. Select: Production, Preview, Development
4. Redeploy

---

## 📝 Complete Deployment Checklist

### Pre-Deployment
- [x] Web files created in `/web` folder
- [x] All dependencies in package.json
- [x] TypeScript configured
- [x] Tailwind configured
- [x] All pages working locally

### GitHub
- [ ] Commit web/ folder
- [ ] Push to main branch
- [ ] Verify files on GitHub: https://github.com/robjobbed/Solomine/tree/main/web

### Vercel
- [ ] Import repository
- [ ] Set root directory to `web`
- [ ] Deploy
- [ ] Test live site
- [ ] Configure custom domain (optional)

### Post-Deployment
- [ ] Test all pages
- [ ] Test theme toggle
- [ ] Test on mobile
- [ ] Check performance
- [ ] Set up analytics (optional)

---

## 🚀 Deploy Commands

```bash
# From project root
cd ~/path/to/Solomine

# Add web files
git add web/

# Commit
git commit -m "🌐 Add web version"

# Push
git push origin main

# Deploy via CLI
cd web
vercel --prod
```

---

## 🎉 Success!

Your Solomine web app is live when you can:

✅ Visit your Vercel URL  
✅ See the login page  
✅ Sign in (mock auth)  
✅ Navigate all pages  
✅ Toggle themes  
✅ Works on mobile  

**Your web app is deployed!** 🌐

---

## 🔗 Quick Links

### Your Repository
https://github.com/robjobbed/Solomine

### Vercel Dashboard
https://vercel.com/dashboard

### Deploy New Project
https://vercel.com/new

### Documentation
- [Next.js on Vercel](https://vercel.com/docs/frameworks/nextjs)
- [Custom Domains](https://vercel.com/docs/concepts/projects/custom-domains)
- [Environment Variables](https://vercel.com/docs/concepts/projects/environment-variables)

---

## 📞 Need Help?

### Test Locally First
```bash
cd web
npm install
npm run dev
```

If it works locally, it will work on Vercel!

### Common Issues

**"No such file or directory"**
- Set Root Directory to `web` in Vercel settings

**"Module not found"**
- Check package.json includes all dependencies
- Try: `cd web && npm install`

**"Build failed"**
- Read build logs in Vercel dashboard
- Test locally: `npm run build`

---

## 🎊 Next Steps

1. **Push to GitHub:**
   ```bash
   git add web/
   git commit -m "🌐 Add web version"
   git push origin main
   ```

2. **Deploy on Vercel:**
   - Go to https://vercel.com/new
   - Import robjobbed/Solomine
   - Set root directory: `web`
   - Click Deploy

3. **Share your live site:**
   - Twitter: "Just launched Solomine web! 🚀"
   - LinkedIn: Share your live URL
   - Product Hunt: Submit your product

**Total time: 2 minutes** ⏱️

---

*Your web version is ready to deploy!* 🚀
