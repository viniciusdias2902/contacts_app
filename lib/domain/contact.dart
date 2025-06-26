class Contact {
  final String id;
  final String name;
  final String avatar;
  final String phoneNumber;
  final String email;
  final String cityName;

  Contact({
    required this.id,
    required this.name,
    required this.avatar,
    required this.phoneNumber,
    required this.email,
    required this.cityName,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      cityName: json['cityName'],
    );
  }
}
