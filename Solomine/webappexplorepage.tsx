'use client'

import MainLayout from '@/components/layout/MainLayout'
import { Search, Star, Bookmark } from 'lucide-react'
import { useState } from 'react'

const mockFreelancers = [
  {
    id: 1,
    name: 'Sarah Chen',
    handle: '@sarahcodes',
    bio: 'Full-stack developer specializing in React and Node.js. 5+ years building scalable web apps.',
    skills: ['React', 'Node.js', 'TypeScript', 'PostgreSQL', 'AWS'],
    rate: 125,
    rating: 4.9,
    projects: 47,
    verified: true,
    followers: 2300
  },
  {
    id: 2,
    name: 'Marcus Johnson',
    handle: '@marcusdev',
    bio: 'iOS engineer with passion for SwiftUI and clean architecture. Ex-Apple engineer.',
    skills: ['Swift', 'SwiftUI', 'UIKit', 'CoreData', 'Combine'],
    rate: 150,
    rating: 5.0,
    projects: 32,
    verified: true,
    followers: 4200
  },
  {
    id: 3,
    name: 'Elena Rodriguez',
    handle: '@elenabuilds',
    bio: 'DevOps specialist & cloud architect. Making infrastructure simple and reliable.',
    skills: ['AWS', 'Docker', 'Kubernetes', 'Terraform', 'CI/CD'],
    rate: 140,
    rating: 4.8,
    projects: 61,
    verified: false,
    followers: 1800
  },
]

export default function ExplorePage() {
  const [searchText, setSearchText] = useState('')
  const [bookmarked, setBookmarked] = useState<number[]>([])

  const filteredFreelancers = mockFreelancers.filter(f =>
    f.name.toLowerCase().includes(searchText.toLowerCase()) ||
    f.handle.toLowerCase().includes(searchText.toLowerCase()) ||
    f.skills.some(s => s.toLowerCase().includes(searchText.toLowerCase()))
  )

  const toggleBookmark = (id: number) => {
    setBookmarked(prev =>
      prev.includes(id) ? prev.filter(x => x !== id) : [...prev, id]
    )
  }

  return (
    <MainLayout>
      <div className="p-md space-y-md">
        <div>
          <h1 className="text-2xl font-bold text-accent tracking-wider mb-xs">
            BUILDER MARKETPLACE
          </h1>
          <div className="flex items-center gap-xs">
            <div className="w-1.5 h-1.5 bg-green-500 rounded-full animate-pulse" />
            <p className="text-xs text-text-secondary">
              LIVE - Verified builders ready to work
            </p>
          </div>
        </div>

        <div className="relative">
          <Search className="absolute left-sm top-1/2 transform -translate-y-1/2 w-4 h-4 text-accent" />
          <input
            type="text"
            value={searchText}
            onChange={(e) => setSearchText(e.target.value)}
            placeholder="> search by skill, name, handle_"
            className="w-full terminal-input pl-10"
          />
        </div>

        <p className="text-sm text-text-secondary">
          &gt; {filteredFreelancers.length} builder(s) found
          {filteredFreelancers.length > 0 && <span className="text-accent ml-2">• Hire the best!</span>}
        </p>

        <div className="space-y-md">
          {filteredFreelancers.map((freelancer) => (
            <div key={freelancer.id} className="terminal-card space-y-sm">
              <div className="flex items-start justify-between">
                <div className="flex items-start gap-sm">
                  <div className="w-10 h-10 bg-accent/20 border border-accent rounded flex items-center justify-center">
                    <span className="text-accent font-bold">
                      {freelancer.name.charAt(0)}
                    </span>
                  </div>
                  <div>
                    <div className="flex items-center gap-xs">
                      <h3 className="font-semibold text-text-primary">
                        {freelancer.name}
                      </h3>
                      {freelancer.verified && (
                        <svg className="w-4 h-4 text-accent" fill="currentColor" viewBox="0 0 20 20">
                          <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd" />
                        </svg>
                      )}
                    </div>
                    <div className="flex items-center gap-xs text-xs">
                      <span className="text-accent">{freelancer.handle}</span>
                      {freelancer.followers > 0 && (
                        <>
                          <span className="text-text-secondary">•</span>
                          <span className="text-text-secondary">{(freelancer.followers / 1000).toFixed(1)}K followers</span>
                        </>
                      )}
                    </div>
                  </div>
                </div>
                <div className="px-sm py-1 bg-green-500/20 border border-green-500 rounded text-xs text-green-500">
                  AVAILABLE
                </div>
              </div>

              <p className="text-sm text-text-secondary line-clamp-2">
                {freelancer.bio}
              </p>

              <div className="flex flex-wrap gap-xs">
                {freelancer.skills.map((skill) => (
                  <span
                    key={skill}
                    className="px-sm py-xs bg-surface border border-accent text-accent text-xs rounded"
                  >
                    {skill}
                  </span>
                ))}
              </div>

              <div className="flex items-center justify-between pt-sm border-t border-border">
                <div className="flex items-center gap-md text-xs text-text-secondary">
                  <div className="flex items-center gap-xs">
                    <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
                    </svg>
                    {freelancer.projects}
                  </div>
                  <div className="flex items-center gap-xs">
                    <Star className="w-4 h-4" />
                    {freelancer.rating}
                  </div>
                </div>
                <div className="text-accent font-semibold">
                  ${freelancer.rate}/hr
                </div>
              </div>

              <div className="flex gap-sm pt-sm">
                <button className="flex-1 terminal-button text-xs py-xs">
                  VIEW PROFILE
                </button>
                <button
                  onClick={() => toggleBookmark(freelancer.id)}
                  className={`px-sm py-xs rounded border transition-colors ${
                    bookmarked.includes(freelancer.id)
                      ? 'bg-accent text-background border-accent'
                      : 'border-accent text-accent hover:bg-accent hover:text-background'
                  }`}
                >
                  <Bookmark className="w-4 h-4" fill={bookmarked.includes(freelancer.id) ? 'currentColor' : 'none'} />
                </button>
              </div>
            </div>
          ))}
        </div>
      </div>
    </MainLayout>
  )
}
