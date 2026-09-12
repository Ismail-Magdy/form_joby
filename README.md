# Joby

A dynamic, responsive, and robust data collection web application built with Flutter Web.

**🔗 [Live Form](https://joby-early-access.netlify.app)** | **🔗 [App Website](https://joby-site.vercel.app/)**

![Joby Web Preview](image_link)

## Overview

Joby is a web based form application designed to efficiently collect, validate, and process user profile data for early access registration. Flutter Web was chosen as the primary technology stack to leverage a single codebase for building a highly customized, interactive, and responsive user interface, while maintaining desktop class performance and native feeling web interactions.

## Key Features

- **Comprehensive Data Collection**: Collects essential user details including Full Name, Email, Password, Job Category, Job Title, Level, Work Type, and social profiles (WhatsApp, LinkedIn, GitHub).
- **Robust Form Validation**: Real time field validation for emails, passwords, phone numbers, and URLs ensuring high data integrity before submission.
- **File Uploads**: Supports secure document and image uploading, including a mandatory CV (PDF format) and an optional Avatar (image), powered by `file_picker`.
- **Responsive Design**: Built using `flutter_screenutil` to automatically adapt the UI to various screen sizes, ensuring a flawless experience from desktop monitors down to mobile browsers.
- **Modern UI/UX**: Clean, accessible, and intuitive interface with clear error reporting and loading states for a seamless user experience.

## Architecture & Tech Stack

Joby is built with maintainability and scalability in mind, adhering to **Clean Architecture** principles and the **MVVM** pattern:

- **State Management**: Uses **Flutter Bloc (Cubit)** to decouple UI logic from business logic. State is cleanly managed with explicit `FormState` classes (`FormLoading`, `FormSuccess`, `FormFailure`), ensuring predictable UI updates.
- **Dependency Injection (DI)**: Utilizes **GetIt** (`core/di/service_locator.dart`) for a scalable and testable dependency injection setup.
- **Modular Structure**: Features are divided into domain-specific directories (e.g., `features/form/presentation`, `features/form/manager`), keeping the codebase modular and compliant with **SOLID** principles.
- **Backend Integration**: Pre-configured to integrate with **Supabase** for secure, serverless database operations and storage.
- **Styling & Theming**: Centralized theme management (`AppTheme`) for consistent styling across the application.

## DevOps & Deployment (Web)

Deploying Joby to the web is streamlined thanks to Flutter's web build tools.

### Building for Web

To create an optimized release build for production, run:

```bash
flutter build web --release
```

This generates a static web bundle in the `build/web` directory, containing the compiled HTML, CSS, and JavaScript, ready to be hosted.

### CI/CD & Hosting Suggestions

The output in `build/web` can be deployed to any static hosting provider.
- **Vercel & Netlify**: Deploy easily by pointing your project's output directory to `build/web`. Vercel provides excellent seamless integrations for Flutter Web.
- **Firebase Hosting**: Run `firebase init hosting` followed by `firebase deploy` to quickly host the app on Google's infrastructure.
- **GitHub Pages**: Perfect for open-source or free hosting. It can be fully automated using GitHub Actions workflows.

**Continuous Integration**: It's recommended to set up a CI pipeline (e.g., GitHub Actions) to automate `flutter analyze` and `flutter test` on every PR, ensuring code quality before deployment.

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Ensure web support is enabled)
- Google Chrome browser for debugging

### Running Locally

1. Clone the repository and navigate to the project directory:
   ```bash
   git clone https://github.com/Ismail-Magdy/form_joby.git
   cd form
   ```

2. Install the required dependencies:
   ```bash
   flutter pub get
   ```

3. Run the application locally in Chrome:
   ```bash
   flutter run -d chrome
   ```
