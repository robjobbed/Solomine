import type { Metadata } from 'next'
import './globals.css'
import { ThemeProvider } from '@/components/providers/ThemeProvider'

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
      <body className="font-mono">
        <ThemeProvider>
          {children}
        </ThemeProvider>
      </body>
    </html>
  )
}
