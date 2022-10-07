part of 'app_bloc.dart';

enum AuthStatus { unauthenticated, authenticated }

class AuthState extends Equatable {
  const AuthState._({this.user = User.empty, required this.status});

  const AuthState.authenticated(User user)
      : this._(status: AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  final User user;
  final AuthStatus status;

  @override
  List<Object> get props => [user, status];
}
