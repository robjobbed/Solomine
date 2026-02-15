# Solomine

<div align="center">
  
  **The marketplace connecting builders with clients**
  
  [![Platform](https://img.shields.io/badge/platform-iOS-lightgrey.svg)]()
  [![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)]()
  [![License](https://img.shields.io/badge/license-MIT-blue.svg)]()
  
</div>

## 📱 About

Solomine is a modern iOS marketplace that connects talented developers and builders with clients looking to bring their ideas to life. Built entirely in SwiftUI, Solomine offers a beautiful, dark-mode first experience with seamless authentication, profile management, and messaging.

### ✨ Key Features

- **🔐 X (Twitter) Authentication** - Secure sign-in with X/Twitter OAuth
- **👤 Dual Roles** - Join as a Builder or Client
- **💼 Profile Management** - Showcase skills, experience, and projects
- **🔍 Browse & Discover** - Find the perfect developer or project
- **💬 Direct Messaging** - Built-in chat system
- **🎨 Theme System** - Choose from Matte Black, Midnight Blue, or Forest Green
- **📄 Legal Compliance** - Full Terms of Service and Privacy Policy
- **⚙️ Settings & Support** - Complete user preferences and support system

## 🛠 Tech Stack

- **Language**: Swift 5.9+
- **UI Framework**: SwiftUI
- **Architecture**: MVVM
- **Authentication**: OAuth (X/Twitter)
- **Minimum iOS**: 16.0+

## 🏗 Project Structure

```
Solomine/
├── App/                        # App entry point
├── Views/                      # SwiftUI views
│   ├── Authentication/         # Login & auth flows
│   ├── Browse/                 # Browse developers/projects
│   ├── Messages/               # Chat interface
│   ├── Profile/                # User profiles
│   └── Settings/               # Settings & legal
├── ViewModels/                 # View models
├── Models/                     # Data models
├── Services/                   # API & business logic
│   ├── NetworkManager.swift
│   ├── AuthenticationManager.swift
│   └── PaymentManager.swift
├── Utilities/                  # Helpers & extensions
│   ├── Theme.swift
│   └── Config.swift
└── Resources/                  # Assets & configs
```

## 🚀 Getting Started

### Prerequisites

- Xcode 15.0 or later
- iOS 16.0+ deployment target
- Apple Developer account (for running on device)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/solomine.git
   cd solomine
   ```

2. **Open in Xcode**
   ```bash
   open Solomine.xcodeproj
   # or if using Swift Package Manager
   open Package.swift
   ```

3. **Configure OAuth (Optional)**
   - Copy `Config.swift.example` to `Config.swift`
   - Add your X (Twitter) OAuth credentials
   - For testing, you can use mock authentication (tap "Cancel" on login)

4. **Build and Run**
   - Select your target device or simulator
   - Press `Cmd + R` to build and run

## ⚙️ Configuration

The app uses `Config.swift` for environment-specific settings:

```swift
struct Config {
    // API endpoints
    static let apiBaseURL = "https://api.solomine.io"
    
    // OAuth
    static let twitterClientID = "YOUR_CLIENT_ID"
    
    // Legal URLs
    static let privacyPolicyURL = "https://solomine.io/privacy"
    static let termsOfServiceURL = "https://solomine.io/terms"
    
    // Support
    static let supportEmail = "rob@solomine.io"
}
```

## 🎨 Themes

Solomine includes three beautiful themes:

- **Matte Black** - Classic dark theme with pure blacks
- **Midnight Blue** - Rich blue tones with depth
- **Forest Green** - Earthy greens for a natural feel

Users can switch themes in Settings → Theme.

## 🧪 Testing

### Mock Mode

For development and testing without a backend:

1. Launch the app
2. Tap "Sign in with X"
3. Tap "Cancel" on the OAuth screen
4. Mock authentication will activate with sample data

### Running Tests

```bash
# Run all tests
xcodebuild test -scheme Solomine -destination 'platform=iOS Simulator,name=iPhone 15 Pro'

# Or use Xcode
# Product → Test (Cmd + U)
```

## 📱 App Store

Solomine is available on the App Store (coming soon!)

### Building for Release

1. Clean build folder: `Product → Clean Build Folder` (Cmd+Shift+K)
2. Select "Any iOS Device (arm64)"
3. Archive: `Product → Archive`
4. Validate and distribute through Xcode Organizer

See `PRODUCTION_BUILD_CHECKLIST.md` for detailed instructions.

## 📚 Documentation

- [`APP_STORE_LAUNCH_TODAY.md`](APP_STORE_LAUNCH_TODAY.md) - App Store submission guide
- [`PRIVACY_POLICY_HOSTING.md`](PRIVACY_POLICY_HOSTING.md) - Privacy policy setup
- [`LAUNCH_TODAY_ACTION_PLAN.md`](LAUNCH_TODAY_ACTION_PLAN.md) - Launch timeline
- [`BUSINESS_MODEL.md`](BUSINESS_MODEL.md) - Business strategy
- [`FREELANCER_GUIDE.md`](FREELANCER_GUIDE.md) - User guide for freelancers

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📋 Roadmap

### v1.1 (Upcoming)
- [ ] Real backend API integration
- [ ] Push notifications
- [ ] Payment processing (Stripe/Apple Pay)
- [ ] GitHub integration for builders
- [ ] File attachments in messages
- [ ] Advanced search and filters

### v2.0 (Future)
- [ ] Video calls
- [ ] Project management tools
- [ ] Contract templates
- [ ] Milestone tracking
- [ ] Reviews and ratings system

## 📄 Privacy & Legal

- [Privacy Policy](https://solomine.io/privacy)
- [Terms of Service](https://solomine.io/terms)
- Support: [rob@solomine.io](mailto:rob@solomine.io)

Solomine is compliant with CCPA and GDPR requirements.

## 📧 Contact

**Rob** - [@solomine](https://twitter.com/solomine) - rob@solomine.io

Project Link: [https://github.com/YOUR_USERNAME/solomine](https://github.com/YOUR_USERNAME/solomine)

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Built with [SwiftUI](https://developer.apple.com/xcode/swiftui/)
- Authentication powered by X (Twitter) OAuth
- Design inspiration from modern iOS apps
- Thanks to all beta testers and early users!

---

<div align="center">
  <p>Built with ❤️ using Swift and SwiftUI</p>
  <p>Made for builders, by builders</p>
</div>
