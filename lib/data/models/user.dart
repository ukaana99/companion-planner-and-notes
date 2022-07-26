import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'user.g.dart';

@immutable
@JsonSerializable()
class User extends Equatable {
  final String? id;
  final String? email;
  final String? displayName;
  final String? photoUrl;

  const User({
    this.id,
    this.email = '',
    this.displayName = '',
    this.photoUrl = '',
  });

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromRawJson(String str) => User.fromJson(jsonDecode(str));

  factory User.fromFire(DocumentSnapshot snapshot) {
    final json = snapshot.data() as Map<String, dynamic>;
    json['id'] = snapshot.id;
    return User.fromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);

  String toRawJson() => jsonEncode(toJson());

  User copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
  }) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        displayName: displayName ?? this.displayName,
        photoUrl: photoUrl ?? this.photoUrl,
      );

  @override
  List<Object?> get props => [id, email, displayName, photoUrl];
}
