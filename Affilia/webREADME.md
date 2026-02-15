# Solomine Web

Web version of Solomine - Marketplace for Solo Developers

## 🚀 Quick Start

```bash
# Install dependencies
npm install

# Run development server
npm run dev
```

Open [http://localhost:3000](http://localhost:3000)

## 📦 Built With

- **Next.js 14** - React framework with App Router
- **TypeScript** - Type safety
- **Tailwind CSS** - Styling
- **Lucide React** - Icons
- **Framer Motion** - Animations

## 🎨 Features

- ✅ Terminal aesthetic matching iOS app
- ✅ Dark/Light/Auto theme toggle
- ✅ Responsive design
- ✅ OAuth authentication ready
- ✅ All main pages (Explore, Gigs, Messages, Dashboard, Profile)
- ✅ Navigation drawer
- ✅ Mock data for development

## 🚀 Deploy to Vercel

### One-Click Deploy

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/YOUR_USERNAME/solomine-web)

### Manual Deployment

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

## 📁 Project Structure

```
web/
├── app/                    # Next.js App Router pages
│   ├── page.tsx           # Login page
│   ├── explore/           # Browse builders
│   ├── gigs/              # Browse gigs
│   ├── messages/          # Direct messages
│   ├── dashboard/         # Dashboard
│   └── profile/           # User profile
├── components/
│   ├── layout/            # Layout components
│   └── providers/         # Context providers
├── public/                # Static assets
└── ...config files
```

## 🎨 Design System

**Colors:**
- Background: `#0D0D0D` (Dark) / `#FFFFFF` (Light)
- Accent: `#9BAA7F` (Terminal Green)
- Surface: `#1A1A1A` (Dark) / `#F5F5F5` (Light)

**Typography:**
- Monospace: Menlo, Monaco, Courier New

**Components:**
- Terminal cards with borders
- Terminal buttons (outlined)
- Blinking cursor animation
- Uppercase labels

## 🛠 Development

```bash
# Start dev server
npm run dev

# Build for production
npm run build

# Start production server
npm start

# Lint code
npm run lint
```

## 🌐 Environment Variables

Create `.env.local` for local development:

```
NEXT_PUBLIC_API_URL=http://localhost:3000
NEXTAUTH_SECRET=your-secret-here
NEXTAUTH_URL=http://localhost:3000
```

## 📄 License

MIT

## 🔗 Links

- [iOS App Repository](https://github.com/YOUR_USERNAME/solomine)
- [Documentation](../WEB_VERSION_GUIDE.md)
- [Vercel Dashboard](https://vercel.com/dashboard)

---

Built with ❤️ for solo devs
