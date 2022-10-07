// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'signup_bloc.dart';

class SignupState extends Equatable {
  final EmailAddress email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;
  final String? errorMessage;

  const SignupState({
    this.email = const EmailAddress.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  SignupState copyWith({
    EmailAddress? email,
    Password? password,
    FormzStatus? status,
    String? errorMessage,
    ConfirmedPassword? confirmedPassword,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
    );
  }

  @override
  List<Object> get props => [email, password, confirmedPassword, status];
}
