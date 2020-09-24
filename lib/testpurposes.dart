// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   final PageController userProfilePhoto = PageController();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: Scaffold(body: Feed()));
//   }
// }

// class Feed extends StatefulWidget {
//   _FeedState createState() => _FeedState();
// }

// class _FeedState extends State<Feed> {
//   final Firestore db = Firestore.instance;
//   final PageController userProfilePhoto = PageController();
//   Stream slides;
//   String activeTag = 'not_favorite';

//   int currentPage = 0;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: slides,
//         initialData: [],
//         builder: (context, AsyncSnapshot snap) {
//           List slideList = snap.data.toList();
//           return PageView.builder(
//             controller: userProfilePhoto,
//             itemCount: slideList.length + 1,
//             itemBuilder: (context, int currentIdx) {
//               bool active = currentIdx == currentPage;
//               return _buildStoryPage(slideList[currentIdx - 1], active);
//             },
//           );
//         });
//   }

//   // ignore: missing_return, unused_element
//   Stream _queryDb({String tag = 'not_favorite'}) {
//     //the Tag really is geolocation in our case.
//     //The query
//     Query query = db.collection('profiles').where('tags', arrayContains: tag);

//     slides =
//         query.snapshots().map((list) => list.documents.map((doc) => doc.data));

//     setState(() {
//       activeTag = tag;
//     });
//   }

//   _buildStoryPage(Map data, bool active) {
//     //This is unecessary
//     //final double blur = active ? 30:0;
//     //final double offset = active ? 20:0;
//     //final double top = active ? 100:200;

//     return AnimatedContainer(
//       duration: Duration(milliseconds: 500),
//       curve: Curves.easeInOutCubic,
//       margin: EdgeInsets.only(),
//       decoration: BoxDecoration(
//           image: DecorationImage(
//               fit: BoxFit.cover, image: NetworkImage(data['img']))),
//     );
//   }
// }
