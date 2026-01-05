import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/api/api.dart';
import 'package:music_player/model/position_data.dart';
import 'package:music_player/model/response/song_response.dart';
import 'package:music_player/model/response/token.dart';
import 'package:rxdart/rxdart.dart';

class SongsPage extends StatefulWidget {
  String accessToken;

  SongsPage({super.key, required this.accessToken});

  @override
  State<SongsPage> createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  late Future<List<SongResponse>?> songs;
  late Api api;

  SongResponse? currentSong;

  late AudioPlayer audioPlayer;

  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        audioPlayer.positionStream,
        audioPlayer.bufferedPositionStream,
        audioPlayer.durationStream,
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

  @override
  void initState() {
    api = Api();
    songs = api.getSongs(widget.accessToken);

    currentSong = null;
    audioPlayer = AudioPlayer();
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
          renderCurrentSong(currentSong),
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
      onTap: () async {
        if (audioPlayer.playing) {
          await audioPlayer.stop();
        }

        await audioPlayer.dispose();
        audioPlayer = AudioPlayer();
        audioPlayer.setUrl(song.path);

        setState(() {
          currentSong = song;
        });
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

  Widget renderCurrentSong(SongResponse? song) {
    if (song == null) {
      return Center(child: Text('Chưa chọn bài hát'));
    }
    return Container(
      child: Column(
        children: [
          Image.network(song.imagePath, width: 100, height: 100),
          Text(song.name),
          Text(song.singer),
          StreamBuilder<PlayerState>(
            stream: audioPlayer.playerStateStream,
            builder: (context, snapshot) {
              final playerState = snapshot.data;
              final processingState = playerState?.processingState;
              final playing = playerState?.playing;

              if (processingState == ProcessingState.loading ||
                  processingState == ProcessingState.buffering) {
                return const CircularProgressIndicator();
              } else if (playing != true) {
                return IconButton(
                  icon: const Icon(Icons.play_arrow),
                  iconSize: 64.0,
                  onPressed: audioPlayer.play,
                );
              } else if (processingState != ProcessingState.completed) {
                return IconButton(
                  icon: const Icon(Icons.pause),
                  iconSize: 64.0,
                  onPressed: audioPlayer.pause,
                );
              } else {
                return IconButton(
                  icon: const Icon(Icons.replay),
                  iconSize: 64.0,
                  onPressed: () async {
                    await audioPlayer.pause();
                    await audioPlayer.seek(Duration.zero);
                    audioPlayer.play();
                  },
                );
              }
            },
          ),
          StreamBuilder<PositionData>(
            stream: positionDataStream,
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              final progress = positionData?.position ?? Duration.zero;
              final buffered = positionData?.bufferedPosition ?? Duration.zero;
              final total = positionData?.duration ?? Duration.zero;
              return ProgressBar(
                progress: progress,
                buffered: buffered,
                total: total,
                onSeek: (duration) async {
                  if (audioPlayer.playerState.processingState ==
                      ProcessingState.completed) {
                    await audioPlayer.pause();

                    await audioPlayer.seek(duration);
                    audioPlayer.play();
                  }
                  audioPlayer.seek(duration);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
