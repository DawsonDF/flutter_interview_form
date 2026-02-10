/// Common validation functions for form fields
class Validators {
  /// Validate required field
  static String? required(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  /// Validate minimum length
  static String? minLength(String? value, int length, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return null; // Let required validator handle empty
    }
    if (value.trim().length < length) {
      return '$fieldName must be at least $length characters';
    }
    return null;
  }

  /// Validate email format
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Let required validator handle empty
    }
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Validate phone number (US format: 10 digits)
  static String? phoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Let required validator handle empty
    }
    
    // Remove all non-digit characters
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    
    if (digitsOnly.length != 10) {
      return 'Phone number must be 10 digits';
    }
    return null;
  }

  /// Validate ZIP code (US format: 5 digits)
  static String? zipCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Let required validator handle empty
    }
    
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    
    if (digitsOnly.length != 5) {
      return 'ZIP code must be 5 digits';
    }
    return null;
  }

  /// Validate age (must be 18 or older)
  static String? minimumAge(DateTime? dateOfBirth, int minimumAge) {
    if (dateOfBirth == null) {
      return null; // Let required validator handle null
    }
    
    final today = DateTime.now();
    int age = today.year - dateOfBirth.year;
    
    if (today.month < dateOfBirth.month ||
        (today.month == dateOfBirth.month && today.day < dateOfBirth.day)) {
      age--;
    }
    
    if (age < minimumAge) {
      return 'You must be at least $minimumAge years old';
    }
    return null;
  }

  /// Combine multiple validators
  static String? combine(List<String? Function()> validators) {
    for (final validator in validators) {
      final error = validator();
      if (error != null) return error;
    }
    return null;
  }
}
