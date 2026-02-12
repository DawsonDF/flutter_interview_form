/// Address information model
class Address {
  String streetAddress;
  String city;
  String state;
  String zipCode;
  String country;

  Address({
    this.streetAddress = '',
    this.city = '',
    this.state = '',
    this.zipCode = '',
    this.country = 'United States',
  });

  /// Convert to map
  Map<String, dynamic> toMap() {
    return {
      'streetAddress': streetAddress,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'country': country,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      streetAddress: map['streetAddress'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      zipCode: map['zipCode'] ?? '',
      country: map['country'] ?? 'United States',
    );
  }

  /// Create a copy with updated fields
  Address copyWith({
    String? streetAddress,
    String? city,
    String? state,
    String? zipCode,
    String? country,
  }) {
    return Address(
      streetAddress: streetAddress ?? this.streetAddress,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      country: country ?? this.country,
    );
  }

  /// Format address as a single string
  String toDisplayString() {
    final parts = <String>[];
    if (streetAddress.isNotEmpty) parts.add(streetAddress);
    if (city.isNotEmpty) parts.add(city);
    if (state.isNotEmpty) parts.add(state);
    if (zipCode.isNotEmpty) parts.add(zipCode);
    if (country.isNotEmpty) parts.add(country);
    return parts.join(', ');
  }
}
