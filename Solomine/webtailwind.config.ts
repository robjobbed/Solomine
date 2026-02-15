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
