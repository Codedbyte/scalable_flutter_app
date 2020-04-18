import 'package:scalable_flutter_app/locator.dart';
import 'package:scalable_flutter_app/models/usermodel.dart';
import 'package:scalable_flutter_app/services/data/abstracts/databaseservice.dart';
import 'package:scalable_flutter_app/services/data/remotedata/firestoredatabase.dart';

class FireStoreDatabaseModel{
  final FireStoreDatabase _fireStoreDatabase = locator<DatabaseService>();

  void startFireStoreDatabase(id){
    _fireStoreDatabase.startFireStore(id);
  }

  Future addUpdateUser(UserModel userModel) async {
    await _fireStoreDatabase.addUpdateUser(userModel);
  }
  Future removeUser() async {
    await _fireStoreDatabase.removeUser();
  }
  Stream<UserModel> userStream(){
    return _fireStoreDatabase.userStream();
  }


}

