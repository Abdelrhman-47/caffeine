class UserData {
  final String name;
  final String email;
  final String? imageUrl;

  UserData({required this.name, required this.email, this.imageUrl});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'],
      email: json['email'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'image_url': imageUrl,
    };
  }
  @override
  String toString() {
    return 'UserData(name: $name, email: $email)';
  }

}