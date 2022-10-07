class SignUpFailures implements Exception {
  const SignUpFailures([this.message = 'an unknown error has occurred']);
  final String message;

  factory SignUpFailures.authFailures(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpFailures(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignUpFailures('user disabled, contact support for help');

      case 'email-already-in-use':
        return const SignUpFailures(
          'An account already exists with this email',
        );
      case 'operation-not-allowed':
        return const SignUpFailures(
          'Operation is not allowed.  Please contact support.',
        );

      case 'weak-password':
        return const SignUpFailures(
          'password too weak, enter a stronger password',
        );
      default:
        return const SignUpFailures();
    }
  }
}
