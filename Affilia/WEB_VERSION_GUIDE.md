# 🌐 Solomine Web Version - Deployment Guide

## Overview

This guide will help you create a web version of Solomine that can be deployed on Vercel. We'll use **Next.js** with **TypeScript** and **Tailwind CSS** to recreate the terminal aesthetic.

---

## 🚀 Quick Start

### 1. Create Next.js Project

```bash
# Create new Next.js app
npx create-next-app@latest solomine-web --typescript --tailwind --app --no-src-dir

# Navigate to project
cd solomine-web

# Install additional dependencies
npm install framer-motion lucide-react @radix-ui/react-dialog @radix-ui/react-dropdown-menu
```

### 2. Project Structure

```
solomine-web/
├── app/
│   ├── layout.tsx              # Root layout
│   ├── page.tsx                # Home/Login page
│   ├── explore/
│   │   └── page.tsx            # Explore builders
│   ├── gigs/
│   │   └── page.tsx            # Browse gigs
│   ├── messages/
│   │   └── page.tsx            # Messages
│   ├── dashboard/
│   │   └── page.tsx            # Dashboard
│   └── profile/
│       └── page.tsx            # Profile
├── components/
│   ├── ui/                     # Reusable UI components
│   ├── layout/                 # Layout components
│   └── features/               # Feature-specific components
├── lib/
│   ├── theme.ts                # Theme configuration
│   └── utils.ts                # Utility functions
├── public/
│   └── assets/                 # Images, icons
├── styles/
│   └── globals.css             # Global styles
├── tailwind.config.ts          # Tailwind configuration
├── next.config.js              # Next.js configuration
└── package.json
```

---

## 📋 Step-by-Step Setup

### Step 1: Configure Tailwind Theme

Create `tailwind.config.ts`:

```typescript
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
        // Dark theme colors (matching iOS app)
        background: '#0D0D0D',
        'background-elevated': '#141414',
        surface: '#1A1A1A',
        border: '#2A2A2A',
        'text-primary': '#E8E6E3',
        'text-secondary': '#8A8A7A',
        accent: '#9BAA7F',
        'accent-secondary': '#C9A961',
        
        // Light theme colors
        'light-background': '#FFFFFF',
        'light-surface': '#F5F5F5',
        'light-border': '#E0E0E0',
        'light-text-primary': '#1A1A1A',
        'light-text-secondary': '#666666',
      },
      fontFamily: {
        mono: ['Menlo', 'Monaco', 'Courier New', 'monospace'],
      },
      borderRadius: {
        'terminal': '4px',
      },
      spacing: {
        'xs': '4px',
        'sm': '8px',
        'md': '16px',
        'lg': '24px',
        'xl': '32px',
        'xxl': '48px',
      }
    },
  },
  plugins: [],
  darkMode: 'class', // Enable dark mode with class strategy
}
export default config
```

### Step 2: Create Global Styles

Update `app/globals.css`:

```css
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  body {
    @apply bg-background text-text-primary font-mono;
  }
  
  /* Light mode overrides */
  .light body {
    @apply bg-light-background text-light-text-primary;
  }
}

@layer components {
  /* Terminal Card */
  .terminal-card {
    @apply bg-surface border border-border rounded-terminal p-md;
  }
  
  .light .terminal-card {
    @apply bg-light-surface border-light-border;
  }
  
  /* Terminal Button */
  .terminal-button {
    @apply bg-transparent border border-accent text-accent px-md py-sm rounded-terminal 
           hover:bg-accent hover:text-background transition-all duration-200 font-semibold;
  }
  
  /* Terminal Input */
  .terminal-input {
    @apply bg-surface border border-border text-text-primary px-sm py-sm rounded-terminal
           focus:outline-none focus:border-accent placeholder:text-text-secondary;
  }
  
  .light .terminal-input {
    @apply bg-light-surface border-light-border text-light-text-primary;
  }
  
  /* Accent Text */
  .accent-text {
    @apply text-accent;
  }
  
  /* Blinking Cursor */
  @keyframes blink {
    0%, 50% { opacity: 1; }
    51%, 100% { opacity: 0; }
  }
  
  .blinking-cursor {
    animation: blink 1s infinite;
  }
}
```

### Step 3: Create Theme Provider

Create `components/providers/ThemeProvider.tsx`:

```typescript
'use client'

import { createContext, useContext, useEffect, useState } from 'react'

type Theme = 'light' | 'dark' | 'system'

interface ThemeContextType {
  theme: Theme
  setTheme: (theme: Theme) => void
  resolvedTheme: 'light' | 'dark'
}

const ThemeContext = createContext<ThemeContextType | undefined>(undefined)

export function ThemeProvider({ children }: { children: React.ReactNode }) {
  const [theme, setTheme] = useState<Theme>('dark')
  const [resolvedTheme, setResolvedTheme] = useState<'light' | 'dark'>('dark')

  useEffect(() => {
    // Load theme from localStorage
    const savedTheme = localStorage.getItem('theme') as Theme | null
    if (savedTheme) {
      setTheme(savedTheme)
    }
  }, [])

  useEffect(() => {
    // Apply theme
    const root = window.document.documentElement
    root.classList.remove('light', 'dark')

    if (theme === 'system') {
      const systemTheme = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'
      root.classList.add(systemTheme)
      setResolvedTheme(systemTheme)
    } else {
      root.classList.add(theme)
      setResolvedTheme(theme)
    }

    // Save to localStorage
    localStorage.setItem('theme', theme)
  }, [theme])

  return (
    <ThemeContext.Provider value={{ theme, setTheme, resolvedTheme }}>
      {children}
    </ThemeContext.Provider>
  )
}

export const useTheme = () => {
  const context = useContext(ThemeContext)
  if (!context) throw new Error('useTheme must be used within ThemeProvider')
  return context
}
```

### Step 4: Create Root Layout

Update `app/layout.tsx`:

```typescript
import type { Metadata } from 'next'
import { Inter } from 'next/font/google'
import './globals.css'
import { ThemeProvider } from '@/components/providers/ThemeProvider'

const inter = Inter({ subsets: ['latin'] })

export const metadata: Metadata = {
  title: 'Solomine - Marketplace for Solo Devs',
  description: 'Connect talented solo developers with clients',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body className={inter.className}>
        <ThemeProvider>
          {children}
        </ThemeProvider>
      </body>
    </html>
  )
}
```

### Step 5: Create Login Page

Create `app/page.tsx`:

```typescript
'use client'

import { useState } from 'react'
import { Twitter, Github } from 'lucide-react'

export default function LoginPage() {
  const [isLoading, setIsLoading] = useState(false)

  const handleTwitterLogin = () => {
    setIsLoading(true)
    // Implement OAuth flow
    window.location.href = '/api/auth/twitter'
  }

  const handleGithubLogin = () => {
    setIsLoading(true)
    // Implement OAuth flow
    window.location.href = '/api/auth/github'
  }

  return (
    <div className="min-h-screen flex items-center justify-center bg-background">
      <div className="max-w-md w-full px-md">
        <div className="text-center mb-xl">
          {/* Logo */}
          <h1 className="text-4xl font-bold text-accent tracking-wider mb-md">
            SOLOMINE
          </h1>
          <p className="text-text-secondary text-sm">
            &gt; marketplace for solo devs
          </p>
        </div>

        {!isLoading ? (
          <div className="space-y-md">
            {/* Twitter Login */}
            <button
              onClick={handleTwitterLogin}
              className="w-full bg-accent text-background py-md px-md rounded-terminal 
                       font-semibold hover:opacity-90 transition-opacity flex items-center 
                       justify-center gap-sm"
            >
              <Twitter className="w-5 h-5" />
              SIGN IN WITH X
            </button>

            {/* Divider */}
            <div className="flex items-center gap-sm">
              <div className="flex-1 h-px bg-border" />
              <span className="text-text-secondary text-xs">OR</span>
              <div className="flex-1 h-px bg-border" />
            </div>

            {/* GitHub Login */}
            <button
              onClick={handleGithubLogin}
              className="w-full terminal-button py-md flex items-center justify-center gap-sm"
            >
              <Github className="w-5 h-5" />
              SIGN IN WITH GITHUB
            </button>
          </div>
        ) : (
          <div className="terminal-card text-center">
            <div className="animate-pulse">
              <p className="text-text-secondary">
                &gt; authenticating<span className="blinking-cursor">_</span>
              </p>
            </div>
          </div>
        )}

        {/* Footer */}
        <div className="mt-xl text-center text-xs text-text-secondary space-y-1">
          <p>BY SIGNING IN YOU AGREE TO OUR</p>
          <div className="flex justify-center gap-1">
            <a href="/terms" className="text-accent hover:underline">TERMS</a>
            <span>AND</span>
            <a href="/privacy" className="text-accent hover:underline">PRIVACY POLICY</a>
          </div>
        </div>
      </div>
    </div>
  )
}
```

### Step 6: Create Main Layout with Navigation

Create `components/layout/MainLayout.tsx`:

```typescript
'use client'

import { useState } from 'react'
import Link from 'next/link'
import { usePathname } from 'next/navigation'
import { Menu, X, Search, Briefcase, MessageSquare, LayoutDashboard, User, Sun, Moon, Settings } from 'lucide-react'
import { useTheme } from '@/components/providers/ThemeProvider'

export default function MainLayout({ children }: { children: React.ReactNode }) {
  const [isDrawerOpen, setIsDrawerOpen] = useState(false)
  const pathname = usePathname()
  const { theme, setTheme } = useTheme()

  const navItems = [
    { href: '/explore', label: 'Explore', icon: Search },
    { href: '/gigs', label: 'Gigs', icon: Briefcase },
    { href: '/messages', label: 'Messages', icon: MessageSquare },
    { href: '/dashboard', label: 'Dashboard', icon: LayoutDashboard },
    { href: '/profile', label: 'Profile', icon: User },
  ]

  return (
    <div className="min-h-screen bg-background">
      {/* Header */}
      <header className="border-b border-border bg-background sticky top-0 z-40">
        <div className="max-w-7xl mx-auto px-md py-sm flex items-center justify-between">
          {/* Menu Button */}
          <button
            onClick={() => setIsDrawerOpen(!isDrawerOpen)}
            className="p-sm border border-accent rounded hover:bg-surface transition-colors"
          >
            {isDrawerOpen ? (
              <X className="w-5 h-5 text-accent" />
            ) : (
              <Menu className="w-5 h-5 text-accent" />
            )}
          </button>

          {/* Title */}
          <h1 className="text-accent font-bold tracking-wider flex items-center gap-1">
            SOLOMINE<span className="blinking-cursor">_</span>
          </h1>

          {/* User Badge */}
          <div className="border border-accent px-sm py-1 rounded text-xs text-accent">
            @robcodes
          </div>
        </div>
      </header>

      {/* Drawer */}
      {isDrawerOpen && (
        <div className="fixed inset-0 z-50">
          {/* Overlay */}
          <div
            className="absolute inset-0 bg-black/40"
            onClick={() => setIsDrawerOpen(false)}
          />

          {/* Drawer Content */}
          <div className="absolute left-0 top-0 bottom-0 w-80 bg-background border-r border-accent/30">
            {/* Drawer Header */}
            <div className="p-lg bg-surface border-b border-border">
              <h2 className="text-2xl font-bold text-accent tracking-wider mb-sm">
                SOLOMINE
              </h2>
              <div className="flex items-center gap-xs text-sm">
                <span className="text-accent">@robcodes</span>
                <span className="text-text-secondary">• 5.4K followers</span>
              </div>
            </div>

            {/* Navigation */}
            <nav className="p-md space-y-1">
              {navItems.map((item) => {
                const Icon = item.icon
                const isActive = pathname === item.href

                return (
                  <Link
                    key={item.href}
                    href={item.href}
                    onClick={() => setIsDrawerOpen(false)}
                    className={`flex items-center gap-sm px-md py-sm rounded transition-colors ${
                      isActive
                        ? 'bg-accent text-background'
                        : 'text-text-primary hover:bg-surface'
                    }`}
                  >
                    <Icon className="w-5 h-5" />
                    <span className="font-semibold tracking-wide">{item.label.toUpperCase()}</span>
                  </Link>
                )
              })}
            </nav>

            {/* Theme Toggle */}
            <div className="p-md border-t border-border">
              <p className="text-xs text-text-secondary mb-sm tracking-wide">APPEARANCE</p>
              <div className="grid grid-cols-3 gap-sm">
                <button
                  onClick={() => setTheme('light')}
                  className={`py-sm rounded text-xs font-semibold ${
                    theme === 'light'
                      ? 'bg-accent text-background'
                      : 'border border-border text-text-secondary hover:bg-surface'
                  }`}
                >
                  <Sun className="w-4 h-4 mx-auto mb-1" />
                  LIGHT
                </button>
                <button
                  onClick={() => setTheme('dark')}
                  className={`py-sm rounded text-xs font-semibold ${
                    theme === 'dark'
                      ? 'bg-accent text-background'
                      : 'border border-border text-text-secondary hover:bg-surface'
                  }`}
                >
                  <Moon className="w-4 h-4 mx-auto mb-1" />
                  DARK
                </button>
                <button
                  onClick={() => setTheme('system')}
                  className={`py-sm rounded text-xs font-semibold ${
                    theme === 'system'
                      ? 'bg-accent text-background'
                      : 'border border-border text-text-secondary hover:bg-surface'
                  }`}
                >
                  <Settings className="w-4 h-4 mx-auto mb-1" />
                  AUTO
                </button>
              </div>
            </div>

            {/* Logout */}
            <div className="p-md border-t border-border">
              <button className="w-full text-left px-md py-sm text-accent-secondary hover:bg-surface rounded transition-colors">
                LOG OUT
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Main Content */}
      <main className="max-w-7xl mx-auto">
        {children}
      </main>
    </div>
  )
}
```

---

## 📦 Deployment to Vercel

### Option 1: Deploy via Vercel Dashboard

1. **Push to GitHub:**
   ```bash
   git init
   git add .
   git commit -m "Initial web version"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/solomine-web.git
   git push -u origin main
   ```

2. **Import to Vercel:**
   - Go to [vercel.com](https://vercel.com)
   - Click "New Project"
   - Import your GitHub repo
   - Vercel auto-detects Next.js
   - Click "Deploy"

### Option 2: Deploy via Vercel CLI

```bash
# Install Vercel CLI
npm i -g vercel

# Login
vercel login

# Deploy
vercel

# Production deployment
vercel --prod
```

### Environment Variables

Add these in Vercel dashboard (Settings → Environment Variables):

```
NEXT_PUBLIC_API_URL=https://api.solomine.io
TWITTER_CLIENT_ID=your_twitter_client_id
TWITTER_CLIENT_SECRET=your_twitter_client_secret
GITHUB_CLIENT_ID=your_github_client_id
GITHUB_CLIENT_SECRET=your_github_client_secret
NEXTAUTH_SECRET=your_nextauth_secret
```

---

## 🔐 Authentication Setup

### Using NextAuth.js

```bash
npm install next-auth
```

Create `app/api/auth/[...nextauth]/route.ts`:

```typescript
import NextAuth from 'next-auth'
import TwitterProvider from 'next-auth/providers/twitter'
import GitHubProvider from 'next-auth/providers/github'

const handler = NextAuth({
  providers: [
    TwitterProvider({
      clientId: process.env.TWITTER_CLIENT_ID!,
      clientSecret: process.env.TWITTER_CLIENT_SECRET!,
      version: '2.0',
    }),
    GitHubProvider({
      clientId: process.env.GITHUB_CLIENT_ID!,
      clientSecret: process.env.GITHUB_CLIENT_SECRET!,
    }),
  ],
  pages: {
    signIn: '/',
  },
  callbacks: {
    async jwt({ token, account, profile }) {
      if (account) {
        token.accessToken = account.access_token
        token.provider = account.provider
      }
      return token
    },
    async session({ session, token }) {
      session.accessToken = token.accessToken
      session.provider = token.provider
      return session
    },
  },
})

export { handler as GET, handler as POST }
```

---

## 📱 Matching iOS Design

### Terminal Aesthetic Components

I'll continue with more component examples in the next response, but this gives you the foundation!

### Key Design Elements:
- ✅ Monospace font (Menlo/Monaco)
- ✅ Terminal green accent (#9BAA7F)
- ✅ Dark background (#0D0D0D)
- ✅ Blinking cursor animation
- ✅ Terminal-style cards and buttons
- ✅ ">" prefixes for lists
- ✅ Uppercase labels
- ✅ Minimalist borders

---

## 🚀 Next Steps

1. Create this project structure
2. Implement remaining pages (Explore, Gigs, Messages, Dashboard, Profile)
3. Set up API routes for backend communication
4. Deploy to Vercel
5. Configure custom domain

Would you like me to:
1. Create the complete component library?
2. Build specific pages (Explore, Gigs, etc.)?
3. Set up the backend API?
4. Create a complete deployment script?

Let me know what you'd like to tackle next!
