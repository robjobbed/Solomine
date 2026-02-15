# Git Command Quick Reference

A handy reference for common Git operations you'll use with the Solomine project.

## 📋 Daily Workflow

### Check Status
```bash
# See what's changed
git status

# See detailed changes in files
git diff

# See log of recent commits
git log --oneline -10
```

### Make Changes
```bash
# Stage all changes
git add .

# Stage specific file
git add path/to/file.swift

# Commit with message
git commit -m "✨ Add new feature"

# Add and commit in one step
git commit -am "🐛 Fix bug"

# Push to GitHub
git push
```

### Pull Latest Changes
```bash
# Get latest from GitHub
git pull

# Or fetch and merge separately
git fetch
git merge origin/main
```

---

## 🌿 Branching

### Create & Switch Branches
```bash
# Create new branch
git branch feature/new-feature

# Switch to branch
git checkout feature/new-feature

# Create and switch in one command
git checkout -b feature/new-feature

# List all branches
git branch -a
```

### Merge Branches
```bash
# Switch to main
git checkout main

# Merge feature branch into main
git merge feature/new-feature

# Delete branch after merging
git branch -d feature/new-feature
```

### Branch Naming Conventions
```bash
feature/payment-integration     # New features
bugfix/crash-on-launch         # Bug fixes
hotfix/security-patch          # Urgent fixes
refactor/networking-layer      # Code refactoring
docs/update-readme             # Documentation
test/add-unit-tests            # Testing
```

---

## 🔄 Undoing Changes

### Before Commit
```bash
# Discard changes in a file
git checkout -- path/to/file.swift

# Unstage a file (keep changes)
git reset HEAD path/to/file.swift

# Discard all local changes (careful!)
git reset --hard
```

### After Commit
```bash
# Undo last commit, keep changes
git reset --soft HEAD~1

# Undo last commit, discard changes (careful!)
git reset --hard HEAD~1

# Undo commit but create new commit (safer)
git revert HEAD
```

### Amend Last Commit
```bash
# Fix last commit message
git commit --amend -m "New message"

# Add more changes to last commit
git add forgotten-file.swift
git commit --amend --no-edit
```

---

## 🔍 Viewing History

### View Commits
```bash
# Show recent commits
git log

# Compact one-line view
git log --oneline

# Show last 10 commits
git log --oneline -10

# Show commits with changed files
git log --stat

# Show commits for specific file
git log -- path/to/file.swift

# Pretty graph view
git log --graph --oneline --all
```

### View Changes
```bash
# Show changes in working directory
git diff

# Show staged changes
git diff --staged

# Show changes in specific commit
git show abc1234

# Show changes between branches
git diff main feature/new-feature
```

---

## 🏷️ Tags & Releases

### Create Tags
```bash
# Create lightweight tag
git tag v1.0.0

# Create annotated tag (recommended)
git tag -a v1.0.0 -m "Version 1.0.0 - Initial Release"

# Tag a specific commit
git tag -a v1.0.0 abc1234 -m "Version 1.0.0"

# List tags
git tag
```

### Push Tags
```bash
# Push specific tag
git push origin v1.0.0

# Push all tags
git push --tags
```

### Delete Tags
```bash
# Delete local tag
git tag -d v1.0.0

# Delete remote tag
git push origin --delete v1.0.0
```

---

## 🔗 Remote Management

### View Remotes
```bash
# List remotes
git remote -v

# Show remote details
git remote show origin
```

### Manage Remotes
```bash
# Add remote
git remote add origin https://github.com/USERNAME/solomine.git

# Change remote URL
git remote set-url origin https://github.com/USERNAME/solomine.git

# Remove remote
git remote remove origin
```

---

## 🧹 Cleanup

### Clean Working Directory
```bash
# Remove untracked files (dry run first!)
git clean -n

# Actually remove untracked files
git clean -f

# Remove untracked files and directories
git clean -fd
```

### Prune Old Branches
```bash
# Remove local branches that are merged
git branch --merged | grep -v "\*" | xargs git branch -d

# Remove references to deleted remote branches
git fetch --prune
```

---

## 🔍 Searching

### Search for Code
```bash
# Search for text in files
git grep "functionName"

# Search in specific files
git grep "functionName" "*.swift"

# Show line numbers
git grep -n "functionName"
```

### Search Commits
```bash
# Find commits with message
git log --grep="feature"

# Find commits by author
git log --author="Rob"

# Find commits that changed specific text
git log -S "functionName"
```

---

## 🚨 Emergency Commands

### Oh No! I Committed to Wrong Branch!
```bash
# 1. Create correct branch from current position
git branch feature/correct-branch

# 2. Reset current branch to before commits
git reset --hard origin/main

# 3. Switch to correct branch
git checkout feature/correct-branch
```

### Oh No! I Need to Uncommit!
```bash
# Undo last commit but keep changes
git reset --soft HEAD~1

# Keep changes staged
git reset --mixed HEAD~1

# Discard changes completely (careful!)
git reset --hard HEAD~1
```

### Oh No! I Deleted My Work!
```bash
# Show recent actions
git reflog

# Restore to specific point
git reset --hard HEAD@{2}
```

### Oh No! Merge Conflict!
```bash
# See conflicted files
git status

# After fixing conflicts in files:
git add resolved-file.swift
git commit

# Or abort merge
git merge --abort
```

---

## 📊 Useful Aliases

Add these to your `~/.gitconfig` file:

```ini
[alias]
    st = status
    co = checkout
    br = branch
    ci = commit
    unstage = reset HEAD --
    last = log -1 HEAD
    visual = log --graph --oneline --all
    amend = commit --amend --no-edit
    undo = reset --soft HEAD~1
```

Then use them like:
```bash
git st              # Instead of git status
git co main         # Instead of git checkout main
git br              # Instead of git branch
git visual          # Pretty log view
```

---

## 🎯 Workflow Examples

### Feature Development
```bash
# 1. Create feature branch
git checkout -b feature/payment-system

# 2. Make changes and commit
git add .
git commit -m "✨ Add Stripe integration"

# 3. More changes
git add .
git commit -m "✨ Add Apple Pay support"

# 4. Push to GitHub
git push -u origin feature/payment-system

# 5. Create Pull Request on GitHub

# 6. After approval, merge on GitHub or locally:
git checkout main
git merge feature/payment-system
git push

# 7. Delete feature branch
git branch -d feature/payment-system
git push origin --delete feature/payment-system
```

### Bug Fix
```bash
# 1. Create bugfix branch
git checkout -b bugfix/crash-on-login

# 2. Fix and commit
git add LoginView.swift
git commit -m "🐛 Fix crash when username is empty"

# 3. Push and create PR
git push -u origin bugfix/crash-on-login

# 4. Merge after review
```

### Release Process
```bash
# 1. Create release branch
git checkout -b release/v1.1.0

# 2. Update version numbers, changelog, etc.
git commit -am "🔖 Prepare v1.1.0 release"

# 3. Merge to main
git checkout main
git merge release/v1.1.0

# 4. Tag release
git tag -a v1.1.0 -m "Version 1.1.0"

# 5. Push everything
git push origin main
git push origin v1.1.0

# 6. Create release on GitHub with notes
```

---

## 💡 Best Practices

### Commit Messages
✅ **Good:**
```bash
git commit -m "✨ Add dark mode support to settings screen"
git commit -m "🐛 Fix memory leak in image cache"
git commit -m "📝 Update README with installation instructions"
git commit -m "♻️ Refactor networking layer to use async/await"
```

❌ **Not Good:**
```bash
git commit -m "stuff"
git commit -m "fixes"
git commit -m "WIP"
git commit -m "asdfasdf"
```

### Commit Frequency
- Commit often - small, logical changes
- Each commit should be a complete thought
- One feature/fix per commit when possible
- Don't wait until end of day

### Branch Strategy
- `main` - Production-ready code
- `develop` - Integration branch (optional)
- `feature/*` - New features
- `bugfix/*` - Bug fixes
- `hotfix/*` - Emergency production fixes
- `release/*` - Release preparation

---

## 📚 Learn More

- [Official Git Documentation](https://git-scm.com/doc)
- [GitHub Guides](https://guides.github.com)
- [Learn Git Branching](https://learngitbranching.js.org) - Interactive tutorial
- [Oh Shit, Git!?!](https://ohshitgit.com) - Common mistakes & fixes

---

## 🆘 Getting Help

```bash
# Help for any command
git help <command>
git help commit
git help branch

# Quick reference
git <command> --help
git commit --help
```

---

*Keep this file handy for quick reference! 🚀*
