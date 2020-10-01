import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import '../databases/user_info.dart';

final firestoreInstance = Firestore.instance;
//question about this scope of instance
// this logic is only called if shared pref value for firstime is true.
//firebase instance initiated.
void registeredUserFireStore(name, age, sex, photo) {
  firestoreInstance.collection("NewUserInfo").add({
    'name': name,
    'age': age,
    'sex': sex,
    'photo': photo // you can't handle the photos.
  }).then((id) async* {
    //id is the unique document id that firestore will generate ,
    SharedPreferences userInfo = await SharedPreferences.getInstance();
    await userInfo.setString('name', name);
    await userInfo.setInt('age', age);
    await userInfo.setString('sex', sex);
    await userInfo.setString('photo', photo);
    await userInfo.setString('id', id.documentID);
    //we are going to identify unique users based on this id.
  });
}

//RegisterUSEr.
//firestore data upload stream.

// Generate a v1 (time-based) id
// NewUserInfo user = NewUserInfo();
