import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavSongPage extends StatefulWidget {
  @override
  _FavSongPageState createState() => _FavSongPageState();
}

class _FavSongPageState extends State<FavSongPage> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    String userEmail = auth.currentUser!.email.toString();
    return Scaffold(
      appBar: AppBar(title: Text("Favorite Songs")),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(userEmail)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snapshot.data!
                  .data()!['favSongs']
                  .map<Widget>((document) => {
                        Container(
                          child: ListTile(
                            title: Text(document["title"]),
                            subtitle: Text(document["artist"]),
                          ),
                        )
                      })
                  .toList(),
            );
          }
        },
      ),
    );
  }
}
