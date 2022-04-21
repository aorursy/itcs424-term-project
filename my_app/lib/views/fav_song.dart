import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:acr_cloud_sdk_example/fav_song_model.dart';

class FavSongPage extends StatefulWidget {
  @override
  _FavSongPageState createState() => _FavSongPageState();
}

class _FavSongPageState extends State<FavSongPage> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    String userEmail = "aor@gmail.com";
    final _usersStream = FirebaseFirestore.instance
        .collection('users')
        .withConverter<FavSong>(
          fromFirestore: (snapshots, _) => FavSong.fromJson(snapshots.data()!),
          toFirestore: (favSongs, _) => favSongs.toJson(),
        );

    return Scaffold(
      appBar: AppBar(title: Text("Favorite Songs")),
      body: StreamBuilder<QuerySnapshot<FavSong>>(
        stream: _usersStream.snapshots(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          final userFavSongs = snapshot.requireData;

          return Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: userFavSongs.size,
                  itemBuilder: (context, index) {
                    final favList = userFavSongs.docs[index].data();
                    return songDetail(favList);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget songDetail(FavSong favSong) {
    // favSong.favSongs.map((x) {
    //   var temp = Text(
    //     x.map(
    //       (y) => Text(y),
    //     ),
    //   );
    // });
    final temp = favSong.favSongs[0]["title"];
    print(temp);

    return Row(
      children: [],
    );
  }
}
