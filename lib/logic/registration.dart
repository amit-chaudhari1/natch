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
String userId;
//question about this scope of instance
// this logic is only called if shared pref value for firstime is true.
//firebase instance initiated.
registeredUserFireStore(name, age, sex, pp, ppPath) async {
  await firestoreInstance.collection("Users").add({
    'name': name,
    'age': age,
    'sex': sex,
  }).then((id) {
    // print(id.documentID);
    userId = id.documentID;
  });
  //assign shared prefences.
  SharedPreferences userInfo = await SharedPreferences.getInstance();
  await userInfo.setString('name', name);
  await userInfo.setInt('age', age);
  await userInfo.setString('sex', sex);
  await userInfo.setString('photopath', ppPath);
  await userInfo.setString('id', userId);

  StorageReference storageReference =
      FirebaseStorage().ref().child("Users/${userId}_profile_pic.png");
  StorageUploadTask uploadTask = storageReference.putFile(pp);
  StorageTaskSnapshot snapshot = await uploadTask.onComplete;
  var downloadUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
  //Add url to the user's collection.
  firestoreInstance
      .collection("Users")
      .document(userId)
      .updateData({'ProfileURL': downloadUrl});
  return snapshot.storageMetadata.path;
}
