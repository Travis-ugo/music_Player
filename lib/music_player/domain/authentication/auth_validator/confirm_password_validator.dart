import 'package:music_player/music_player/domain/authentication/auth.dart';

class ConfirmedPassword
    extends FormzInput<String, ConfirmPassWordValidatorError> {
  final String password;

  const ConfirmedPassword.pure({this.password = ''}) : super.pure('');

  const ConfirmedPassword.dirty({String value = '', required this.password})
      : super.dirty(value);

  @override
  ConfirmPassWordValidatorError? validator(String? value) {
    return password == value ? null : ConfirmPassWordValidatorError.invalid;
  }
}
