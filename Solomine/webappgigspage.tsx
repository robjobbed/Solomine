'use client'

import MainLayout from '@/components/layout/MainLayout'
import { Clock, DollarSign } from 'lucide-react'

const mockGigs = [
  {
    id: 1,
    title: 'Build iOS App for Fitness Tracking',
    category: 'Mobile',
    budget: 5000,
    hours: 40,
    description: 'Looking for an experienced iOS developer to build a fitness tracking app with HealthKit integration.',
    postedBy: '@fitcorp',
    skills: ['Swift', 'SwiftUI', 'HealthKit']
  },
  {
    id: 2,
    title: 'React Dashboard with Real-time Analytics',
    category: 'Web',
    budget: 3500,
    hours: 30,
    description: 'Need a responsive dashboard built in React with charts, graphs, and real-time data updates.',
    postedBy: '@startupco',
    skills: ['React', 'TypeScript', 'D3.js']
  },
  {
    id: 3,
    title: 'AWS Infrastructure Setup & Migration',
    category: 'DevOps',
    budget: 4000,
    hours: 35,
    description: 'Migrate existing infrastructure to AWS with proper CI/CD pipelines and monitoring.',
    postedBy: '@techcompany',
    skills: ['AWS', 'Docker', 'Terraform']
  },
]

export default function GigsPage() {
  return (
    <MainLayout>
      <div className="p-md space-y-md">
        <div>
          <h1 className="text-2xl font-bold text-accent tracking-wider mb-xs">
            AVAILABLE GIGS
          </h1>
          <p className="text-sm text-text-secondary">
            &gt; {mockGigs.length} gig(s) available
          </p>
        </div>

        <div className="flex gap-sm overflow-x-auto pb-sm">
          {['All', 'Web', 'Mobile', 'DevOps', 'Design'].map((cat) => (
            <button
              key={cat}
              className={`px-sm py-xs rounded text-xs font-semibold whitespace-nowrap ${
                cat === 'All'
                  ? 'bg-accent text-background'
                  : 'border border-accent text-accent hover:bg-accent hover:text-background'
              }`}
            >
              {cat.toUpperCase()}
            </button>
          ))}
        </div>

        <div className="space-y-md">
          {mockGigs.map((gig) => (
            <div key={gig.id} className="terminal-card space-y-sm">
              <div>
                <h3 className="font-semibold text-text-primary mb-xs">
                  {gig.title}
                </h3>
                <p className="text-xs text-text-secondary">
                  by <span className="text-accent">{gig.postedBy}</span>
                </p>
              </div>

              <p className="text-sm text-text-secondary">
                {gig.description}
              </p>

              <div className="flex flex-wrap gap-xs">
                {gig.skills.map((skill) => (
                  <span
                    key={skill}
                    className="px-sm py-xs bg-surface border border-accent text-accent text-xs rounded"
                  >
                    {skill}
                  </span>
                ))}
              </div>

              <div className="flex items-center justify-between pt-sm border-t border-border">
                <div className="flex items-center gap-md text-sm text-text-secondary">
                  <div className="flex items-center gap-xs">
                    <Clock className="w-4 h-4" />
                    {gig.hours}h
                  </div>
                </div>
                <div className="text-accent font-semibold text-lg">
                  ${gig.budget.toLocaleString()}
                </div>
              </div>

              <button className="w-full terminal-button text-xs py-sm">
                VIEW DETAILS
              </button>
            </div>
          ))}
        </div>
      </div>
    </MainLayout>
  )
}
