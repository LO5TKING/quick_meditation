import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicPlayer extends StatefulWidget {
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  AudioPlayer _audioPlayer = AudioPlayer();
  double _currentSliderValue = 0;
  bool _isPlaying = false;
  Duration duration = Duration.zero;
  List<String> _musicFiles = [
    "396_music.mp3",
    "417_music.mp3",
    "528_music.mp3",
    "639_music.mp3",
    "741_music.mp3",
    "852_music.mp3",
    "963_music.mp3",
  ];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeAudio();
  }

  void _initializeAudio() async {
    await _audioPlayer.setSourceUrl(_musicFiles[_currentIndex]);
    _audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player'),
      ),
      body: ListView.builder(
        itemCount: _musicFiles.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_musicFiles[index]),
            trailing: IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: () {
                if (_isPlaying) {
                  _audioPlayer.pause();
                } else {
                  _audioPlayer.play(AssetSource(_musicFiles[index]));
                }
                setState(() {
                  _isPlaying = !_isPlaying;
                });
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Slider(
                value: _currentSliderValue,
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                    Duration newPosition = Duration(milliseconds: value.toInt());
                    _audioPlayer.seek(newPosition);
                  });
                },
                min: 0.0,
                max: duration?.inMilliseconds?.toDouble() ?? 1.0,
              ),
              Text(
                '${(duration.inSeconds / 60).floor()}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }
}
