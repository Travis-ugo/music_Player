import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:music_player/music_player/domain/authentication/auth.dart';
import 'package:music_player/music_player/infrastructure/authentication/auth_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository authRepository;
  SignupBloc({required this.authRepository}) : super(const SignupState()) {
    on<EmailChangedEvent>(_onEmailChangedEvent);
    on<PasswordChanged>(_onPasswordChanged);
    on<ConfirmedPasswordEvent>(_onConfirmedPasswordEvent);
    on<GoogleSignUpEvent>(_onGoogleSignUpEvent);
    on<FormSubmittedEvent>(_onFormSubmittedEvent);
  }

  void _onEmailChangedEvent(
      EmailChangedEvent event, Emitter<SignupState> emit) {
    final email = EmailAddress.dirty(event.value);

    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.password,
        state.confirmedPassword,
      ]),
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<SignupState> emit) {
    final password = Password.dirty(event.value);

    emit(state.copyWith(
      password: password,
      status: Formz.validate([
        password,
        state.email,
        state.confirmedPassword,
      ]),
    ));
  }

  void _onConfirmedPasswordEvent(
      ConfirmedPasswordEvent event, Emitter<SignupState> emit) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: event.value,
    );

    emit(state.copyWith(
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        confirmedPassword,
        state.email,
        state.password,
      ]),
    ));
  }

  void _onGoogleSignUpEvent(
      GoogleSignUpEvent event, Emitter<SignupState> emit) {
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
      FormSubmittedEvent event, Emitter<SignupState> emit) {
    if (!state.status.isInvalid) return;

    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      authRepository.signUpWithEmailAndPassword(
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
