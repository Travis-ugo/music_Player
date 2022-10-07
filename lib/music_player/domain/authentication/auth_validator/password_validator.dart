import 'package:music_player/music_player/domain/authentication/auth.dart';

class Password extends FormzInput<String, PassWordValidatorError> {
  const Password.pure() : super.pure('');

  const Password.dirty([super.value = '']) : super.dirty();

  static final RegExp _passwordRegExp =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  @override
  PassWordValidatorError? validator(String? value) {
    return _passwordRegExp.hasMatch(value ?? '')
        ? null
        : PassWordValidatorError.invalid;
  }
}
