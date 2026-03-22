class Address {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String streetAddress;
  final String city;
  final String state;
  final String zipCode;
  final String? landmark;
  final bool isDefault;

  Address({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.streetAddress,
    required this.city,
    required this.state,
    required this.zipCode,
    this.landmark,
    this.isDefault = false,
  });

  String get fullAddress {
    String address = "$streetAddress, $city, $state $zipCode";
    if (landmark != null && landmark!.isNotEmpty) {
      address += " (Near $landmark)";
    }
    return address;
  }

  Address copyWith({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? streetAddress,
    String? city,
    String? state,
    String? zipCode,
    String? landmark,
    bool? isDefault,
  }) {
    return Address(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      streetAddress: streetAddress ?? this.streetAddress,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      landmark: landmark ?? this.landmark,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}

