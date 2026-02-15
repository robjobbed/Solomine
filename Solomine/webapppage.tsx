'use client'

import { useState } from 'react'
import { Twitter, Github } from 'lucide-react'
import { useRouter } from 'next/navigation'

export default function LoginPage() {
  const [isLoading, setIsLoading] = useState(false)
  const router = useRouter()

  const handleTwitterLogin = () => {
    setIsLoading(true)
    // Mock login - go to explore
    setTimeout(() => {
      router.push('/explore')
    }, 1500)
  }

  const handleGithubLogin = () => {
    setIsLoading(true)
    setTimeout(() => {
      router.push('/explore')
    }, 1500)
  }

  return (
    <div className="min-h-screen flex items-center justify-center bg-background">
      <div className="max-w-md w-full px-md">
        <div className="text-center mb-xl">
          <h1 className="text-4xl font-bold text-accent tracking-wider mb-md">
            SOLOMINE
          </h1>
          <p className="text-text-secondary text-sm">
            &gt; marketplace for solo devs
          </p>
        </div>

        {!isLoading ? (
          <div className="space-y-md">
            <button
              onClick={handleTwitterLogin}
              className="w-full bg-accent text-background py-md px-md rounded 
                       font-semibold hover:opacity-90 transition-opacity flex items-center 
                       justify-center gap-sm"
            >
              <Twitter className="w-5 h-5" />
              SIGN IN WITH X
            </button>

            <div className="flex items-center gap-sm">
              <div className="flex-1 h-px bg-border" />
              <span className="text-text-secondary text-xs">OR</span>
              <div className="flex-1 h-px bg-border" />
            </div>

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
