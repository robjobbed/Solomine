#!/bin/bash

# Solomine Web Version - Quick Setup Script
# This script creates a Next.js web version matching your iOS app

echo "🚀 Setting up Solomine Web Version..."
echo ""

# Step 1: Create Next.js app
echo "📦 Step 1: Creating Next.js project..."
npx create-next-app@latest solomine-web \
  --typescript \
  --tailwind \
  --app \
  --no-src-dir \
  --import-alias "@/*"

cd solomine-web

# Step 2: Install dependencies
echo ""
echo "📦 Step 2: Installing dependencies..."
npm install framer-motion lucide-react next-auth

# Step 3: Create directory structure
echo ""
echo "📁 Step 3: Creating directory structure..."
mkdir -p components/ui
mkdir -p components/layout
mkdir -p components/features
mkdir -p components/providers
mkdir -p lib
mkdir -p public/assets
mkdir -p app/explore
mkdir -p app/gigs
mkdir -p app/messages
mkdir -p app/dashboard
mkdir -p app/profile
mkdir -p app/api/auth/[...nextauth]

# Step 4: Create Tailwind config
echo ""
echo "🎨 Step 4: Configuring Tailwind CSS..."
cat > tailwind.config.ts << 'EOF'
import type { Config } from 'tailwindcss'

const config: Config = {
  content: [
    './pages/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
    './app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        background: '#0D0D0D',
        'background-elevated': '#141414',
        surface: '#1A1A1A',
        border: '#2A2A2A',
        'text-primary': '#E8E6E3',
        'text-secondary': '#8A8A7A',
        accent: '#9BAA7F',
        'accent-secondary': '#C9A961',
        'light-background': '#FFFFFF',
        'light-surface': '#F5F5F5',
        'light-border': '#E0E0E0',
        'light-text-primary': '#1A1A1A',
        'light-text-secondary': '#666666',
      },
      fontFamily: {
        mono: ['Menlo', 'Monaco', 'Courier New', 'monospace'],
      },
      spacing: {
        xs: '4px',
        sm: '8px',
        md: '16px',
        lg: '24px',
        xl: '32px',
        xxl: '48px',
      }
    },
  },
  plugins: [],
  darkMode: 'class',
}
export default config
EOF

# Step 5: Create global CSS
echo ""
echo "🎨 Step 5: Creating global styles..."
cat > app/globals.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  body {
    @apply bg-background text-text-primary font-mono;
  }
  
  .light body {
    @apply bg-light-background text-light-text-primary;
  }
}

@layer components {
  .terminal-card {
    @apply bg-surface border border-border rounded p-md;
  }
  
  .light .terminal-card {
    @apply bg-light-surface border-light-border;
  }
  
  .terminal-button {
    @apply bg-transparent border border-accent text-accent px-md py-sm rounded 
           hover:bg-accent hover:text-background transition-all duration-200 font-semibold;
  }
  
  .terminal-input {
    @apply bg-surface border border-border text-text-primary px-sm py-sm rounded
           focus:outline-none focus:border-accent placeholder:text-text-secondary;
  }
  
  .light .terminal-input {
    @apply bg-light-surface border-light-border text-light-text-primary;
  }
  
  @keyframes blink {
    0%, 50% { opacity: 1; }
    51%, 100% { opacity: 0; }
  }
  
  .blinking-cursor {
    animation: blink 1s infinite;
  }
}
EOF

# Step 6: Create environment template
echo ""
echo "⚙️  Step 6: Creating environment template..."
cat > .env.local.example << 'EOF'
# API Configuration
NEXT_PUBLIC_API_URL=http://localhost:3000

# Twitter OAuth
TWITTER_CLIENT_ID=your_twitter_client_id
TWITTER_CLIENT_SECRET=your_twitter_client_secret

# GitHub OAuth
GITHUB_CLIENT_ID=your_github_client_id
GITHUB_CLIENT_SECRET=your_github_client_secret

# NextAuth
NEXTAUTH_SECRET=your_nextauth_secret_here
NEXTAUTH_URL=http://localhost:3000
EOF

# Step 7: Create package.json scripts
echo ""
echo "📜 Step 7: Updating package.json scripts..."
npm pkg set scripts.dev="next dev"
npm pkg set scripts.build="next build"
npm pkg set scripts.start="next start"
npm pkg set scripts.lint="next lint"
npm pkg set scripts.deploy="vercel --prod"

# Step 8: Create README
echo ""
echo "📝 Step 8: Creating README..."
cat > README.md << 'EOF'
# 🌐 Solomine Web

Web version of Solomine - Marketplace for Solo Developers

## 🚀 Quick Start

```bash
# Install dependencies
npm install

# Set up environment variables
cp .env.local.example .env.local
# Edit .env.local with your credentials

# Run development server
npm run dev
```

Open [http://localhost:3000](http://localhost:3000)

## 📦 Tech Stack

- **Framework:** Next.js 14 (App Router)
- **Language:** TypeScript
- **Styling:** Tailwind CSS
- **Authentication:** NextAuth.js
- **Icons:** Lucide React
- **Animations:** Framer Motion

## 🚀 Deployment

### Vercel (Recommended)

```bash
# Install Vercel CLI
npm i -g vercel

# Deploy
vercel

# Production deployment
vercel --prod
```

### Manual Deployment

1. Build the project:
   ```bash
   npm run build
   ```

2. Deploy the `.next` folder to your hosting provider

## 🔐 Environment Variables

Required environment variables:
- `NEXT_PUBLIC_API_URL` - Your backend API URL
- `TWITTER_CLIENT_ID` - Twitter OAuth client ID
- `TWITTER_CLIENT_SECRET` - Twitter OAuth client secret
- `GITHUB_CLIENT_ID` - GitHub OAuth client ID
- `GITHUB_CLIENT_SECRET` - GitHub OAuth client secret
- `NEXTAUTH_SECRET` - NextAuth secret key
- `NEXTAUTH_URL` - Your app URL

## 📚 Documentation

See [WEB_VERSION_GUIDE.md](../WEB_VERSION_GUIDE.md) for complete documentation.

## 🎨 Design

Matches the iOS app's terminal aesthetic:
- Monospace fonts
- Terminal green accent (#9BAA7F)
- Dark/light mode support
- Minimalist design

## 📄 License

MIT
EOF

# Step 9: Create vercel.json
echo ""
echo "⚙️  Step 9: Creating Vercel configuration..."
cat > vercel.json << 'EOF'
{
  "buildCommand": "next build",
  "devCommand": "next dev",
  "installCommand": "npm install",
  "framework": "nextjs",
  "regions": ["iad1"],
  "env": {
    "NEXT_PUBLIC_API_URL": "@solomine-api-url"
  }
}
EOF

# Step 10: Initialize git
echo ""
echo "📦 Step 10: Initializing git repository..."
git init
cat > .gitignore << 'EOF'
# dependencies
/node_modules
/.pnp
.pnp.js

# testing
/coverage

# next.js
/.next/
/out/

# production
/build

# misc
.DS_Store
*.pem

# debug
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# local env files
.env*.local

# vercel
.vercel

# typescript
*.tsbuildinfo
next-env.d.ts
EOF

echo ""
echo "✅ Setup complete!"
echo ""
echo "📋 Next steps:"
echo "  1. cd solomine-web"
echo "  2. cp .env.local.example .env.local"
echo "  3. Edit .env.local with your credentials"
echo "  4. npm run dev"
echo ""
echo "🚀 Deploy to Vercel:"
echo "  1. Push to GitHub"
echo "  2. Import to Vercel"
echo "  3. Deploy!"
echo ""
echo "🎉 Your web version is ready!"
