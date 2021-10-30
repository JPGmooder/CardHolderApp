import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';

class User {
  String email;
  String id;
  String? photoUrl;
  String? serverAuthCode;
  User({
    required this.email,
    required this.id,
    this.photoUrl,
    this.serverAuthCode,
  });

  factory User.fromGoogleSignInAccount(GoogleSignInAccount googleAccount) {
    return User(
     email: googleAccount.email,
     id: googleAccount.id,
     serverAuthCode: googleAccount.serverAuthCode,
     photoUrl: googleAccount.photoUrl
    );
  }


  User copyWith({
    String? email,
    String? id,
    String? photoUrl,
    String? serverAuthCode,
  }) {
    return User(
      email: email ?? this.email,
      id: id ?? this.id,
      photoUrl: photoUrl ?? this.photoUrl,
      serverAuthCode: serverAuthCode ?? this.serverAuthCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'id': id,
      'photoUrl': photoUrl,
      'serverAuthCode': serverAuthCode,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'],
      id: map['id'],
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] : null,
      serverAuthCode: map['serverAuthCode'] != null ? map['serverAuthCode'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(email: $email, id: $id, photoUrl: $photoUrl, serverAuthCode: $serverAuthCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.email == email &&
      other.id == id &&
      other.photoUrl == photoUrl &&
      other.serverAuthCode == serverAuthCode;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      id.hashCode ^
      photoUrl.hashCode ^
      serverAuthCode.hashCode;
  }
}
