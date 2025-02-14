# CredX - Transaction Dispute Management App

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Overview
CredX is a Flutter-based simple app flow designed to help users manage their credit card transactions, raise disputes, and track dispute statuses. The app flow provides a seamless experience for viewing transaction details, filtering transactions, and initiating disputes.

## Features
1. Transaction Management:

   * View all transactions for a selected card.
   * Filter transactions by name or date range.
   * View detailed information for each transaction.

2. Dispute Management:

   * Raise disputes for specific transactions.
   * Track the status of disputes (e.g., "Under dispute," "Being reviewed," "Resolved").

3. Card Management:

   * Switch between multiple credit cards.
   * View card details such as card number, expiry date, and due amount.

4. User-Friendly UI:

   * Clean and intuitive design.
   * Responsive layout for various screen sizes.

## Screen Recording

![](https://github.com/user-attachments/assets/6cebbf89-2e22-4ac2-8b9b-7810105a6d89)

## Screenshots

<ul>
  <li>Home Screen</li>
  <li>Transaction Details</li>
  <li>Raise a dispute</li>
  <li>Dispute Confirmation</li>
</ul>

<img src="https://github.com/user-attachments/assets/3ba6ca4a-ac19-4bed-b034-30e036e174da" data-canonical-src="" width="211" height="458" />
<img src="https://github.com/user-attachments/assets/8c070461-c9a6-49a9-aa3b-203e6624d0eb" data-canonical-src="" width="211" height="458" />
<img src="https://github.com/user-attachments/assets/d1889dae-caee-419c-b934-1da5a64dbeb9" data-canonical-src="" width="211" height="458" />
<img src="https://github.com/user-attachments/assets/091f1326-0f91-4127-b3e8-165fc97960f0" data-canonical-src="" width="211" height="458" />

## Technologies Used
Flutter: A UI toolkit for building natively compiled applications.

GetX: A lightweight state management and dependency injection library.

Dart: The programming language used for Flutter development.

Material Design: For a consistent and modern UI.

## Getting Started
Follow these steps to set up and run the project on your local machine.

## Prerequisites
1. Flutter SDK (version 3.0.0 or higher)
2. Dart SDK (version 2.17.0 or higher)
3. Android Studio or VS Code (with Flutter and Dart plugins installed)
4. An Android or iOS emulator, or a physical device for testing.

## Installation
Clone the Repository:

    git clone https://github.com/DJamesSmith/CredX-Transaction_Dispute_Management_App.git
    cd credx-transaction-dispute-app

Install Dependencies:

    flutter pub get

Run the App:

    flutter run

Build the App:

For Android:

    flutter build apk

For iOS:

    flutter build ios

## Project Structure
Here’s an overview of the project structure:

    lib/
    ├── config/                 # Storing string constants
    ├── constants/              # Storing string and asset constants
    ├── controllers/            # GetX controllers for state management
    ├── utils/                  # Utility functions and helpers
    ├── widgets/                # Reusable UI components
    ├── screens/                # Application screens
    ├── main.dart               # Entry point of the application

## State Management
The app uses GetX for state management. Key controllers include:

1. TransactionController: Manages transactions, disputes, and filtering logic.
2. CardController: Manages card selection and details.

## Dependencies
The app uses the following dependencies (check pubspec.yaml for the full list):

    get: For state management and navigation.
    intl: For date and time formatting.
    fluttertoast: For displaying toast messages.
    lottie: For animations

## Contributing
Contributions are welcome! If you'd like to contribute, please follow these steps:

    1. Fork the repository.
    2. Create a new branch for your feature or bugfix.
    3. Commit your changes and push to the branch.
    4. Submit a pull request.

## Acknowledgments
Thanks to the GetX library for simplifying state management.``