'''
================================================================================
                              KEYPAL - README.txt
                      SE 380 Project - Mobile Application
================================================================================

PROJECT NAME: KeyPal - Digital Pen Pal Letter Writing Application
FLUTTER VERSION: 3.35.6
DART VERSION: 3.9.2

================================================================================
                              TABLE OF CONTENTS
================================================================================
1. Project Overview
2. Prerequisites
3. Installation Instructions
4. Firebase Configuration
5. Running the Application
6. Project Structure
7. Key Features
8. Troubleshooting
9. Team Members

================================================================================
                           1. PROJECT OVERVIEW
================================================================================

KeyPal is a Flutter mobile application that allows users to exchange letters
with pen-pals (called "Key Pals") around the world. The app combines the 
nostalgic charm of traditional letter writing with modern technology.

Main Features:
- User authentication with email verification
- Rich text letter writing with HTML editor
- Real-time letter sending and receiving
- User profiles with interests and languages
- Key Pal discovery and friend management
- Vintage-themed UI with paper textures and stamps

================================================================================
                           2. PREREQUISITES
================================================================================

Before running this project, ensure you have the following installed:

1. Flutter SDK (version 3.35.6 or later)
   Download from: https://flutter.dev/docs/get-started/install

2. Dart SDK (version 3.9.2 - comes with Flutter)

3. Android Studio (for Android development)
   OR Xcode (for iOS development - Mac only)

4. A code editor:
   - Visual Studio Code (recommended)
   - Android Studio
   - IntelliJ IDEA

5. Git (for cloning the repository)

6. A physical device or emulator/simulator

================================================================================
                      3. REQUIRED DEPENDENCIES
================================================================================

The following packages are required and will be automatically installed
when you run "flutter pub get":

CORE DEPENDENCIES:
  - firebase_core: ^3.15.2           (Firebase SDK)
  - firebase_auth: ^5.7.0            (User authentication)
  - cloud_firestore: ^5.6.12         (Database)

UI & DESIGN:
  - font_awesome_flutter: ^10.7.0    (Icon library)
  - google_fonts: ^6.2.1             (Custom fonts)
  - lottie: ^3.0.0                   (Animations)
  - country_picker: ^2.0.20          (Country selection)

TEXT EDITOR:
  - flutter_html: ^3.0.0-beta.2      (HTML rendering)
  - html_editor_enhanced: ^2.5.1     (Rich text editing)
  - super_editor: ^0.3.0-dev.47      (Advanced editing)

UTILITIES:
  - intl: ^0.18.0                    (Date/time formatting)
  - provider: ^6.1.5                 (State management)
  - path_provider: ^2.1.5            (File system access)

DEV DEPENDENCIES (for development only):
  - build_runner: ^2.4.9             (Code generation)
  - freezed: ^2.4.7                  (Data class generation)
  - json_serializable: ^6.9.5        (JSON serialization)
  - flutter_riverpod: ^3.0.3         (State management)
  - flutter_lints: ^5.0.0            (Code quality)

CUSTOM FONTS INCLUDED:
  - GreatVibes
  - DancingScript (main app font)
  - Pacifico
  - Satisfy

ASSETS INCLUDED:
  - Vintage paper textures
  - Stamp images
  - Lottie animation files
  - Custom font files

================================================================================
                        4. INSTALLATION INSTRUCTIONS
================================================================================

STEP 1: Extract or Clone the Project
--------------------------------------
If you received a ZIP file:
  1. Extract the ZIP file to a location on your computer
  2. Navigate to the extracted folder

If using Git:
  git clone [repository-url]
  cd se_380_project_penpal

STEP 2: Open the Project
-------------------------
Using Visual Studio Code:
  1. Open VS Code
  2. Click File > Open Folder
  3. Navigate to the project folder and select it
  4. Click "Select Folder"

Using Android Studio:
  1. Open Android Studio
  2. Click "Open an Existing Project"
  3. Navigate to the project folder and select it
  4. Click "OK"

STEP 3: Install Dependencies
-----------------------------
Open a terminal in the project root directory and run:

  flutter pub get

This will download all required packages listed in pubspec.yaml.

STEP 4: Verify Flutter Installation
------------------------------------
Run the following command to check if Flutter is properly installed:

  flutter doctor

Address any issues marked with [!] or [✗] before proceeding.

================================================================================
                        5. FIREBASE CONFIGURATION
================================================================================

This application uses Firebase for backend services. You have two options:

OPTION A: Use Existing Firebase Configuration (Recommended for Testing)
------------------------------------------------------------------------
The project should already include firebase configuration files:
  - android/app/google-services.json
  - ios/Runner/GoogleService-Info.plist

If these files are present, skip to Section 6.

OPTION B: Set Up Your Own Firebase Project
-------------------------------------------
If you need to create your own Firebase project:

1. Go to https://console.firebase.google.com/
2. Click "Add Project" or "Create a Project"
3. Follow the setup wizard to create your project
4. Enable the following services:
   - Authentication (Email/Password)
   - Cloud Firestore

For Android:
  5. Click "Add app" > Android icon
  6. Register your app with package name: com.example.se_380_project_penpal
  7. Download google-services.json
  8. Place it in: android/app/google-services.json

For iOS:
  9. Click "Add app" > iOS icon
  10. Register your app with bundle ID: com.example.se380ProjectPenpal
  11. Download GoogleService-Info.plist
  12. Place it in: ios/Runner/GoogleService-Info.plist

Firebase Authentication Setup:
  13. In Firebase Console, go to Authentication > Sign-in method
  14. Enable "Email/Password" provider
  15. Save changes

Cloud Firestore Setup:
  16. In Firebase Console, go to Firestore Database
  17. Click "Create Database"
  18. Start in "Test Mode" (or production mode with proper rules)
  19. Choose a location and click "Enable"

================================================================================
                        6. RUNNING THE APPLICATION
================================================================================

STEP 1: Connect a Device or Start an Emulator
----------------------------------------------
Physical Device:
  - Android: Enable USB debugging in Developer Options
  - iOS: Trust your computer and ensure device is registered

Android Emulator:
  1. Open Android Studio
  2. Click AVD Manager (or Tools > AVD Manager)
  3. Create a new virtual device or start an existing one
  4. Wait for the emulator to fully load

iOS Simulator (Mac only):
  1. Open Xcode
  2. Go to Xcode > Open Developer Tool > Simulator
  3. Choose a device from Hardware > Device

STEP 2: Verify Device Connection
---------------------------------
In the terminal, run:

  flutter devices

You should see your connected device or emulator listed.

STEP 3: Run the Application
----------------------------
From the terminal in the project root:

  flutter run

OR in VS Code:
  1. Press F5 (or click Run > Start Debugging)
  2. Select your target device

OR in Android Studio:
  1. Select your device from the device dropdown
  2. Click the green "Run" button (play icon)

STEP 4: Wait for Build
-----------------------
The first build may take several minutes. Subsequent builds will be faster.
You'll see output in the terminal showing the build progress.

STEP 5: Test the Application
-----------------------------
Once the app launches:
  1. You'll see the login screen
  2. Click "Sign up" to create a new account
  3. Enter your name, email, and password (min 6 characters)
  4. Check your email for verification link
  5. Click the verification link
  6. Return to app and click "I've Verified My Email"
  7. Complete your profile setup
  8. Start using the app!

================================================================================
                          7. PROJECT STRUCTURE
================================================================================

se_380_project_penpal/
│
├── lib/
│   ├── features/
│   │   ├── auth/                   # Authentication screens
│   │   │   ├── login_screen.dart
│   │   │   ├── register_screen.dart
│   │   │   └── email_verification.dart
│   │   │
│   │   ├── home/
│   │   │   ├── home_screen.dart    # Main navigation hub
│   │   │   ├── letterbox/          # Received letters
│   │   │   ├── letters/            # Write letters
│   │   │   ├── friends/            # Key Pals management
│   │   │   └── profile/            # User profile
│   │   │
│   │   └── services/
│   │       └── letter_service.dart # Backend operations
│   │
│   ├── models/
│   │   ├── user_model.dart         # User data structure
│   │   └── letter_model.dart       # Letter data structure
│   │
│   ├── theme/
│   │   └── app_theme.dart          # App styling
│   │
│   └── main.dart                   # App entry point
│
├── assets/                         # Images, fonts, animations
├── android/                        # Android-specific files
├── ios/                            # iOS-specific files
├── pubspec.yaml                    # Dependencies & assets
└── README.txt                      # This file

================================================================================
                            8. KEY FEATURES
================================================================================

1. USER AUTHENTICATION
   - Sign up with email and password
   - Email verification required
   - Secure Firebase authentication

2. PROFILE MANAGEMENT
   - Create and edit profile
   - Add interests and languages
   - Set privacy preferences
   - View profile statistics

3. LETTER WRITING
   - Rich text editor with formatting
   - Bold, italic, underline, lists
   - Character count validation (min 50 chars)
   - Automatic greeting and closing

4. LETTERBOX
   - View received letters
   - Swipe to browse multiple letters
   - Vintage paper design
   - Tap to read full letter

5. KEY PALS
   - Search users by username
   - Send friend requests
   - View Key Pal profiles
   - Phonebook-style organization

6. UI/UX
   - Vintage aesthetic with Georgia font
   - Warm brown color palette
   - Lottie animations
   - Textured paper backgrounds

================================================================================
                          9. TROUBLESHOOTING
================================================================================

PROBLEM: "flutter: command not found"
SOLUTION: Add Flutter to your system PATH. See Flutter installation docs.

PROBLEM: Build fails with dependency errors
SOLUTION: Run "flutter clean" then "flutter pub get"

PROBLEM: Firebase connection errors
SOLUTION: Verify google-services.json (Android) or GoogleService-Info.plist 
          (iOS) are in the correct locations

PROBLEM: Emulator won't start
SOLUTION: Ensure hardware acceleration is enabled in BIOS/UEFI.
          For Android Studio, check AVD Manager settings.

PROBLEM: App crashes on startup
SOLUTION: Check that Firebase is properly configured and enabled in console.

PROBLEM: Email verification not working
SOLUTION: Check spam folder. Ensure Email/Password provider is enabled in
          Firebase Authentication settings.

PROBLEM: Letters not sending/receiving
SOLUTION: Verify Firestore is enabled and rules allow read/write operations.

PROBLEM: "Gradle build failed" (Android)
SOLUTION: 
  1. Delete android/.gradle folder
  2. Run "flutter clean"
  3. Run "flutter pub get"
  4. Try building again

PROBLEM: Xcode build errors (iOS)
SOLUTION:
  1. Run "pod install" in the ios/ directory
  2. Open ios/Runner.xcworkspace in Xcode
  3. Set development team in Signing & Capabilities

For other issues:
  - Check the Flutter logs in the terminal
  - Run "flutter doctor" to diagnose installation issues
  - Ensure you're using compatible Flutter/Dart versions

================================================================================
                          10. TEAM MEMBERS
================================================================================

- Betül Özsan - 20210602050
- Berra Okudurlar - 20210602419

================================================================================
                          11. ADDITIONAL NOTES
================================================================================

Testing Credentials (if applicable):
- Email: test@example.com
- Password: test123

Known Limitations:
- Image uploads not yet implemented
- Profile pictures are placeholder icons
- Dark mode not yet available
- No Forgot Password functionality
- No algorithm push for the users to discover each other

Future Enhancements:
- Push notifications
- Letter drafts
- Archive functionality
- Message encryption
- Image attachments
- Forgot Password 

================================================================================
                            CONTACT & SUPPORT
================================================================================

For questions or issues:
- Email: okudurlarberra@gmail.com
- GitHub: https://github.com/berraokudurlar/se_380_project_penpal

Thank you for reviewing our project!

================================================================================
                              END OF README
================================================================================
'''
