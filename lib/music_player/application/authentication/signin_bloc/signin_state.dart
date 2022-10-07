part of 'signin_bloc.dart';

class SigninState extends Equatable {
  final EmailAddress email;
  final Password password;
  final FormzStatus status;
  final String? errorMessage;

  const SigninState({
    this.email = const EmailAddress.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  SigninState copyWith({
    EmailAddress? email,
    Password? password,
    FormzStatus? status,
    String? errorMessage,
  }) {
    return SigninState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [email, password, status];
}
