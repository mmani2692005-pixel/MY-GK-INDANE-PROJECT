class NewConnection {
  final String id;
  final String fullName;
  final String phone;
  final String address;
  final String aadhaar;
  final String status;

  NewConnection({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.address,
    required this.aadhaar,
    required this.status,
  });

  factory NewConnection.fromJson(Map<String, dynamic> json) {
    return NewConnection(
      id: json['id'],
      fullName: json['full_name'],
      phone: json['phone'],
      address: json['address'],
      aadhaar: json['aadhaar_number'],
      status: json['status'],
    );
  }
}
