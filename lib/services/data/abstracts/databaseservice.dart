
import 'package:scalable_flutter_app/models/usermodel.dart';

abstract class DatabaseService {
  Future<void> addUpdateUser(UserModel user);
  Future<void> removeUser();
  Future<UserModel> getUser();
  Stream<UserModel> userStream();

}