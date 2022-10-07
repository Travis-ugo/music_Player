class SignInFailures implements Exception {
  const SignInFailures([this.message = 'an unknown error has occurred']);
  final String message;

  factory SignInFailures.failures(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignInFailures(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignInFailures(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const SignInFailures(
          'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const SignInFailures(
          'Incorrect password, please try again.',
        );
      default:
        return const SignInFailures();
    }
  }
}
