import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scalable_flutter_app/models/usermodel.dart';
import 'package:scalable_flutter_app/services/data/abstracts/authenticationservice.dart';

class FirebaseAuthentication implements AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserModel> currentUser() async {
    final FirebaseUser _user = await _firebaseAuth.currentUser();
    return UserModel.fromFirebaseAuth(_user);
  }

  @override
  Future<UserModel> createUserWithEmailAndPassword(String username, String email, String password) async {
    final AuthResult authResult = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    return UserModel.fromFirebaseAuth(authResult.user);
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(String email, String password) async {
    final AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return UserModel.fromFirebaseAuth(result.user);
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final AuthResult authResult = await _firebaseAuth.signInWithCredential(GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));
        return UserModel.fromFirebaseAuth(authResult.user);
      } else {
        throw PlatformException(
            code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
            message: 'Missing Google Auth Token');
      }
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Stream<FirebaseUser> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged;

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signOut() async{
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
