import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_meditation/MeditationPlay.dart';
import 'package:quick_meditation/music.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> meditationQuotes = [
    "\"Meditation is the tongue of the soul and the language of our spirit.\" \n~Jeremy Taylor",
    "\"The thing about meditation is: You become more and more you.\" \n~ David Lynch",
    "\"Meditation is the dissolution of thoughts in eternal awareness or pure consciousness without objectification, knowing without thinking, merging finitude in infinity.\" \n~ Voltaire",
    "\"Meditation is a way for nourishing and blossoming the divinity within you.\" \n~ Amit Ray",
    "\"The more regularly and the more deeply you meditate, the sooner you will find yourself acting always from a center of peace.\" \n~ J. Donald Walters",
    "\"Meditation brings wisdom; lack of meditation leaves ignorance. Know well what leads you forward and what holds you back, and choose the path that leads to wisdom.\" \n~ Buddha",
    "\"Meditation is the secret of all growth in spiritual life and knowledge.\" \n~ James Allen",
    "\"When meditation is mastered, the mind is unwavering like the flame of a lamp in a windless place.\" \n~ Bhagavad Gita",
    "\"Silence is the language of God; all else is poor translation.\" \n~ Rumi",
    "\"Meditation is the art of focusing 100% of your attention in one area. The practice comes with a myriad of well\npublicized health benefits including increased concentration, decreased anxiety, and a general feeling of happiness.\" \n~ Jiddu Krishnamurti",
    "\"The soul loves to meditate, for in contact with the Spirit lies its greatest joy.\" \n~ Paramahansa Yogananda",
    "\"Meditation is not a means to an end. It is both the means and the end.\" \n~ Jiddu Krishnamurti",
    "\"Meditation is the discovery that the point of life is always arrived at in the immediate moment.\" \n~ Alan Watts",
    "\"Meditation is the dissolution of thoughts in Eternal awareness or Pure consciousness.\" \n~ Swami Sivananda",
    "\"Meditation is the key to the inner kingdom.\" \n~ Frederick Lenz",
    "\"Meditation is not a withdrawal from life. Meditation is a process of understanding oneself.\" \n~ Jiddu Krishnamurti",
    "\"In meditation, you can have many things. Thoughts, images, sensations. They are just like clouds passing through the sky.\" \n~ Thich Nhat Hanh",
    "\"Meditation is the action of silence.\" \n~ Krishnamurti",
    "\"Meditation is the tongue of the soul and the language of our spirit.\" \n~ Jeremy Taylor",
    "\"Through meditation and by giving full attention to one thing at a time, we can learn to direct attention where we choose.\" \n~ Eknath Easwaran",
  ];

  Random random = Random();
  int minIndex = 0;
  int maxIndex = 20;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black54,
        body: Stack(
            alignment: Alignment.topCenter,
            children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/forest.gif',
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20),
                height: MediaQuery.of(context).size.height*0.10,
                child: Center(
                  child: Text("Quick Meditation",style: GoogleFonts.courgette(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),),
                ),
              ),
              Spacer(),
              Center(
                child:Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Card(
                    elevation: 0,
                    color: Colors.green.withOpacity(0.00),
                    child: Text(meditationQuotes[random.nextInt(20)],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.courgette(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: OutlinedButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MeditationPlay()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 0.8, color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Let's Meditate".toUpperCase(),
                        style: GoogleFonts.courgette(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
            ],
          ),
        ]),
      ),
    );
  }
}
