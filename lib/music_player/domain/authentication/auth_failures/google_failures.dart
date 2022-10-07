class GoogleFailure implements Exception {
  const GoogleFailure([this.message = 'an unknown error has occurred']);

  final String message;

  factory GoogleFailure.failures(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const GoogleFailure(
          'account exists with different credentials.',
        );
      case 'invalid-credential':
        return const GoogleFailure(
          'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const GoogleFailure(
          'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const GoogleFailure(
          'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const GoogleFailure(
          'user not found, please create an account.',
        );
      case 'wrong-password':
        return const GoogleFailure(
          'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const GoogleFailure(
          'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const GoogleFailure(
          'The credential verification ID received is invalid.',
        );
      default:
        return const GoogleFailure();
    }
  }
}
