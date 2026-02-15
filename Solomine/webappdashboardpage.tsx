'use client'

import MainLayout from '@/components/layout/MainLayout'
import { Briefcase, Clock, DollarSign, TrendingUp } from 'lucide-react'

export default function DashboardPage() {
  const stats = [
    { label: 'Active Gigs', value: '3', icon: Briefcase },
    { label: 'Pending', value: '2', icon: Clock },
    { label: 'Earnings', value: '$12.5k', icon: DollarSign },
    { label: 'This Month', value: '$3.2k', icon: TrendingUp },
  ]

  const requests = [
    {
      id: 1,
      client: 'TechCorp Inc',
      project: 'Custom iOS Dashboard',
      budget: '$4,500',
      status: 'new'
    },
    {
      id: 2,
      client: 'StartupCo',
      project: 'React Web App',
      budget: '$3,000',
      status: 'new'
    },
  ]

  return (
    <MainLayout>
      <div className="p-md space-y-md">
        <div>
          <h1 className="text-2xl font-bold text-accent tracking-wider">
            DASHBOARD
          </h1>
        </div>

        <div>
          <h2 className="text-sm font-semibold text-accent mb-sm tracking-wider">
            OVERVIEW
          </h2>
          <div className="grid grid-cols-2 gap-md">
            {stats.map((stat) => {
              const Icon = stat.icon
              return (
                <div key={stat.label} className="terminal-card">
                  <div className="flex items-center gap-xs mb-xs">
                    <Icon className="w-4 h-4 text-accent" />
                    <p className="text-xs text-text-secondary uppercase">
                      {stat.label}
                    </p>
                  </div>
                  <p className="text-2xl font-bold text-text-primary">
                    {stat.value}
                  </p>
                </div>
              )
            })}
          </div>
        </div>

        <div>
          <div className="flex items-center justify-between mb-sm">
            <h2 className="text-sm font-semibold text-accent tracking-wider">
              INCOMING REQUESTS
            </h2>
            <span className="text-xs text-accent">
              {requests.length} new request(s)
            </span>
          </div>
          <div className="space-y-sm">
            {requests.map((req) => (
              <div key={req.id} className="terminal-card">
                <div className="flex items-start justify-between mb-sm">
                  <div>
                    <h3 className="font-semibold text-text-primary mb-xs">
                      {req.client}
                    </h3>
                    <p className="text-sm text-text-secondary">
                      {req.project}
                    </p>
                  </div>
                  <span className="px-sm py-xs bg-accent/20 border border-accent text-accent text-xs rounded">
                    NEW
                  </span>
                </div>
                <div className="flex items-center justify-between pt-sm border-t border-border">
                  <p className="text-accent font-semibold">{req.budget}</p>
                  <button className="terminal-button text-xs px-sm py-xs">
                    VIEW
                  </button>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </MainLayout>
  )
}
