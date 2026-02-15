# Contributing to Solomine

First off, thank you for considering contributing to Solomine! It's people like you that make Solomine such a great tool.

## Code of Conduct

This project and everyone participating in it is governed by a Code of Conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior to rob@solomine.io.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check existing issues as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

* **Use a clear and descriptive title**
* **Describe the exact steps which reproduce the problem**
* **Provide specific examples to demonstrate the steps**
* **Describe the behavior you observed after following the steps**
* **Explain which behavior you expected to see instead and why**
* **Include screenshots and animated GIFs** if possible
* **Include your iOS version, device model, and Xcode version**

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

* **Use a clear and descriptive title**
* **Provide a step-by-step description of the suggested enhancement**
* **Provide specific examples to demonstrate the steps**
* **Describe the current behavior** and **explain which behavior you expected to see instead**
* **Explain why this enhancement would be useful**

### Pull Requests

* Fill in the required template
* Follow the Swift style guide
* Include thoughtful commit messages
* Include screenshots and animated GIFs in your pull request whenever possible
* Document new code
* End all files with a newline

## Swift Style Guide

### Code Formatting

* Use 4 spaces for indentation (not tabs)
* Use camelCase for variable and function names
* Use PascalCase for type names (classes, structs, enums, protocols)
* Use meaningful, descriptive names
* Prefer `let` over `var` whenever possible
* Use implicit type inference where possible

### SwiftUI Best Practices

* Keep views small and composable
* Extract subviews when a view becomes too complex
* Use `@State` for view-local state
* Use `@StateObject` for view models
* Use `@EnvironmentObject` for shared state
* Prefer Swift Concurrency (async/await) over completion handlers

### Example

```swift
// Good ✅
struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ProfileHeaderView(user: viewModel.user)
                ProfileDetailsView(user: viewModel.user)
            }
        }
        .task {
            await viewModel.loadProfile()
        }
    }
}

// Not ideal ❌
struct ProfileView: View {
    @StateObject private var vm = ProfileViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // 100+ lines of view code here...
            }
        }
        .onAppear {
            vm.loadProfile()
        }
    }
}
```

## Git Commit Messages

* Use the present tense ("Add feature" not "Added feature")
* Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
* Limit the first line to 72 characters or less
* Reference issues and pull requests liberally after the first line
* Consider starting the commit message with an applicable emoji:
    * 🎨 `:art:` when improving the format/structure of the code
    * 🐎 `:racehorse:` when improving performance
    * 📝 `:memo:` when writing docs
    * 🐛 `:bug:` when fixing a bug
    * 🔥 `:fire:` when removing code or files
    * ✅ `:white_check_mark:` when adding tests
    * 🔒 `:lock:` when dealing with security
    * ⬆️ `:arrow_up:` when upgrading dependencies
    * ⬇️ `:arrow_down:` when downgrading dependencies

### Example

```
✨ Add dark mode theme customization

- Add Theme enum with matte black, midnight blue, and forest green
- Create ThemeModifier for applying themes
- Add theme selection in Settings
- Persist theme preference in UserDefaults

Closes #123
```

## Development Process

1. **Fork the repo** and create your branch from `main`
2. **Make your changes** following the style guide
3. **Test your changes** thoroughly
4. **Update documentation** if you changed APIs
5. **Ensure the test suite passes**
6. **Make sure your code lints** (no warnings in Xcode)
7. **Create a pull request**

## Setting Up Your Development Environment

1. **Clone your fork**
   ```bash
   git clone https://github.com/YOUR_USERNAME/solomine.git
   cd solomine
   ```

2. **Create a branch**
   ```bash
   git checkout -b feature/my-new-feature
   ```

3. **Open in Xcode**
   ```bash
   open Solomine.xcodeproj
   ```

4. **Make your changes and commit**
   ```bash
   git add .
   git commit -m "✨ Add some feature"
   ```

5. **Push to your fork**
   ```bash
   git push origin feature/my-new-feature
   ```

6. **Open a Pull Request** on GitHub

## Testing

* Write tests for new features
* Ensure all tests pass before submitting PR
* Test on both simulator and real device when possible
* Test on different iOS versions (minimum iOS 16.0)
* Test in light and dark mode
* Test with different theme settings

### Running Tests

```bash
# Command line
xcodebuild test -scheme Solomine -destination 'platform=iOS Simulator,name=iPhone 15 Pro'

# Or in Xcode: Product → Test (Cmd + U)
```

## Documentation

* Update the README.md if needed
* Add inline documentation for public APIs
* Use Swift's documentation markup format:

```swift
/// Fetches user profile from the server.
///
/// - Parameter userID: The unique identifier for the user
/// - Returns: A `User` object with profile information
/// - Throws: `NetworkError` if the request fails
func fetchUserProfile(userID: String) async throws -> User {
    // Implementation
}
```

## Questions?

Don't hesitate to ask questions! You can:

* Open an issue with the label `question`
* Email rob@solomine.io
* Reach out on X (Twitter) [@solomine](https://twitter.com/solomine)

## Recognition

Contributors will be recognized in the README.md file. Thank you for your contributions! 🎉

---

Thank you for contributing to Solomine! 🚀
