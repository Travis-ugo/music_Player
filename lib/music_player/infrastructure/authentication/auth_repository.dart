import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import '../../domain/authentication/auth.dart';

class AuthRepository implements IAuthFacade {
  AuthRepository(
      {firebase_auth.FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  var currentUser = User.empty; // tyr off
  @override
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      currentUser = user; // tyr off
      return user;
    });
  }

  @override
  Future<Either<SignUpFailures, Unit>> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(SignUpFailures.authFailures(e.code));
    } catch (_) {
      return left(const SignUpFailures());
    }
  }

  @override
  Future<Either<SignInFailures, Unit>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(SignInFailures.failures(e.code));
    } catch (_) {
      return left(const SignInFailures());
    }
  }

  @override
  Future<Either<GoogleFailure, Unit>> googleAuth() async {
    try {
      late final firebase_auth.AuthCredential credential;
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(GoogleFailure.failures(e.code));
    } catch (_) {
      return left(const GoogleFailure());
    }
  }

  @override
  Future<Either<LogOutFailure, Unit>> logOutAuth() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
      return right(unit);
    } catch (_) {
      return left(const LogOutFailure());
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(
      uid: uid,
      userName: displayName,
      emailAddress: email,
      photo: photoURL,
    );
  }
}
