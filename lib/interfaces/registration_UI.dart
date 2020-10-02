import 'package:flutter/material.dart';
import 'dart:io';
import '../logic/registration.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:image_picker/image_picker.dart';

//textfield widget
class TextForm extends StatefulWidget {
  @override
  _TextFormState createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  final picker = ImagePicker();
  var age = 18;
  String name;
  List genderOptions = ["Male", "Female"];
  String gender;
  PickedFile imageFile;
  pickImageFromGallery(ImageSource source) {
    setState(() async {
      imageFile = await picker.getImage(source: ImageSource.gallery);
    });
  }

  //showIMagefunction
  Widget showImage() {
    return FutureBuilder<File>(
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (true) {
          return CircleAvatar(
            radius: 85.0,
            child: CircleAvatar(
              //padding: const EdgeInsets.all(8.0),
              backgroundColor: Colors.blue,
              backgroundImage: NetworkImage(
                  'https://m.media-amazon.com/images/M/MV5BOThhZTkxMWMtY2UyYS00MTdlLTk1ZmMtZWQ0OWFkZjE2YTA1XkEyXkFqcGdeQXVyMjU0ODI4MzY@._V1_UX172_CR0,0,172,256_AL_.jpg'),
              radius: 84,
            ),
          );
        } else if (snapshot.error != null) {
          return const Text(
            "Error Picking the Image.",
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            "No Image was picked.",
            textAlign: TextAlign.center,
          );
        }
      },
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
              IconButton(
                icon: Icon(Icons.add_circle),
                onPressed: () {
                  pickImageFromGallery(ImageSource.gallery);
                },
              )
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
            registeredUserFireStore(name, age, gender),
            uploadProfilePicture(imageFile)
          },
        )
      ],
    )));
  }
}
