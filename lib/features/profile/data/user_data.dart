
import 'package:hive_ce/hive.dart';
part 'user_data.g.dart';
@HiveType(typeId: 2)
class UserData {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String email;
  @HiveField(2)
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