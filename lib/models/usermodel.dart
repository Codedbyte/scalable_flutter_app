import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel{
  String id;
  String username;
  String email;
  String imageUrl;

  UserModel({this.id, this.username, this.email, this.imageUrl});

  factory UserModel.fromFireStore(DocumentSnapshot snapshot){
    Map data = snapshot.data;
    return UserModel(
      id: data['id'],
      username:  data['username'],
      email: data['email'] ?? "email",
      imageUrl: data['imageUrl'] ?? "",
    );
  }

  factory UserModel.fromFirebaseAuth(FirebaseUser user){
    return UserModel(
      id: user.uid,
      username:  user.displayName ?? "username",
      email: user.email ?? "email",
      imageUrl: user.photoUrl ?? "",
    );
  }

  Map<String,dynamic> toJson(){
    return{
      "id": id,
      "username": username,
      "email": email,
      "imageUrl": imageUrl,
    };
  }
}