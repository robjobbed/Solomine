# 🎨 Quick Guide: Theme Toggle

## What You Get

A beautiful theme toggle in your drawer menu! 

## Where to Find It

1. **Open App** → Tap the **menu icon** (☰) in top-left
2. **Scroll to bottom** → Look for **"APPEARANCE"** section
3. **Choose your theme:**

```
┌──────────────────────────────────────┐
│                                      │
│  SOLOMINE                            │
│  @robcodes ✓                         │
│  5.4K followers                      │
│                                      │
├──────────────────────────────────────┤
│  🔍 EXPLORE                          │
│  💼 GIGS                             │
│  💬 MESSAGES                         │
│  📊 DASHBOARD                        │
│  👤 PROFILE                          │
├──────────────────────────────────────┤
│                                      │
│  APPEARANCE                          │
│                                      │
│  ┌─────┐  ┌─────┐  ┌─────┐         │
│  │  ☀️ │  │ 🌙  │  │ ⚙️  │         │
│  │LIGHT│  │DARK │  │AUTO │         │
│  └─────┘  └─────┘  └─────┘         │
│    ↑                                 │
│  Selected (highlighted green)        │
│                                      │
├──────────────────────────────────────┤
│  🚪 LOG OUT                          │
└──────────────────────────────────────┘
```

## The Three Options

### ☀️ LIGHT
- **Forces light mode** all the time
- White backgrounds, dark text
- Great for bright environments
- Ignores system settings

### 🌙 DARK  
- **Forces dark mode** all the time
- Black backgrounds, light text
- Perfect for night use or dark rooms
- Ignores system settings
- **Default choice**

### ⚙️ AUTO
- **Follows iOS system settings**
- Changes with Control Center toggle
- Respects scheduled dark mode
- Updates automatically

## How It Works

### First Time
1. App opens in **DARK** mode (default)
2. Open drawer → See **DARK** selected
3. Tap **LIGHT** or **AUTO** to change
4. Theme instantly updates! ✨

### After That
- Your choice is **remembered**
- Works across app restarts
- No need to select again
- Change anytime you want!

## Visual Changes

### Dark Mode (🌙)
```
Background: Almost black (#0D0D0D)
Cards: Dark grey (#1A1A1A)
Text: Off-white (#E8E6E3)
Accent: Olive green (#9BAA7F)
```

### Light Mode (☀️)
```
Background: Pure white (#FFFFFF)
Cards: Light grey (#F5F5F5)  
Text: Dark grey (#1A1A1A)
Accent: Olive green (#9BAA7F) - Same!
```

## Tips & Tricks

### 💡 Pro Tip #1: Quick Access
The drawer remembers your last tab, so you can quickly jump back to any section.

### 💡 Pro Tip #2: System Override
Using **LIGHT** or **DARK** means your app looks consistent even if you toggle iOS system appearance.

### 💡 Pro Tip #3: Save Battery
**DARK** mode uses less battery on OLED screens (iPhone X and newer).

### 💡 Pro Tip #4: Readability
Switch to **LIGHT** mode when outdoors in bright sunlight for better screen readability.

### 💡 Pro Tip #5: Night Mode
Use **DARK** mode at night to reduce eye strain and blue light exposure.

## What's Different?

### Before This Update
- Only dark mode available
- No user choice
- Fixed appearance

### After This Update ✨
- **3 theme options**
- User can choose preference
- **Preference persists**
- Smooth animated transitions
- System integration with AUTO mode

## Common Questions

**Q: Will this reset if I close the app?**  
A: Nope! Your choice is saved forever (until you change it).

**Q: Can I change it anytime?**  
A: Yes! Change as often as you like.

**Q: Does AUTO drain battery?**  
A: No! It just checks your iOS setting once when views load.

**Q: Can I see a preview before selecting?**  
A: The change is instant, so just tap and see! Don't like it? Tap another option.

**Q: Why is green still green in light mode?**  
A: The accent color (#9BAA7F) works beautifully in both modes! It's our brand identity.

## Technical Nerds 🤓

If you're curious about implementation:

**Storage:** `@AppStorage("preferredColorScheme")`  
**Values:** `"light"`, `"dark"`, `"system"`  
**Default:** `"dark"`  
**Persistence:** UserDefaults  
**Animation:** Spring (0.3s, 80% damping)  
**API:** SwiftUI `.preferredColorScheme()`

## Need Help?

If theme toggle isn't working:
1. Force quit app
2. Relaunch
3. Try again
4. Still broken? Email rob@solomine.io

## Enjoy! 🎉

Your Solomine app now adapts to your preferences and environment!

Try all three modes and pick your favorite! 🌈

---

*Happy theming!*  
*- The Solomine Team*
