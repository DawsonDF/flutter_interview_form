# Flutter Interview Project: Multi-Step Form

Welcome to your Flutter interview challenge! This project tests your understanding of Flutter fundamentals, state management, and local data persistence.

## Overview

You'll build a client registration form with three steps:
1. **Personal Information** - Name, email, phone, date of birth
2. **Address** - Street, city, state, ZIP code
3. **Review & Submit** - Review and confirm all information

**Focus Areas:**
- State management with Provider
- Local data persistence with SharedPreferences
- Async operations and form validation
- Flutter widget composition

**Time Limit:** 90 minutes

## Getting Started

### Setup

```bash
# Clone the repository
git clone [REPOSITORY_URL]
cd flutter_interview_form

# Install dependencies
flutter pub get

# Run the application
flutter run
```

## 📁 Project Structure

```
lib/
├── main.dart                           # App entry point (provided)
├── models/
│   ├── registration_form.dart          # Form data model (provided)
│   ├── address.dart                    # Address model (provided)
│   └── validation_result.dart          # Validation helpers (provided)
├── services/
│   ├── data_service.dart               # In-memory data with seed data (provided)
│   └── persistence_service.dart        # SharedPreferences wrapper (provided)
├── screens/
│   └── registration_screen.dart        # SCAFFOLD PROVIDED - Implement here
├── widgets/
│   ├── custom_text_form_field.dart     # Reusable text field (provided)
│   ├── date_picker_form_field.dart     # Date picker (provided)
│   └── dropdown_form_field.dart        # Dropdown (provided)
├── providers/
│   └── registration_provider.dart      # ❌ YOUR CODE GOES HERE - Implement state management
└── utils/
    └── validators.dart                 # Validation functions (provided)
```
