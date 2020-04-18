import 'package:firebase_auth/firebase_auth.dart';
import 'package:scalable_flutter_app/locator.dart';
import 'package:scalable_flutter_app/models/usermodel.dart';
import 'package:scalable_flutter_app/services/data/abstracts/authenticationservice.dart';
import 'package:scalable_flutter_app/services/data/remotedata/firebaseauthentication.dart';

class FirebaseAuthenticationModel{
  final FirebaseAuthentication _firebaseAuthentication = locator<AuthenticationService>();

  Future<UserModel> currentUser() async{
    return await _firebaseAuthentication.currentUser();
  }

  Future<UserModel> createUserWithEmailAndPassword(String username, String email, String password) async{
    return await _firebaseAuthentication.createUserWithEmailAndPassword(username, email, password);
  }

  Future<UserModel> signInWithEmailAndPassword(String email, String password) async {
    return await _firebaseAuthentication.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    return await _firebaseAuthentication.signInWithGoogle();
  }

  @override
  Stream<FirebaseUser> get onAuthStateChanged => _firebaseAuthentication.onAuthStateChanged;

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuthentication.sendPasswordResetEmail(email);
  }

  @override
  Future<void> signOut() async{
   await _firebaseAuthentication.signOut();
  }

}
