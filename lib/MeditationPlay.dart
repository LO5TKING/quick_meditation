import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MeditationPlay extends StatefulWidget {
  const MeditationPlay({super.key});

  @override
  State<MeditationPlay> createState() => _MeditationPlayState();
}

class _MeditationPlayState extends State<MeditationPlay> {
  bool tapped = true;
  final player = AudioPlayer();
  Map<int, Duration> positions = {};
  Map<int, Duration> durations = {};
  Map<int, bool> isPlayingStates = {};
  int currentlyPlayingIndex = -1;
  Map<int, AudioPlayer> players = {};
  List<String> imagePath = [
    'assets/396 hz.webp',
    'assets/417 hz.webp',
    'assets/528 hz.webp',
    'assets/639 hz.webp',
    'assets/741 hz.webp',
    'assets/852 hz.webp',
    'assets/963 hz.webp',
  ];

  List<bool> isRight = [false, true, false, true, false, true, false];

  @override
  void dispose() {
    players.forEach((index, player) {
      player.dispose();
    });
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Initialize positions, durations and playing states for each player
    for (int i = 0; i < imagePath.length; i++) {
      positions[i] = Duration.zero;
      durations[i] = Duration.zero;
      isPlayingStates[i] = false;
    }

    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlayingStates[currentlyPlayingIndex] = state == PlayerState.playing;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                'assets/meditation.gif',
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: ListView.separated(
                        separatorBuilder: (ctx, i) {
                          return SizedBox(
                            height: 5,
                          );
                        },
                        itemCount: imagePath.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(15)),
                            height: MediaQuery.of(context).size.height * 0.12,
                            child: isRight[index]
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                        musicCard(tapped: tapped, index: index),
                                        Image.asset(imagePath[index]),
                                      ])
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Image.asset(imagePath[index]),
                                      musicCard(tapped: tapped, index: index),
                                    ],
                                  ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget musicCard({bool? tapped, int? index}) {
    if (!players.containsKey(index)) {
      players[index!] = AudioPlayer();
      players[index]!.onPlayerStateChanged.listen((state) {
        setState(() {
          isPlayingStates[index] = state == PlayerState.playing;
        });
      });

      players[index]!.onDurationChanged.listen((newDuration) {
        setState(() {
          durations[index] = newDuration;
        });
      });

      players[index]!.onPositionChanged.listen((newPosition) {
        setState(() {
          positions[index] = newPosition;
        });
      });
    }
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(
          flex: 1,
          child: Container(
            width: double.infinity,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 1.5,
                trackShape: const RoundedRectSliderTrackShape(),
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7.0),
              ),
              child: Slider(
                activeColor: Colors.black,
                allowedInteraction: SliderInteraction.tapAndSlide,
                min: 0,
                max: durations[index!]!.inSeconds.toDouble(),
                value: positions[index]!.inSeconds.toDouble(),
                onChanged: (value) {
                  final position = Duration(seconds: value.toInt());
                  players[index]!.seek(position);
                  players[index]!.resume();
                },
              ),
            ),
          ),
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  child: IconButton(
                    icon: const Icon(
                      Icons.stop,
                      size: 20,
                    ),
                    onPressed: () {
                      players[index]!.stop();
                      setState(() {
                        isPlayingStates[index] = false;
                        positions[index] = Duration.zero;
                      });
                    },
                  ),
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  child: IconButton(
                    icon: Icon(
                      isPlayingStates[index]! ? Icons.pause : Icons.play_arrow,
                      size: 20,
                    ),
                    onPressed: () {
                      String music = '';
                      setState(() {
                        if (currentlyPlayingIndex != -1 &&
                            currentlyPlayingIndex != index) {
                          players[currentlyPlayingIndex]!.pause();
                          isPlayingStates[currentlyPlayingIndex] = false;
                        }

                        if (!isPlayingStates[index]!) {
                          currentlyPlayingIndex = index;
                          isPlayingStates[index] = true;
                          switch (index) {
                            case 0:
                              music = '396_music.mp3';
                              break;
                            case 1:
                              music = '417_music.mp3';
                              break;
                            case 2:
                              music = '528_music.mp3';
                              break;
                            case 3:
                              music = '639_music.mp3';
                              break;
                            case 4:
                              music = '741_music.mp3';
                              break;
                            case 5:
                              music = '852_music.mp3';
                              break;
                            case 6:
                              music = '963_music.mp3';
                              break;
                          }
                          players[index]!.play(AssetSource(music));
                        } else {
                          isPlayingStates[index] = false;
                          players[index]!.pause();
                          currentlyPlayingIndex = -1;
                        }
                      });
                    },
                  ),
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  child: IconButton(
                    icon: const Icon(
                      Icons.repeat_one,
                      size: 20,
                    ),
                    onPressed: () {
                      // player.stop();
                    },
                  ),
                ),
              ],
            )),
      ]),
    );
  }
}
