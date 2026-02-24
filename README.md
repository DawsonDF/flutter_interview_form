# Flutter Interview Project: Multi-Step Form

Welcome to your Flutter interview challenge! This project tests your understanding of Flutter fundamentals, state management, and local data persistence.

## Overview

You'll build a client registration form with three steps:
1. Personal Information - Name, email, phone, date of birth
2. Address - Street, city, state, ZIP code
3. Review & Submit - Review and confirm all information

Focus Areas:
- State management with Provider
- Local data persistence with SharedPreferences
- Form validation
- Flutter widget composition

Time Limit: 60 minutes

#### NOTE:
You are NOT being evaluated on completing the
project. You are being evaluated on code quality, design, and explanation of your thought process.

## Getting Started

### Setup

```bash
# Install dependencies
flutter pub get

# Run the application
flutter run
```

## Project Structure

```
lib/
├── main.dart                           # App entry point (provided)
├── models/
│   ├── registration_form.dart          # Form data model (provided)
│   ├── address.dart                    # Address model (provided)
│   └── validation_result.dart          # Validation helpers (provided)
├── services/
│   └── persistence_service.dart        # SharedPreferences wrapper (provided)
├── screens/
│   └── registration_screen.dart        # IMPLEMENT HERE
├── widgets/
│   ├── custom_text_form_field.dart     # Reusable text field (provided)
│   ├── date_picker_form_field.dart     # Date picker (provided)
│   └── dropdown_form_field.dart        # Dropdown (provided)
├── providers/
│   └── registration_provider.dart      # CREATE THIS - State management
└── utils/
    └── validators.dart                 # Validation functions (provided)
```

## Project Requirements

Your task is to complete the registration form by implementing the following:

### Requirement 1: Build Personal Information Form (Step 1)

File: `lib/screens/registration_screen.dart` → `_buildPersonalInfoStep()`

Add form fields for:
- Full Name (TextFormField)
- Email (TextFormField)
- Phone Number (TextFormField with PhoneNumberFormatter)
- Date of Birth (DatePickerFormField)

All fields are required and must be validated.

### Requirement 2: Build Address Form (Step 2)

File: `lib/screens/registration_screen.dart` → `_buildAddressStep()`

Add form fields for:
- Street Address (TextFormField)
- City (TextFormField)
- State (DropdownFormField using USStates.all from validation_result.dart)
- ZIP Code (TextFormField)
- Country (TextFormField - read-only, default value: "United States")

All fields are required and must be validated.

### Requirement 3: Display Form Data on Review Screen (Step 3)

File: `lib/screens/registration_screen.dart` → `_buildReviewStep()`

Display all form data collected from Steps 1 and 2:
- Show personal information (Full Name, Email, Phone, DOB)
- Show address information (Street, City, State, ZIP, Country)
- Display the actual values entered by user
- All fields should be read-only

### Requirement 4: Create State Management Provider

File: `lib/providers/registration_provider.dart`

Create a RegistrationProvider class that extends ChangeNotifier:
- Store the current form data (RegistrationForm instance)
- Provide methods to update individual form fields
- Call notifyListeners() when data changes
- Connect all form inputs to this provider using Consumer<RegistrationProvider>

### Requirement 5: Save Form Data to SharedPreferences

When user clicks the Submit button:
- Validate all form data
- Check if the email or phone number already exists in SharedPreferences
- If duplicate email or phone found: show error message and prevent submission
- If all data is valid and no duplicates: save to SharedPreferences using PersistenceService
- Show success message
- Reset form back to Step 1

### Requirement 6: Prevent Duplicate Email and Phone Submission

Implement validation that prevents form submission if:
- Email address matches any previously submitted email in SharedPreferences
- Phone number matches any previously submitted phone number in SharedPreferences

Display clear error message telling user why submission failed.

## Resources Provided

- RegistrationForm model with toMap()/fromMap() for serialization
- Address model with toMap()/fromMap() for serialization
- Validators class with required(), email(), phoneNumber(), zipCode(), minimumAge()
- CustomTextFormField, DatePickerFormField, DropdownFormField widgets
- PersistenceService for saving/loading data
- USStates.all list for state dropdown
- PhoneNumberFormatter for automatic phone formatting

## Testing Checklist

Verify your implementation:

- [ ] All form fields display correctly
- [ ] Personal information fields validate as required
- [ ] Address fields validate as required
- [ ] Review screen shows all entered data
- [ ] Form submission saves data to SharedPreferences
- [ ] Duplicate email is rejected on submission
- [ ] Duplicate phone number is rejected on submission
- [ ] Error messages display for validation failures
- [ ] Form resets after successful submission
- [ ] Can submit multiple registrations without errors
- [ ] Saved data can be verified in SharedPreferences
