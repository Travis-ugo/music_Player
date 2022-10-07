import 'package:dartz/dartz.dart';
import 'package:music_player/music_player/domain/authentication/auth_failures/google_failures.dart';
import 'package:music_player/music_player/domain/authentication/auth_failures/logout_failure.dart';
import 'package:music_player/music_player/domain/authentication/auth_failures/signin_failures.dart';
import 'package:music_player/music_player/domain/authentication/auth_failures/signup_failures.dart';
import 'package:music_player/music_player/domain/authentication/user/user.dart';

abstract class IAuthFacade {
  final Stream<User> user;
  IAuthFacade(this.user);

  Future<Either<SignUpFailures, Unit>> signUpWithEmailAndPassword(
      {required String email, required String password});

  Future<Either<SignInFailures, Unit>> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<Either<GoogleFailure, Unit>> googleAuth();

  Future<Either<LogOutFailure, Unit>> logOutAuth();
}
