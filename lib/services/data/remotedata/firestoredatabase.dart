import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scalable_flutter_app/models/usermodel.dart';
import 'package:scalable_flutter_app/services/data/abstracts/databaseservice.dart';
import 'package:scalable_flutter_app/services/data/remotedata/paths.dart';

class FireStoreDatabase implements DatabaseService {
  CollectionReference _userInformationReference;
  CollectionReference _userDetailsReference;
  String _userId;
  void startFireStore(String userId){
     _userId = userId;
    _userInformationReference = Firestore.instance.collection(userInformationCollection);
    _userDetailsReference =  _userInformationReference.document(_userId).collection(userDetailCollection);
  }

  @override
  Future<void> addUpdateUser(UserModel user) async{
    try {
      await _userDetailsReference.document(userDocument).setData(user.toJson());
    } catch (e) {
      print(e.message);
    }
  }

  @override
  Future<UserModel> getUser() async{
    try{
      var user =  await _userDetailsReference.document(userDocument).get();
      return UserModel.fromFireStore(user);
    }catch (e) {
      print(e.message);
    }
  }

  @override
  Future<void> removeUser() async{
    try {
      await _userInformationReference.document(_userId).delete();
    } catch (e) {
      print(e.message);
    }
  }

  @override
  Stream<UserModel> userStream() {
    return _userDetailsReference.document(userDocument).snapshots()
        .map((doc) => UserModel.fromFireStore(doc));
  }


}
