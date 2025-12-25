# Mohamed Eladnani | Flutter Portfolio

A modern, high-performance, and fully responsive portfolio application built with Flutter. Designed with the sleek aesthetics of `shadcn/ui`, this portfolio showcases my technical expertise as a Full-Stack Flutter Developer, my background at 1337 Coding School (42 Network), and my professional projects.

## Features

- **Fully Responsive**: Optimized for all devices—mobile, tablet, and desktop—using a custom responsive grid system involving `mainAxisExtent` and flexible layouts.
- **Modern Aesthetic**: Inspired by the `shadcn/ui` design system, featuring clean typography (Inter), subtle shadows, and a professional monochrome palette.
- **Dark & Light Mode**: Seamless theme switching with persistent state management.
- **Project Showcase**: Rich project cards with real screenshots and GitHub links.
- **Resume Download**: One-click PDF download for recruiters.
- **Direct Contact**: Integrated contact form powered by EmailJS—send emails directly from the site without a backend.
- **Interactive Sections**:
  - **About**: Personal background and core values.
  - **Skills**: Categorized technical expertise (Core, State Management, Tools).
  - **Projects**: Filterable showcase with detailed cards and action buttons.
  - **Experience**: Timeline-based history including Freelance and 1337.
  - **Contact**: Functional form and social links.

## Tech Stack

- **Framework**: [Flutter](https://flutter.dev) (v3.10+)
- **Language**: [Dart](https://dart.dev)
- **UI Architecture**: Custom responsive widgets & clean architecture
- **Design System**: Custom implementation inspired by Shadcn UI
- **Typography**: [Google Fonts (Inter)](https://fonts.google.com/specimen/Inter)
- **Services**: [EmailJS](https://www.emailjs.com/) (Contact Form), [Url Launcher](https://pub.dev/packages/url_launcher)

## Getting Started

### Prerequisites

- Flutter SDK (latest stable recommended)
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/mel-adna/Portfolio_With_Flutter.git
   cd Portfolio_With_Flutter
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Environment Variables**
   Create a `.env` file in the root directory:
   ```env
   EMAILJS_SERVICE_ID=your_service_id
   EMAILJS_TEMPLATE_ID=your_template_id
   EMAILJS_USER_ID=your_public_key
   ```

4. **Run the application**
   ```bash
   flutter run -d chrome
   ```

## Deployment

This project is optimized for web deployment (e.g., GitHub Pages).

### Deploy to GitHub Pages

1.  **Build the web application:**
    ```bash
    flutter build web --release --base-href "/"
    # Note: Use "/<REPO_NAME>/" if deploying to a project page instead of a user site.
    ```

2.  **Deploy:**
    Push the contents of the `build/web` directory to your repository's `gh-pages` branch, or configure GitHub Actions to do it automatically.

## Project Structure

- `lib/core`: Theme configuration, typography, spacing, and responsive utilities.
- `lib/data`: Data models and static content for user details.
- `lib/pages`: Main application screens (Home).
- `lib/sections`: Modular UI sections (Hero, About, Skills, Projects, etc.).
- `lib/widgets`: Reusable, design-system compliant components (ShadcnCard, ShadcnButton, etc.).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
Built by [Mohamed Eladnani](https://github.com/mel-adna)
