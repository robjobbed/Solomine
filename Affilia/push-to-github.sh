#!/bin/bash

# Push Solomine Web to GitHub
# Repository: https://github.com/robjobbed/Solomine

echo "📦 Pushing Solomine Web to GitHub..."
echo ""

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "⚠️  Not in a git repository. Initializing..."
    git init
    git remote add origin https://github.com/robjobbed/Solomine.git
fi

# Add all web files
echo "📁 Adding web files..."
git add web/

# Add documentation
echo "📄 Adding documentation..."
git add WEB_VERSION_GUIDE.md
git add WEB_QUICK_START.md
git add WEB_DEPLOY_COMPLETE.md
git add DEPLOY_TO_VERCEL.md
git add setup-web.sh
git add deploy-web.sh

# Check what will be committed
echo ""
echo "📋 Files to be committed:"
git status --short

echo ""
read -p "Continue with commit? (y/n) " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Commit
    echo ""
    echo "💾 Committing changes..."
    git commit -m "🌐 Add complete web version

- Add Next.js 14 web application
- Add all 6 pages (Login, Explore, Gigs, Messages, Dashboard, Profile)
- Add navigation drawer with theme toggle
- Add responsive design matching iOS app
- Add complete documentation
- Ready for Vercel deployment"

    # Push
    echo ""
    echo "⬆️  Pushing to GitHub..."
    git push origin main

    if [ $? -eq 0 ]; then
        echo ""
        echo "✅ Successfully pushed to GitHub!"
        echo ""
        echo "🔗 View your files:"
        echo "   https://github.com/robjobbed/Solomine/tree/main/web"
        echo ""
        echo "🚀 Ready to deploy on Vercel:"
        echo "   https://vercel.com/new"
        echo ""
    else
        echo ""
        echo "❌ Push failed. You may need to pull first:"
        echo "   git pull origin main --rebase"
        echo "   git push origin main"
    fi
else
    echo "❌ Cancelled. No changes pushed."
fi
