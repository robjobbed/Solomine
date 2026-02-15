'use client'

import MainLayout from '@/components/layout/MainLayout'
import { MessageSquare } from 'lucide-react'

const mockConversations = [
  {
    id: 1,
    name: 'Sarah Chen',
    handle: '@sarahcodes',
    lastMessage: 'Sounds good! I can start next week.',
    time: '2m ago',
    unread: 2
  },
  {
    id: 2,
    name: 'TechCorp',
    handle: '@techcorp',
    lastMessage: 'Thanks for the proposal. Let me review and get back to you.',
    time: '1h ago',
    unread: 0
  },
  {
    id: 3,
    name: 'Marcus Johnson',
    handle: '@marcusdev',
    lastMessage: 'Hey! Would love to collaborate on this project.',
    time: '3h ago',
    unread: 1
  },
]

export default function MessagesPage() {
  return (
    <MainLayout>
      <div className="p-md space-y-md">
        <div>
          <h1 className="text-2xl font-bold text-accent tracking-wider mb-xs">
            MESSAGES
          </h1>
          <p className="text-sm text-text-secondary">
            &gt; {mockConversations.length} conversation(s)
          </p>
        </div>

        <div className="space-y-md">
          {mockConversations.map((conv) => (
            <div key={conv.id} className="terminal-card hover:border-accent transition-colors cursor-pointer">
              <div className="flex items-start justify-between mb-sm">
                <div className="flex items-start gap-sm">
                  <div className="w-10 h-10 bg-accent/20 border border-accent rounded flex items-center justify-center">
                    <span className="text-accent font-bold">
                      {conv.name.charAt(0)}
                    </span>
                  </div>
                  <div className="flex-1">
                    <div className="flex items-center gap-xs mb-xs">
                      <h3 className="font-semibold text-text-primary">
                        {conv.name}
                      </h3>
                      {conv.unread > 0 && (
                        <span className="px-xs py-0.5 bg-accent text-background text-xs rounded">
                          {conv.unread}
                        </span>
                      )}
                    </div>
                    <p className="text-xs text-accent">{conv.handle}</p>
                  </div>
                </div>
                <span className="text-xs text-text-secondary">{conv.time}</span>
              </div>
              
              <p className="text-sm text-text-secondary line-clamp-2">
                {conv.lastMessage}
              </p>
            </div>
          ))}
        </div>

        {mockConversations.length === 0 && (
          <div className="terminal-card text-center py-xl">
            <MessageSquare className="w-12 h-12 mx-auto mb-md text-text-secondary" />
            <p className="text-text-secondary">
              &gt; no messages yet. start a conversation<span className="blinking-cursor">_</span>
            </p>
          </div>
        )}
      </div>
    </MainLayout>
  )
}
