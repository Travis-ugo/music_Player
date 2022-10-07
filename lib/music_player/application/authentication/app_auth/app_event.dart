part of 'app_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStateChangeEvent extends AuthEvent {
  final User user;

  const AuthStateChangeEvent(this.user);
  @override
  List<Object> get props => [user];
}

class LogOutRequestEvent extends AuthEvent {}
