import 'package:flutter/material.dart';
import 'package:music_player/api/api.dart';
import 'package:music_player/model/response/song_response.dart';
import 'package:music_player/model/response/token.dart';

class SongsPage extends StatefulWidget {
  String accessToken;

  SongsPage({super.key, required this.accessToken});

  @override
  State<SongsPage> createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  late Future<List<SongResponse>?> songs;
  late Api api;

  @override
  void initState() {
    api = Api();
    songs = api.getSongs(widget.accessToken);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Songs 🎵', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: myBody(),
    );
  }

  Widget myBody() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 250, 250, 250),
      ),
      child: Column(
        children: [
          Container(),
          FutureBuilder(
            future: songs,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data != null) {
                  return Expanded(child: renderSongs(snapshot.data!));
                } else {
                  return Center(child: Text('Something went error'));
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }

  Widget renderSong(SongResponse song) {
    return InkWell(
      onTap: () {
        print(song.name);
      },

      child: Container(
        margin: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 5),
              width: 100,
              height: 100,
              decoration: BoxDecoration(),
              child: Image.network(song.imagePath),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(song.singer, style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget renderSongs(List<SongResponse> songs) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: songs.length,
      itemBuilder: (context, index) {
        return renderSong(songs[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 5);
      },
    );
  }
}
