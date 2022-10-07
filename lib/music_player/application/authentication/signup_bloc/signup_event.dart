// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class EmailChangedEvent extends SignupEvent {
  final String value;
  const EmailChangedEvent({
    required this.value,
  });
  @override
  List<Object> get props => [value];
}

class PasswordChanged extends SignupEvent {
  final String value;

  const PasswordChanged({
    required this.value,
  });
  @override
  List<Object> get props => [value];
}

class ConfirmedPasswordEvent extends SignupEvent {
  final String value;

  const ConfirmedPasswordEvent({
    required this.value,
  });
  @override
  List<Object> get props => [value];
}

class GoogleSignUpEvent extends SignupEvent {}

class FormSubmittedEvent extends SignupEvent {}
