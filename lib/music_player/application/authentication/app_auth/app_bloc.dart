import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:music_player/music_player/infrastructure/authentication/auth_repository.dart';

import '../../../domain/authentication/user/user.dart';

part 'app_event.dart';
part 'app_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  late final StreamSubscription<User> _userSubscription;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(
          authRepository.currentUser.userIsNotEmpty
              ? AuthState.authenticated(authRepository.currentUser)
              : const AuthState.unauthenticated(),
        ) {
    on<AuthStateChangeEvent>(_onAuthStateChanged);
    on<LogOutRequestEvent>(_onLogOutRequestEvent);

    _userSubscription = _authRepository.user.listen(
      (user) => add(
        AuthStateChangeEvent(user),
      ),
    );
  }

  void _onAuthStateChanged(
      AuthStateChangeEvent event, Emitter<AuthState> emit) {
    emit(
      event.user.userIsNotEmpty
          ? AuthState.authenticated(event.user)
          : const AuthState.unauthenticated(),
    );
  }

  void _onLogOutRequestEvent(
      LogOutRequestEvent event, Emitter<AuthState> emit) {
    unawaited(_authRepository.logOutAuth());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
