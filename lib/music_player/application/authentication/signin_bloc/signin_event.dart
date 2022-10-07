part of 'signin_bloc.dart';

abstract class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object> get props => [];
}

class EmailChangedEvent extends SigninEvent {
  final String value;
  const EmailChangedEvent({
    required this.value,
  });
  @override
  List<Object> get props => [value];
}

class PasswordChanged extends SigninEvent {
  final String value;

  const PasswordChanged({
    required this.value,
  });
  @override
  List<Object> get props => [value];
}

class GoogleSignUpEvent extends SigninEvent {}

class FormSubmittedEvent extends SigninEvent {}
