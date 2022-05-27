import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AppUser {
  String username;
  String name;
  String email;
  String password;
  String phoneNumber;
  int followers;
  int following;
  String bio;
  Timestamp accountCreated;
  String url;
  String profileDP;
  AppUser({
    @required this.username,
    @required this.name,
    @required this.email,
    @required this.password,
    @required this.phoneNumber,
    @required this.followers,
    @required this.following,
    @required this.bio,
    @required this.accountCreated,
    @required this.url,
    @required this.profileDP,
  });
  

  AppUser copyWith({
    String username,
    String name,
    String email,
    String password,
    String phoneNumber,
    int followers,
    int following,
    String bio,
    Timestamp accountCreated,
    String url,
    String profileDP,
  }) {
    return AppUser(
      username: username ?? this.username,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      bio: bio ?? this.bio,
      accountCreated: accountCreated ?? this.accountCreated,
      url: url ?? this.url,
      profileDP: profileDP ?? this.profileDP,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'followers': followers,
      'following': following,
      'bio': bio,
      'accountCreated': accountCreated,
      'url': url,
      'profileDP': profileDP,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      username: map['username'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      phoneNumber: map['phoneNumber'],
      followers: map['followers'],
      following: map['following'],
      bio: map['bio'],
      accountCreated: map['accountCreated'],
      url: map['url'],
      profileDP: map['profileDP'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) => AppUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(username: $username, name: $name, email: $email, password: $password, phoneNumber: $phoneNumber, followers: $followers, following: $following, bio: $bio, accountCreated: $accountCreated, url: $url, profileDP: $profileDP)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AppUser &&
      other.username == username &&
      other.name == name &&
      other.email == email &&
      other.password == password &&
      other.phoneNumber == phoneNumber &&
      other.followers == followers &&
      other.following == following &&
      other.bio == bio &&
      other.accountCreated == accountCreated &&
      other.url == url &&
      other.profileDP == profileDP;
  }

  @override
  int get hashCode {
    return username.hashCode ^
      name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      phoneNumber.hashCode ^
      followers.hashCode ^
      following.hashCode ^
      bio.hashCode ^
      accountCreated.hashCode ^
      url.hashCode ^
      profileDP.hashCode;
  }
}
