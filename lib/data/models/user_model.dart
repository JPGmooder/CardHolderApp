import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class BankCards {
  String cvc;
  String cardNumber;
  String owner;
  DateTime exDate;
  String imagePath;
  BankCards({
    required this.cvc,
    required this.cardNumber,
    required this.owner,
    required this.exDate,
    required this.imagePath,
  });

  BankCards copyWith({
    String? cvc,
    String? cardNumber,
    String? owner,
    DateTime? exDate,
    String? imagePath,
  }) {
    return BankCards(
      cvc: cvc ?? this.cvc,
      cardNumber: cardNumber ?? this.cardNumber,
      owner: owner ?? this.owner,
      exDate: exDate ?? this.exDate,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cvc': cvc,
      'cardNumber': cardNumber,
      'owner': owner,
      'exDate': exDate.millisecondsSinceEpoch,
      'imagePath': imagePath,
    };
  }

  factory BankCards.fromMap(Map<String, dynamic> map) {
    return BankCards(
      cvc: map['cvc'],
      cardNumber: map['cardNumber'],
      owner: map['owner'],
      exDate: DateTime.now(), //TODO Пределать
      imagePath: map['imagePath'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BankCards.fromJson(String source) => BankCards.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BankCards(cvc: $cvc, cardNumber: $cardNumber, owner: $owner, exDate: $exDate, imagePath: $imagePath)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BankCards &&
      other.cvc == cvc &&
      other.cardNumber == cardNumber &&
      other.owner == owner &&
      other.exDate == exDate &&
      other.imagePath == imagePath;
  }

  @override
  int get hashCode {
    return cvc.hashCode ^
      cardNumber.hashCode ^
      owner.hashCode ^
      exDate.hashCode ^
      imagePath.hashCode;
  }
}

class MarketCards {
  String name;
  String typeName;
  String image;
  String code;
  MarketCards({
    required this.name,
    required this.typeName,
    required this.image,
    required this.code,
  });

  MarketCards copyWith({
    String? name,
    String? typeName,
    String? image,
    String? code,
  }) {
    return MarketCards(
      name: name ?? this.name,
      typeName: typeName ?? this.typeName,
      image: image ?? this.image,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'typeName': typeName,
      'image': image,
      'code': code,
    };
  }

  factory MarketCards.fromMap(Map<String, dynamic> map) {
    return MarketCards(
      name: map['name'],
      typeName: map['typeName'],
      image: map['image'],
      code: map['code'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MarketCards.fromJson(String source) => MarketCards.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MarketCards(name: $name, typeName: $typeName, image: $image, code: $code)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MarketCards &&
      other.name == name &&
      other.typeName == typeName &&
      other.image == image &&
      other.code == code;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      typeName.hashCode ^
      image.hashCode ^
      code.hashCode;
  }
}

class User {
  String email;
  String id;
  String? photoUrl;
  String? serverAuthCode;
  List<BankCards>? usersBankCards;
  List<MarketCards>? usersMarkedCards;
  User({
    required this.email,
    required this.id,
    this.photoUrl,
    this.serverAuthCode,
    this.usersBankCards,
    this.usersMarkedCards,
  });

  User copyWith({
    String? email,
    String? id,
    String? photoUrl,
    String? serverAuthCode,
    List<BankCards>? usersBankCards,
    List<MarketCards>? usersMarkedCards,
  }) {
    return User(
      email: email ?? this.email,
      id: id ?? this.id,
      photoUrl: photoUrl ?? this.photoUrl,
      serverAuthCode: serverAuthCode ?? this.serverAuthCode,
      usersBankCards: usersBankCards ?? this.usersBankCards,
      usersMarkedCards: usersMarkedCards ?? this.usersMarkedCards,
    );
  }

   factory User.fromGoogleSignInAccount(GoogleSignInAccount googleAccount) {
    return User(
     email: googleAccount.email,
     id: googleAccount.id,
     serverAuthCode: googleAccount.serverAuthCode,
     photoUrl: googleAccount.photoUrl
    );
  }

  
  Map<String, dynamic> toMapForDB() {
    return {
      'usersBankCards': usersBankCards?.map((x) => x.toMap()).toList(),
      'usersMarkedCards': usersMarkedCards?.map((x) => x.toMap()).toList(),
    };
  }


  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'id': id,
      'photoUrl': photoUrl,
      'serverAuthCode': serverAuthCode,
      'usersBankCards': usersBankCards?.map((x) => x.toMap()).toList(),
      'usersMarkedCards': usersMarkedCards?.map((x) => x.toMap()).toList(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'],
      id: map['id'],
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] : null,
      serverAuthCode: map['serverAuthCode'] != null ? map['serverAuthCode'] : null,
      usersBankCards: map['usersBankCards'] != null ? List<BankCards>.from(map['usersBankCards']?.map((x) => BankCards.fromMap(x))) : null,
      usersMarkedCards: map['usersMarkedCards'] != null ? List<MarketCards>.from(map['usersMarkedCards']?.map((x) => MarketCards.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(email: $email, id: $id, photoUrl: $photoUrl, serverAuthCode: $serverAuthCode, usersBankCards: $usersBankCards, usersMarkedCards: $usersMarkedCards)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.email == email &&
      other.id == id &&
      other.photoUrl == photoUrl &&
      other.serverAuthCode == serverAuthCode &&
      listEquals(other.usersBankCards, usersBankCards) &&
      listEquals(other.usersMarkedCards, usersMarkedCards);
  }

  @override
  int get hashCode {
    return email.hashCode ^
      id.hashCode ^
      photoUrl.hashCode ^
      serverAuthCode.hashCode ^
      usersBankCards.hashCode ^
      usersMarkedCards.hashCode;
  }
}
