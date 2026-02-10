import 'address.dart';

/// Main form data model representing all steps
class RegistrationForm {
  // Step 1: Personal Information
  String fullName;
  String email;
  String phoneNumber;
  DateTime? dateOfBirth;
  
  // Optional business fields (stretch goal)
  bool isBusinessRegistration;
  String? businessName;
  
  // Step 2: Address Information
  Address address;
  
  RegistrationForm({
    this.fullName = '',
    this.email = '',
    this.phoneNumber = '',
    this.dateOfBirth,
    this.isBusinessRegistration = false,
    this.businessName,
    Address? address,
  }) : address = address ?? Address();
  
  /// Convert to map for Firestore storage
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'isBusinessRegistration': isBusinessRegistration,
      'businessName': businessName,
      'address': address.toMap(),
    };
  }
  
  /// Create from Firestore document
  factory RegistrationForm.fromMap(Map<String, dynamic> map) {
    return RegistrationForm(
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      dateOfBirth: map['dateOfBirth'] != null 
          ? DateTime.parse(map['dateOfBirth']) 
          : null,
      isBusinessRegistration: map['isBusinessRegistration'] ?? false,
      businessName: map['businessName'],
      address: Address.fromMap(map['address'] ?? {}),
    );
  }
  
  /// Create a copy with updated fields
  RegistrationForm copyWith({
    String? fullName,
    String? email,
    String? phoneNumber,
    DateTime? dateOfBirth,
    bool? isBusinessRegistration,
    String? businessName,
    Address? address,
  }) {
    return RegistrationForm(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      isBusinessRegistration: isBusinessRegistration ?? this.isBusinessRegistration,
      businessName: businessName ?? this.businessName,
      address: address ?? this.address,
    );
  }
  
  /// Calculate age from date of birth
  int? getAge() {
    if (dateOfBirth == null) return null;
    final today = DateTime.now();
    int age = today.year - dateOfBirth!.year;
    if (today.month < dateOfBirth!.month ||
        (today.month == dateOfBirth!.month && today.day < dateOfBirth!.day)) {
      age--;
    }
    return age;
  }
  
  /// Check if user is 18 or older
  bool isAdult() {
    final age = getAge();
    return age != null && age >= 18;
  }
}
