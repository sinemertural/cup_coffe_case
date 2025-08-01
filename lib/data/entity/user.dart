import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String uid;
  final String email;
  final String displayName;
  final String role;
  final DateTime createdAt;

  User({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.role,
    required this.createdAt});

  factory User.fromJson(Map<String , dynamic>json , String key){
    return User(
        uid: key,
        email: json["email"] as String? ?? "",
        displayName: json["displayName"] as String? ?? "",
        role: json["role"] as String? ?? "user",
        createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String ,dynamic> toJson() {
    return{
      'uid' : uid,
      'email' : email,
      'displayName' : displayName,
      'role' : role,
      'createdAt': Timestamp.fromDate(createdAt),
    };
}
  bool get isAdmin => role == 'admin';
}