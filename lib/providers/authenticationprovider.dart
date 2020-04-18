import 'package:scalable_flutter_app/models/usermodel.dart';
import 'package:scalable_flutter_app/services/data/servicemodels/firebaseauthenticationmodel.dart';
import 'package:scalable_flutter_app/services/data/servicemodels/firestoredatabasemodel.dart';
import 'package:scalable_flutter_app/services/navigation/navigationservice.dart';
import 'package:scalable_flutter_app/services/navigation/routepaths.dart';

import '../locator.dart';
import 'baseprovider.dart';

class AuthenticationProvider extends BaseProviderModel {
  final FirebaseAuthenticationModel _firebaseAuthenticationModel = locator<FirebaseAuthenticationModel>();
  final FireStoreDatabaseModel _fireStoreDatabaseModel = locator<FireStoreDatabaseModel>();
  final NavigationService _navigationService = locator<NavigationService>();

  String errorMessage = '';

  void startFireStoreDatabase(UserModel userModel){
    _fireStoreDatabaseModel.startFireStoreDatabase(userModel.id);
  }

  Future<void> handleStartUpLogic() async {
    var user = await _firebaseAuthenticationModel.currentUser();
    await Future.delayed(Duration(seconds: 1));
    if (user != null) {
       startFireStoreDatabase(user);
       _navigationService.pushReplacementName(homeScreen);
    } else {
       _navigationService.pushReplacementName(signInScreen);
    }
  }

  void signIn(String email, String password) async {
    await _authenticate('signInWithEmail', null, email, password);
  }
  void signUpWithEmailAndPassword(String username, String email, String password) async {
    await _authenticate('signUpWithEmail', username, email, password);
  }
  void signInWithGoogle() async {
    await _authenticate('signInWithGoogle', null, null, null);
  }


  Future<void> _authenticate(String type, String username, String email, String password) async {
    errorMessage = '';
    setViewState(ViewState.Busy);
    try {
      //authenticating
      UserModel user;
      if (type == 'signUpWithEmail') {
        user = await _firebaseAuthenticationModel.createUserWithEmailAndPassword(username, email, password);
      } else if (type == 'signInWithEmail') {
        user = await _firebaseAuthenticationModel.signInWithEmailAndPassword(email, password);
      } else if (type == 'signInWithGoogle') {
        user = await _firebaseAuthenticationModel.signInWithGoogle();
      }
      setViewState(ViewState.Idle);
      //if authenticating is successful start database
      if (user != null) {
        startFireStoreDatabase(user);
        //if user is signing in for the first time then create a record for him/her
        if (type != 'signInWithEmail') {
          _fireStoreDatabaseModel.addUpdateUser(user);
        }
        _navigationService.pushReplacementName(homeScreen);
      } else {
        //dialog error
      }
      setViewState(ViewState.Idle);
    } catch (e) {
      setViewState(ViewState.Idle);
      errorMessage = e.message.toString();
      print(errorMessage);
    }
  }

  Future<void> recoverPassword(String email) async {
    errorMessage = '';
    setViewState(ViewState.Busy);
    try {
      await _firebaseAuthenticationModel.sendPasswordResetEmail(email);
      setViewState(ViewState.Success);
    } catch (e) {
      setViewState(ViewState.Idle);
      errorMessage = e.message.toString();
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuthenticationModel.signOut();
      switchAuthenticationScreen(signInScreen);
    } catch (e) {
      print(e.message);
    }
  }

  void switchAuthenticationScreen(String type) {
    errorMessage = '';
    setViewState(ViewState.Idle);
    type == registerScreen
        ? _navigationService.pushReplacementName(registerScreen)
        : _navigationService.pushReplacementName(signInScreen);
  }
}
