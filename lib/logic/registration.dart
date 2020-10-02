import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:path/path.dart';
//import '../databases/user_info.dart';

final firestoreInstance = Firestore.instance;
//question about this scope of instance
// this logic is only called if shared pref value for firstime is true.
//firebase instance initiated.
void registeredUserFireStore(name, age, sex) {
  firestoreInstance.collection("Users").add({
    'name': name,
    'age': age,
    'sex': sex,
    //'photo': photo // you can't handle the photos.
  }).then((id) async* {
    //id is the unique document id that firestore will generate ,
    SharedPreferences userInfo = await SharedPreferences.getInstance();
    await userInfo.setString('name', name);
    await userInfo.setInt('age', age);
    await userInfo.setString('sex', sex);
    //await userInfo.setString('photo', photo);
    await userInfo.setString('id', id.documentID);
    print(id.documentID);
    //we are going to identify unique users based on this id.
  });
}

Future uploadProfilePicture(pp) async {
  String fileName = basename(pp.path);
  StorageReference fireBaseStorageRef =
      FirebaseStorage.instance.ref().child(fileName);
  StorageUploadTask uploadTask = fireBaseStorageRef.putFile(pp);
  StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
}

//RegisterUSEr.
//firestore data upload stream.

// Generate a v1 (time-based) id
// NewUserInfo user = NewUserInfo();
