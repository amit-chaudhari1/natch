import 'package:flutter/material.dart';
import 'dart:io';
import '../logic/registration.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:shared_preferences/shared_preferences.dart'; //why?

//textfield widget
class TextForm extends StatefulWidget {
  @override
  _TextFormState createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  var age = 18;
  String name;
  List genderOptions = ["Male", "Female"];
  String gender;
  File _image; //upload this to firebasestorage.
  String _imagePath;

  Future _getImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    if (image != null) {
      var cropped = await ImageCropper.cropImage(
        sourcePath: image.path,
        maxHeight: 100,
        maxWidth: 100,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        cropStyle: CropStyle.circle,
        compressQuality: 100,
      );
      this.setState(() {
        _image = cropped;
      });
      saveImage(_image.path);
    }
  }

  void saveImage(path) async {
    SharedPreferences saveimage = await SharedPreferences.getInstance();
    saveimage.setString('imagepath', path);
  }

  Widget showImage() {
    return GestureDetector(
      onTap: _getImage,
      child: Container(
        //padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 5.0,
          ),
          shape: BoxShape.circle,
        ),

        child: _imagePath != null
            ? CircleAvatar(
                backgroundImage: FileImage(File(_imagePath)),
                radius: 60,
              )
            : CircleAvatar(
                backgroundImage: _image != null
                    ? FileImage(_image)
                    : AssetImage(
                        'assets/images/Splash.jpg'), // Generic user image
                backgroundColor: Colors.blue[200],
                radius: 60,
              ),
      ),
    );
  }

  //Added function that generates Male female buttons.
  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: genderOptions[btnValue],
          groupValue: gender,
          onChanged: (value) {
            setState(() {
              print(value);
              gender = value;
            });
          },
        ),
        Text(title)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
            child: Column(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              showImage(),
            ],
          ),
        ),

        //image circle
        TextField(
            decoration: InputDecoration(
              labelText: "Name",
              fillColor: Colors.black,
              focusedBorder: OutlineInputBorder(
                  //enter error validation.
                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0)),
            ),
            onChanged: (newvalue) => setState(() => name = newvalue)),
        new NumberPicker.integer(
            initialValue: age,
            minValue: 9,
            maxValue: 90,
            onChanged: (newValue) => setState(() => age = newValue)),
        Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              addRadioButton(0, 'Male'),
              addRadioButton(1, 'Female'),
            ],
          ),
        ),
        FlatButton(
          child: const Text("Register"),
          onPressed: () => {
            registeredUserFireStore(name, age, gender, _image),
          },
        )
      ],
    )));
  }
}
