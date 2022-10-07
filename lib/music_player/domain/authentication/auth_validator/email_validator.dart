import 'package:music_player/music_player/domain/authentication/auth.dart';

class EmailAddress extends FormzInput<String, EmailValidatorError> {
  const EmailAddress.pure() : super.pure('');

  const EmailAddress.dirty([super.value = '']) : super.dirty();

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  EmailValidatorError? validator(String? value) {
    return _emailRegExp.hasMatch(value ?? '')
        ? null
        : EmailValidatorError.invalid;
  }
}
