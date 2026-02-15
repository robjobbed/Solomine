'use client'

import MainLayout from '@/components/layout/MainLayout'
import { Mail, Twitter, Github, Edit } from 'lucide-react'

export default function ProfilePage() {
  return (
    <MainLayout>
      <div className="p-md space-y-md">
        <div className="flex items-center justify-between">
          <h1 className="text-2xl font-bold text-accent tracking-wider">
            PROFILE
          </h1>
          <button className="terminal-button text-xs px-sm py-xs flex items-center gap-xs">
            <Edit className="w-3 h-3" />
            EDIT
          </button>
        </div>

        <div className="terminal-card space-y-md">
          <div className="flex items-start gap-md">
            <div className="w-16 h-16 bg-accent/20 border-2 border-accent rounded flex items-center justify-center">
              <span className="text-accent text-2xl font-bold">R</span>
            </div>
            <div className="flex-1">
              <h2 className="text-xl font-bold text-text-primary mb-xs">
                Rob Behbahani
              </h2>
              <p className="text-accent text-sm mb-xs">@robcodes</p>
              <span className="inline-block px-sm py-xs border border-accent text-accent text-xs rounded">
                BUILDER
              </span>
            </div>
          </div>

          <p className="text-sm text-text-secondary">
            Full-stack indie dev. SwiftUI wizard. Building Solomine.
          </p>
        </div>

        <div>
          <h2 className="text-sm font-semibold text-accent mb-sm tracking-wider">
            CONNECTED ACCOUNTS
          </h2>
          <div className="space-y-sm">
            <div className="terminal-card flex items-center justify-between">
              <div className="flex items-center gap-sm">
                <Mail className="w-4 h-4 text-accent" />
                <div>
                  <p className="text-xs text-text-secondary">EMAIL</p>
                  <p className="text-sm text-text-primary">rob@solomine.io</p>
                </div>
              </div>
            </div>
            <div className="terminal-card flex items-center justify-between">
              <div className="flex items-center gap-sm">
                <Twitter className="w-4 h-4 text-accent" />
                <div>
                  <p className="text-xs text-text-secondary">X ACCOUNT</p>
                  <p className="text-sm text-text-primary">@robcodes</p>
                </div>
              </div>
              <span className="px-sm py-xs bg-green-500/20 text-green-500 text-xs rounded">
                CONNECTED
              </span>
            </div>
            <div className="terminal-card flex items-center justify-between">
              <div className="flex items-center gap-sm">
                <Github className="w-4 h-4 text-accent" />
                <div>
                  <p className="text-xs text-text-secondary">GITHUB</p>
                  <p className="text-sm text-text-primary">@robcodes</p>
                </div>
              </div>
              <span className="px-sm py-xs bg-green-500/20 text-green-500 text-xs rounded">
                CONNECTED
              </span>
            </div>
          </div>
        </div>

        <div>
          <h2 className="text-sm font-semibold text-accent mb-sm tracking-wider">
            YOUR STATS
          </h2>
          <div className="grid grid-cols-2 gap-sm">
            <div className="terminal-card">
              <p className="text-xs text-text-secondary mb-xs">PROJECTS</p>
              <p className="text-2xl font-bold text-text-primary">12</p>
            </div>
            <div className="terminal-card">
              <p className="text-xs text-text-secondary mb-xs">RATING</p>
              <p className="text-2xl font-bold text-text-primary">4.9</p>
            </div>
            <div className="terminal-card">
              <p className="text-xs text-text-secondary mb-xs">EARNED</p>
              <p className="text-2xl font-bold text-text-primary">$45k</p>
            </div>
            <div className="terminal-card">
              <p className="text-xs text-text-secondary mb-xs">SKILLS</p>
              <p className="text-2xl font-bold text-text-primary">8</p>
            </div>
          </div>
        </div>
      </div>
    </MainLayout>
  )
}
