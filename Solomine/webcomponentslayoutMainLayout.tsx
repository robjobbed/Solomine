'use client'

import { useState, ReactNode } from 'react'
import Link from 'next/link'
import { usePathname } from 'next/navigation'
import { Menu, X, Search, Briefcase, MessageSquare, LayoutDashboard, User, Sun, Moon, Settings, LogOut } from 'lucide-react'
import { useTheme } from '@/components/providers/ThemeProvider'

interface MainLayoutProps {
  children: ReactNode
}

export default function MainLayout({ children }: MainLayoutProps) {
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

          <h1 className="text-accent font-bold tracking-wider flex items-center gap-1">
            SOLOMINE<span className="blinking-cursor">_</span>
          </h1>

          <div className="border border-accent px-sm py-1 rounded text-xs text-accent">
            @robcodes
          </div>
        </div>
      </header>

      {/* Drawer */}
      {isDrawerOpen && (
        <div className="fixed inset-0 z-50">
          <div
            className="absolute inset-0 bg-black/40"
            onClick={() => setIsDrawerOpen(false)}
          />

          <div className="absolute left-0 top-0 bottom-0 w-80 bg-background border-r border-accent/30 overflow-y-auto">
            <div className="p-lg bg-surface border-b border-border">
              <h2 className="text-2xl font-bold text-accent tracking-wider mb-sm">
                SOLOMINE
              </h2>
              <div className="flex items-center gap-xs text-sm">
                <span className="text-accent">@robcodes</span>
                <span className="text-text-secondary">• 5.4K followers</span>
              </div>
            </div>

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

            <div className="p-md border-t border-border">
              <p className="text-xs text-text-secondary mb-sm tracking-wide">APPEARANCE</p>
              <div className="grid grid-cols-3 gap-sm">
                <button
                  onClick={() => setTheme('light')}
                  className={`py-sm rounded text-xs font-semibold flex flex-col items-center ${
                    theme === 'light'
                      ? 'bg-accent text-background'
                      : 'border border-border text-text-secondary hover:bg-surface'
                  }`}
                >
                  <Sun className="w-4 h-4 mb-1" />
                  LIGHT
                </button>
                <button
                  onClick={() => setTheme('dark')}
                  className={`py-sm rounded text-xs font-semibold flex flex-col items-center ${
                    theme === 'dark'
                      ? 'bg-accent text-background'
                      : 'border border-border text-text-secondary hover:bg-surface'
                  }`}
                >
                  <Moon className="w-4 h-4 mb-1" />
                  DARK
                </button>
                <button
                  onClick={() => setTheme('system')}
                  className={`py-sm rounded text-xs font-semibold flex flex-col items-center ${
                    theme === 'system'
                      ? 'bg-accent text-background'
                      : 'border border-border text-text-secondary hover:bg-surface'
                  }`}
                >
                  <Settings className="w-4 h-4 mb-1" />
                  AUTO
                </button>
              </div>
            </div>

            <div className="p-md border-t border-border">
              <Link
                href="/"
                className="w-full flex items-center gap-sm px-md py-sm text-accent-secondary hover:bg-surface rounded transition-colors"
              >
                <LogOut className="w-4 h-4" />
                LOG OUT
              </Link>
            </div>
          </div>
        </div>
      )}

      <main className="max-w-7xl mx-auto">
        {children}
      </main>
    </div>
  )
}
