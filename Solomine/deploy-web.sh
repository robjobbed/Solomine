#!/bin/bash

# Solomine Web - Quick Deploy Script
# For repository: https://github.com/robjobbed/Solomine

echo "🚀 Deploying Solomine Web to Vercel..."
echo ""

# Check if we're in the right directory
if [ ! -d "web" ]; then
    echo "❌ Error: 'web' folder not found!"
    echo "Please run this script from the Solomine project root."
    exit 1
fi

# Step 1: Add web files to git
echo "📦 Step 1: Adding web files to git..."
git add web/
git add DEPLOY_TO_VERCEL.md
git add WEB_VERSION_GUIDE.md
git add WEB_QUICK_START.md

# Step 2: Commit
echo ""
echo "💾 Step 2: Committing changes..."
git commit -m "🌐 Add web version - ready for Vercel deployment"

# Step 3: Push to GitHub
echo ""
echo "⬆️  Step 3: Pushing to GitHub..."
git push origin main

# Step 4: Check if Vercel CLI is installed
echo ""
echo "🔍 Step 4: Checking for Vercel CLI..."
if ! command -v vercel &> /dev/null; then
    echo "⚠️  Vercel CLI not found. Installing..."
    npm install -g vercel
else
    echo "✅ Vercel CLI found!"
fi

# Step 5: Navigate to web folder
echo ""
echo "📁 Step 5: Navigating to web folder..."
cd web

# Step 6: Install dependencies
echo ""
echo "📦 Step 6: Installing dependencies..."
npm install

# Step 7: Test build
echo ""
echo "🔨 Step 7: Testing build..."
npm run build

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
else
    echo "❌ Build failed. Please fix errors and try again."
    exit 1
fi

# Step 8: Deploy to Vercel
echo ""
echo "🚀 Step 8: Deploying to Vercel..."
echo ""
echo "IMPORTANT: When prompted, use these settings:"
echo "  - Project name: solomine-web"
echo "  - Directory: ./"
echo "  - Override settings: No"
echo ""
read -p "Press Enter to continue with deployment..."

vercel --prod

# Done!
echo ""
echo "✅ Deployment complete!"
echo ""
echo "📋 Next steps:"
echo "  1. Check your deployment at the URL shown above"
echo "  2. Test all pages"
echo "  3. Configure custom domain (optional)"
echo ""
echo "🔗 Vercel Dashboard: https://vercel.com/dashboard"
echo "🔗 GitHub Repo: https://github.com/robjobbed/Solomine"
echo ""
echo "🎉 Your web app is live!"
