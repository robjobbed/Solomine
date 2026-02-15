# 🌐 Web Version Quick Reference

## TL;DR - Get Your Web App Running in 5 Minutes

### Option 1: Automated Setup (Recommended)

```bash
# Run the setup script
chmod +x setup-web.sh
./setup-web.sh

# Navigate to project
cd solomine-web

# Set up environment
cp .env.local.example .env.local
# Edit .env.local with your OAuth credentials

# Start development server
npm run dev
```

Open [http://localhost:3000](http://localhost:3000)

### Option 2: Manual Setup

```bash
# Create Next.js app
npx create-next-app@latest solomine-web --typescript --tailwind --app

# Install dependencies
cd solomine-web
npm install framer-motion lucide-react next-auth

# Copy configuration files from iOS project
# See WEB_VERSION_GUIDE.md for details

# Start dev server
npm run dev
```

---

## 🚀 Deploy to Vercel (2 Minutes)

### Quick Deploy

1. **Push to GitHub:**
   ```bash
   git init
   git add .
   git commit -m "Solomine web version"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/solomine-web.git
   git push -u origin main
   ```

2. **Deploy on Vercel:**
   - Go to [vercel.com/new](https://vercel.com/new)
   - Click "Import Git Repository"
   - Select your `solomine-web` repo
   - Vercel auto-detects Next.js settings
   - Click "Deploy"
   - Done! 🎉

3. **Add Environment Variables:**
   - Go to Project Settings → Environment Variables
   - Add your OAuth credentials
   - Redeploy

Your site will be live at: `https://solomine-web.vercel.app`

### CLI Deploy

```bash
# Install Vercel CLI
npm i -g vercel

# Login
vercel login

# Deploy
vercel

# Deploy to production
vercel --prod
```

---

## 🎨 What You Get

### Pages
✅ **Login** (`/`) - X & GitHub OAuth  
✅ **Explore** (`/explore`) - Browse builders  
✅ **Gigs** (`/gigs`) - Browse gigs  
✅ **Messages** (`/messages`) - Direct messaging  
✅ **Dashboard** (`/dashboard`) - Stats & analytics  
✅ **Profile** (`/profile`) - User profile  

### Features
✅ **Dark/Light/Auto** theme toggle  
✅ **Responsive design** (mobile, tablet, desktop)  
✅ **Terminal aesthetic** (matches iOS app)  
✅ **OAuth authentication** (X & GitHub)  
✅ **Navigation drawer** (mobile-friendly)  
✅ **Blinking cursor** animation  
✅ **Terminal-style** cards and buttons  

### Tech Stack
- **Next.js 14** - React framework
- **TypeScript** - Type safety
- **Tailwind CSS** - Styling
- **NextAuth.js** - Authentication
- **Lucide React** - Icons
- **Framer Motion** - Animations

---

## 📁 Project Structure

```
solomine-web/
├── app/
│   ├── page.tsx                 # Login page
│   ├── layout.tsx               # Root layout
│   ├── globals.css              # Global styles
│   ├── explore/page.tsx         # Explore builders
│   ├── gigs/page.tsx            # Browse gigs
│   ├── messages/page.tsx        # Messages
│   ├── dashboard/page.tsx       # Dashboard
│   ├── profile/page.tsx         # Profile
│   └── api/
│       └── auth/[...nextauth]/  # Auth routes
├── components/
│   ├── layout/
│   │   └── MainLayout.tsx       # Main layout with nav
│   ├── providers/
│   │   └── ThemeProvider.tsx    # Theme context
│   └── ui/                      # Reusable components
├── lib/
│   └── utils.ts                 # Utility functions
├── public/
│   └── assets/                  # Images, icons
├── .env.local.example           # Environment template
├── tailwind.config.ts           # Tailwind config
├── vercel.json                  # Vercel config
└── package.json
```

---

## 🔐 OAuth Setup

### Twitter (X) OAuth

1. Go to [developer.twitter.com](https://developer.twitter.com/en/portal/dashboard)
2. Create new app
3. Get Client ID and Secret
4. Add callback URL: `https://your-domain.com/api/auth/callback/twitter`
5. Add to `.env.local`:
   ```
   TWITTER_CLIENT_ID=your_id
   TWITTER_CLIENT_SECRET=your_secret
   ```

### GitHub OAuth

1. Go to [github.com/settings/developers](https://github.com/settings/developers)
2. Create new OAuth App
3. Get Client ID and Secret
4. Add callback URL: `https://your-domain.com/api/auth/callback/github`
5. Add to `.env.local`:
   ```
   GITHUB_CLIENT_ID=your_id
   GITHUB_CLIENT_SECRET=your_secret
   ```

---

## 🎨 Design System

### Colors (Matching iOS)

**Dark Mode:**
```css
background: #0D0D0D      /* Deep black */
surface: #1A1A1A         /* Dark grey */
accent: #9BAA7F          /* Terminal green */
text-primary: #E8E6E3    /* Off-white */
text-secondary: #8A8A7A  /* Muted grey */
```

**Light Mode:**
```css
background: #FFFFFF      /* White */
surface: #F5F5F5         /* Light grey */
accent: #9BAA7F          /* Same green */
text-primary: #1A1A1A    /* Dark grey */
text-secondary: #666666  /* Medium grey */
```

### Typography
- **Font:** Menlo, Monaco, Courier New (monospace)
- **Style:** Uppercase labels, lowercase content
- **Accent:** Terminal green (#9BAA7F)

### Components
- **Cards:** `terminal-card` class
- **Buttons:** `terminal-button` class
- **Inputs:** `terminal-input` class
- **Cursor:** `blinking-cursor` animation

---

## 🛠 Development Commands

```bash
# Start dev server
npm run dev

# Build for production
npm run build

# Start production server
npm start

# Run linter
npm run lint

# Deploy to Vercel
npm run deploy
```

---

## 🚀 Deployment Checklist

### Before Deploying

- [ ] Set up OAuth apps (Twitter & GitHub)
- [ ] Configure environment variables
- [ ] Test authentication flow
- [ ] Test all pages
- [ ] Build locally (`npm run build`)
- [ ] Check for errors

### Deploy to Vercel

- [ ] Push to GitHub
- [ ] Import to Vercel
- [ ] Add environment variables in Vercel
- [ ] Deploy
- [ ] Test production site
- [ ] Configure custom domain (optional)

### After Deployment

- [ ] Test OAuth on production
- [ ] Check all pages load
- [ ] Test mobile responsiveness
- [ ] Set up monitoring (optional)
- [ ] Add analytics (optional)

---

## 🔄 Keeping Web & iOS in Sync

### Design Consistency
- ✅ Use same color palette
- ✅ Match typography (monospace)
- ✅ Same component names
- ✅ Identical user flows

### Feature Parity
- ✅ Same authentication
- ✅ Same pages/tabs
- ✅ Same data models
- ✅ Same API endpoints

### Updates
When you update iOS app:
1. Update web colors if changed
2. Add new pages/features
3. Match new UI patterns
4. Keep theme consistent

---

## 📊 Performance

### Optimization
- ✅ Next.js automatic code splitting
- ✅ Image optimization
- ✅ Route pre-fetching
- ✅ Static generation where possible
- ✅ Edge caching on Vercel

### Lighthouse Scores (Target)
- Performance: 95+
- Accessibility: 100
- Best Practices: 100
- SEO: 100

---

## 🐛 Troubleshooting

### Build Errors

**"Module not found"**
```bash
npm install
```

**TypeScript errors**
```bash
npm run build
# Fix errors shown in console
```

### OAuth Not Working

**Callback URL mismatch**
- Check `.env.local` has correct `NEXTAUTH_URL`
- Verify OAuth app callback URLs

**Session not persisting**
- Check `NEXTAUTH_SECRET` is set
- Clear cookies and try again

### Styling Issues

**Tailwind not working**
```bash
# Rebuild Tailwind
npm run build
```

**Dark mode not switching**
- Check ThemeProvider is in layout
- Verify `darkMode: 'class'` in tailwind.config

---

## 📚 Resources

### Documentation
- [Next.js Docs](https://nextjs.org/docs)
- [Tailwind CSS](https://tailwindcss.com/docs)
- [NextAuth.js](https://next-auth.js.org)
- [Vercel Docs](https://vercel.com/docs)

### Your Files
- `WEB_VERSION_GUIDE.md` - Complete setup guide
- `setup-web.sh` - Automated setup script
- `.env.local.example` - Environment template

---

## 🎉 Success!

Your web version is ready when you can:

✅ Run `npm run dev` and see login page  
✅ Sign in with Twitter or GitHub  
✅ Navigate between pages  
✅ Toggle dark/light mode  
✅ Deploy to Vercel successfully  
✅ Access at your Vercel URL  

---

## 🚀 Next Steps

1. **Complete Component Library**
   - Build all page components
   - Create reusable UI components
   - Add animations

2. **Backend Integration**
   - Set up API routes
   - Connect to your backend
   - Implement real data

3. **Advanced Features**
   - Real-time messaging (Socket.io)
   - Payment integration (Stripe)
   - File uploads (S3)
   - Search functionality

4. **Polish**
   - Add loading states
   - Error handling
   - Toast notifications
   - Animations

5. **Production**
   - Set up monitoring
   - Add analytics
   - SEO optimization
   - Performance testing

---

**Ready to build your web version?**

1. Run `./setup-web.sh`
2. Follow the prompts
3. Deploy to Vercel
4. Share your web app! 🎉

---

*Need help? Check WEB_VERSION_GUIDE.md for detailed instructions!*
