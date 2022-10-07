// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:music_player/music_player/domain/authentication/auth.dart';
import 'package:music_player/music_player/infrastructure/authentication/auth_repository.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final AuthRepository authRepository;
  SigninBloc(
    this.authRepository,
  ) : super(const SigninState()) {
    on<EmailChangedEvent>(_onEmailChangedEvent);
    on<PasswordChanged>(_onPasswordChanged);
    on<GoogleSignUpEvent>(_onGoogleSignUpEvent);
    on<FormSubmittedEvent>(_onFormSubmittedEvent);
  }

  void _onEmailChangedEvent(
      EmailChangedEvent event, Emitter<SigninState> emit) {
    final email = EmailAddress.dirty(event.value);

    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.password,
      ]),
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SigninState> emit) {
    final password = Password.dirty(event.value);

    emit(state.copyWith(
      password: password,
      status: Formz.validate([
        password,
        state.email,
      ]),
    ));
  }

  void _onGoogleSignUpEvent(
      GoogleSignUpEvent event, Emitter<SigninState> emit) {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      authRepository.googleAuth();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on GoogleFailure catch (e) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        errorMessage: e.message,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
      ));
    }
  }

  void _onFormSubmittedEvent(
      FormSubmittedEvent event, Emitter<SigninState> emit) {
    if (!state.status.isInvalid) return;

    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      authRepository.signInWithEmailAndPassword(
          email: state.email.value, password: state.password.value);

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignUpFailures catch (e) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        errorMessage: e.message,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
      ));
    }
  }
}
