import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String? userName;
  final String? emailAddress;
  final String? photo;

  const User({
    required this.uid,
    this.userName,
    this.emailAddress,
    this.photo,
  });
  @override
  List<Object?> get props => [
        uid,
        userName,
        emailAddress,
        photo,
      ];

  static const empty = User(uid: '');
  bool get userIsEmpty => this == User.empty;
  bool get userIsNotEmpty => this != User.empty;
}
