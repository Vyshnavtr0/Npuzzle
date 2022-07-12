import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:puzzle/widgets/grid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:soundpool/soundpool.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class board extends StatefulWidget {
  late final String playtype;
  board({Key? key, required this.playtype}) : super(key: key);

  @override
  State<board> createState() => _boardState();
}

class _boardState extends State<board> {
  var timer = "0";
  bool animation = true;
  bool mute = false;
  late SharedPreferences prefs;
  late ConfettiController _controllerwin;
  var numbers = [1, 2, 3, 4, 5, 6, 7, 8, 0];
  var numtype = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
  ];
  int noOfmoves = 0;
  int griddata = 3;
  int griddata2 = 9;
  int score = 0;
  late int soundId;
  late int soundId1;
  late int soundId2;
  late int soundId3;
  late int soundId4;
  late int soundId5;
  late int soundId6;
  InterstitialAd? _interstitialAd;
  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-2428207631771118/9582367976',
    size: AdSize.banner,
    request: AdRequest(nonPersonalizedAds: false),
    listener: BannerAdListener(),
  );
  GlobalKey _one = GlobalKey();
  Soundpool pool = Soundpool(streamType: StreamType.notification);
  tilesound() async {
    soundId = await rootBundle
        .load("assets/sounds/success.wav")
        .then((ByteData soundData) {
      return pool.load(soundData);
    });
    soundId1 = await rootBundle
        .load("assets/sounds/entry_bg.wav")
        .then((ByteData soundData) {
      return pool.load(soundData);
    });
    soundId2 = await rootBundle
        .load("assets/sounds/shuffle.wav")
        .then((ByteData soundData) {
      return pool.load(soundData);
    });
    soundId3 = await rootBundle
        .load("assets/sounds/tiles.wav")
        .then((ByteData soundData) {
      return pool.load(soundData);
    });
    soundId4 = await rootBundle
        .load("assets/sounds/button_up.wav")
        .then((ByteData soundData) {
      return pool.load(soundData);
    });
    soundId5 = await rootBundle
        .load("assets/sounds/tiles_exit.wav")
        .then((ByteData soundData) {
      return pool.load(soundData);
    });
    soundId6 = await rootBundle
        .load("assets/sounds/bubbles.wav")
        .then((ByteData soundData) {
      return pool.load(soundData);
    });
    start();
  }

  playtype() {
    if (widget.playtype == "3") {
      setState(() {
        griddata = 3;
        griddata2 = 9;
        numtype = [
          0,
          1,
          2,
          3,
          4,
          5,
          6,
          7,
          8,
        ];
        numbers = [1, 2, 3, 4, 5, 6, 7, 8, 0];
      });
      start();
    } else if (widget.playtype == "4") {
      setState(() {
        griddata = 4;
        griddata2 = 16;
        numtype = [
          0,
          1,
          2,
          3,
          4,
          5,
          6,
          7,
          8,
          9,
          10,
          11,
          15,
          13,
          14,
          12,
        ];
        numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0];
      });
      start();
    } else if (widget.playtype == '5') {
      setState(() {
        griddata = 5;
        griddata2 = 25;
        numtype = [
          0,
          1,
          2,
          3,
          4,
          5,
          6,
          7,
          8,
          9,
          10,
          11,
          12,
          13,
          14,
          15,
          16,
          17,
          18,
          19,
          20,
          21,
          22,
          23,
          24,
        ];
        numbers = [
          1,
          2,
          3,
          4,
          5,
          6,
          7,
          8,
          9,
          10,
          11,
          12,
          13,
          14,
          15,
          16,
          17,
          18,
          19,
          20,
          21,
          22,
          23,
          24,
          0
        ];
      });
      start();
    }
    tilesound();
  }

  next() async {
    await Future.delayed(const Duration(milliseconds: 100));
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    setState(() {
      numbers = numtype;
    });
    shuffle(numbers);
    setState(() {
      noOfmoves = 0;
    });
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/1033173712',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            this._interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

  start() async {
    if (mute == false) {
      int streamId = await pool.play(soundId6);
    }
    prefs = await SharedPreferences.getInstance();
    await Future.delayed(Duration(milliseconds: griddata + 1000));
    setState(() {
      animation = false;
    });
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      numbers = numtype;
    });
    shuffle(numbers);
    setState(() {
      noOfmoves = 0;
    });
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-2428207631771118/1071867265',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            this._interstitialAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

  Future<void> shuffle(
    List<int> elements,
  ) async {
    if (mute == false) {
      pool.play(soundId5);
    }
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => ShowCaseWidget.of(context)!.startShowCase([
        _one,
      ]),
    );

    var i = 0;
    while (80 > i) {
      final _random = new Random();
      var index = elements[_random.nextInt(elements.length)];
      if (index - 1 >= 0 && elements[index - 1] == 0 && index % griddata != 0 ||
          index + 1 < griddata2 &&
              elements[index + 1] == 0 &&
              (index + 1) % griddata != 0 ||
          (index - griddata >= 0 && elements[index - griddata] == 0) ||
          (index + griddata < griddata2 && elements[index + griddata] == 0)) {
        i++;
        await Future.delayed(const Duration(milliseconds: 10));
        setState(() {
          elements[elements.indexOf(0)] = elements[index];
          elements[index] = 0;
          numbers = elements;
        });
      }
    }
    WidgetsBinding.instance
        .addPostFrameCallback((_) => ShowCaseWidget.of(context)!.dismiss());
    if (mute == false) {
      pool.play(soundId2);
    }
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  final BannerAdListener listener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),

    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerwin = ConfettiController(duration: Duration(seconds: 1));

    playtype();
    myBanner.load();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Image.asset(
          "assets/images/bg.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        WillPopScope(
          onWillPop: () {
            SystemNavigator.pop();
            return Future.value(true);
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                ShowUpAnimation(
                  //delayStart: Duration(seconds: 1),
                  animationDuration: Duration(seconds: 1),
                  curve: Curves.bounceIn,
                  direction: Direction.vertical,
                  offset: -0.5,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      "assets/images/top.png",
                      height: size.height / 6,
                      width: size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ShowUpAnimation(
                  delayStart: Duration(milliseconds: 500),
                  animationDuration: Duration(seconds: 2),
                  curve: Curves.bounceIn,
                  direction: Direction.vertical,
                  offset: -0.5,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      height: size.height / 3.5,
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/images/timer.png",
                            height: size.height / 3.9,
                            width: size.width,
                            fit: BoxFit.contain,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: size.width / 3.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: size.width / 20,
                                  ),
                                  StreamBuilder<int>(
                                    stream: _stopWatchTimer.rawTime,
                                    initialData: 0,
                                    builder: (context, snap) {
                                      final value = snap.data;
                                      final displayTime =
                                          StopWatchTimer.getDisplayTime(value!);
                                      timer = displayTime.substring(3, 10);
                                      return Column(
                                        children: <Widget>[
                                          Text(
                                            displayTime.substring(3, 10),
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                ShowUpAnimation(
                  delayStart: Duration(seconds: 0),
                  animationDuration: Duration(seconds: 1),
                  curve: Curves.bounceIn,
                  direction: Direction.vertical,
                  offset: 0.5,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: RotatedBox(
                      quarterTurns: 2,
                      child: Image.asset(
                        "assets/images/top.png",
                        height: size.height / 6,
                        width: size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: grid(
                        numbers: numbers,
                        onClick: onClick,
                        noOfmoves: noOfmoves,
                        animation: animation,
                        playtype: griddata,
                        one: _one,
                        mute: mute,
                      ),
                    )),
                ShowUpAnimation(
                  delayStart: Duration(seconds: 1),
                  animationDuration: Duration(seconds: 2),
                  curve: Curves.bounceIn,
                  direction: Direction.vertical,
                  offset: 0.5,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Image.asset(
                      "assets/images/rock.png",
                      height: size.width / 7,
                      width: size.width / 7,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ShowUpAnimation(
                  delayStart: Duration(seconds: 1),
                  animationDuration: Duration(seconds: 2),
                  curve: Curves.bounceIn,
                  direction: Direction.vertical,
                  offset: 0.5,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      "assets/images/ad_bg.png",
                      height: size.height / 7,
                      width: size.width / 1.2,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                /* DelayedDisplay(
                  delay: Duration(seconds: 2),
                  slidingBeginOffset: Offset(0, 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: (() async {
                        if(mute==false){
                        int streamId = await pool.play(soundId4);}
                      }),
                      child: Container(
                        width: size.width / 7,
                        height: size.width / 7,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage(
                                  "assets/images/chart.png",
                                ))),
                      ),
                    ),
                  ),
                ),*/
                DelayedDisplay(
                  delay: Duration(seconds: 2),
                  slidingBeginOffset: Offset(0, 0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: (() async {
                        setState(() {
                          mute = !mute;
                        });
                        if (mute == false) {
                          int streamId = await pool.play(soundId4);
                        }
                      }),
                      child: Container(
                        width: size.width / 7,
                        height: size.width / 7,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage(
                                  mute == true
                                      ? "assets/images/off.png"
                                      : "assets/images/on.png",
                                ))),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                      height: size.height / 4,
                      width: size.width,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DelayedDisplay(
                                delay: Duration(seconds: 2),
                                slidingBeginOffset: Offset(0, 0),
                                child: GestureDetector(
                                  onTap: () async {
                                    if (mute == false) {
                                      int streamId = await pool.play(soundId4);
                                    }
                                    _stopWatchTimer.onExecute
                                        .add(StopWatchExecute.stop);
                                    next();
                                  },
                                  child: Container(
                                    width: size.width / 3.5,
                                    height: size.width / 7,
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 1.0,
                                          ),
                                        ],
                                        image: DecorationImage(
                                            fit: BoxFit.contain,
                                            image: AssetImage(
                                              "assets/images/button.png",
                                            ))),
                                    child: Center(
                                      child: Text(
                                        "Shuffle",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              DelayedDisplay(
                                delay: Duration(seconds: 2),
                                slidingBeginOffset: Offset(0, 0),
                                child: GestureDetector(
                                  onTap: () async {
                                    if (mute == false) {
                                      int streamId = await pool.play(soundId4);
                                    }
                                    showMaterialModalBottomSheet(
                                        context: context,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) {
                                          return Container(
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                image: DecorationImage(
                                                    fit: BoxFit.contain,
                                                    image: AssetImage(
                                                      "assets/images/playtypebg.png",
                                                    ))),
                                            width: size.width,
                                            height: size.height / 4,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  top: 25,
                                                  left: size.width / 2 - 40,
                                                  right: 0,
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      if (mute == false) {
                                                        int streamId =
                                                            await pool
                                                                .play(soundId4);
                                                      }
                                                      await prefs.setString(
                                                          'playtype', '3');
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      board(
                                                                        playtype:
                                                                            '3',
                                                                      )));
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "3 X 3",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.brown,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 60,
                                                  left: size.width / 2 - 40,
                                                  right: 0,
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      if (mute == false) {
                                                        int streamId =
                                                            await pool
                                                                .play(soundId4);
                                                      }
                                                      await prefs.setString(
                                                          'playtype', '4');
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      board(
                                                                        playtype:
                                                                            '4',
                                                                      )));
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "4 X 4",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.brown,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 100,
                                                  left: size.width / 2 - 40,
                                                  right: 0,
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      if (mute == false) {
                                                        int streamId =
                                                            await pool
                                                                .play(soundId4);
                                                      }
                                                      await prefs.setString(
                                                          'playtype', '5');
                                                      Navigator.of(context)
                                                          .pop();
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      board(
                                                                        playtype:
                                                                            '5',
                                                                      )));
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "5 X 5",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.brown,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                    width: size.width / 3.5,
                                    height: size.width / 7,
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 1,
                                          ),
                                        ],
                                        image: DecorationImage(
                                            fit: BoxFit.contain,
                                            image: AssetImage(
                                              "assets/images/button.png",
                                            ))),
                                    child: Center(
                                      child: Text(
                                        "$griddata X $griddata",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                ),
                ShowUpAnimation(
                  delayStart: Duration(seconds: 1),
                  animationDuration: Duration(seconds: 2),
                  curve: Curves.bounceIn,
                  direction: Direction.vertical,
                  offset: 0.5,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () async {
                        if (mute == false) {
                          int streamId = await pool.play(soundId4);
                        }
                      },
                      child: Container(
                        width: size.width / 5,
                        height: size.height / 7,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: AssetImage(
                                  "assets/images/level_bg.png",
                                ))),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Image.asset(
                                  "assets/images/help.png",
                                  height: size.width / 12,
                                  width: size.width / 12,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: size.height / 12,
                    width: size.width / 1.2,
                    child: AdWidget(ad: myBanner),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: ConfettiWidget(
                    confettiController: _controllerwin,
                    shouldLoop: true,
                    blastDirection: pi / 2,
                    minimumSize: Size(1, 10),
                    maximumSize: Size(10, 20),
                    colors: [
                      Colors.green,
                      Colors.red,
                      Colors.blue,
                      Colors.yellow,
                      Colors.purple,
                      Colors.white,
                      Colors.orange,
                      Colors.indigo,
                      Colors.pink,
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: ConfettiWidget(
                    confettiController: _controllerwin,
                    shouldLoop: true,
                    blastDirection: 0,
                    minimumSize: Size(1, 10),
                    maximumSize: Size(10, 20),
                    colors: [
                      Colors.green,
                      Colors.red,
                      Colors.blue,
                      Colors.yellow,
                      Colors.purple,
                      Colors.white,
                      Colors.orange,
                      Colors.indigo,
                      Colors.pink,
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: ConfettiWidget(
                    confettiController: _controllerwin,
                    shouldLoop: true,
                    blastDirection: pi,
                    minimumSize: Size(1, 10),
                    maximumSize: Size(10, 20),
                    colors: [
                      Colors.green,
                      Colors.red,
                      Colors.blue,
                      Colors.yellow,
                      Colors.purple,
                      Colors.white,
                      Colors.orange,
                      Colors.indigo,
                      Colors.pink,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> onClick(index) async {
    if (index - 1 >= 0 && numbers[index - 1] == 0 && index % griddata != 0 ||
        index + 1 < griddata2 &&
            numbers[index + 1] == 0 &&
            (index + 1) % griddata != 0 ||
        (index - griddata >= 0 && numbers[index - griddata] == 0) ||
        (index + griddata < griddata2 && numbers[index + griddata] == 0)) {
      setState(() {
        numbers[numbers.indexOf(0)] = numbers[index];
        numbers[index] = 0;
        noOfmoves++;
      });
    }
    checkwinner();
  }

  bool isSorted(List numbersList) {
    int first = numbersList.first;
    for (int i = 1; i < numbersList.length - 1; i++) {
      int nextnumber = numbersList[i];
      if (first > nextnumber) return false;
      first = numbersList[i];
    }

    return true;
  }

  Future<void> checkwinner() async {
    // print('Winner');
    bool iswinner = false;
    bool dialogshow = false;
    iswinner = isSorted(numbers);

    if (iswinner == true) {
      if (mute == false) {
        int streamId = await pool.play(soundId);
      }
      _controllerwin.play();
      _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
      setState(() {
        score = noOfmoves > 500 ? 72 : (500 - noOfmoves);
      });
      if (dialogshow == false) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              setState(() {
                dialogshow = true;
              });
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                backgroundColor: Colors.transparent,
                //this right here
                child: Container(
                  height: MediaQuery.of(context).size.height / 1.2,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 2,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: AssetImage(
                                  "assets/images/dialog.png",
                                ))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 4.5,
                                  height:
                                      MediaQuery.of(context).size.width / 4.5,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: AssetImage(
                                            "assets/images/score.png",
                                          ))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Center(
                                      child: Text(
                                        score.toString(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 4.5,
                                  height:
                                      MediaQuery.of(context).size.width / 4.5,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: AssetImage(
                                            "assets/images/moves.png",
                                          ))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Center(
                                      child: Text(
                                        noOfmoves.toString(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Time : ${timer.toString()}",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (() async {
                          if (mute == false) {
                            int streamId = await pool.play(soundId4);
                          }
                          Navigator.of(context).pop();
                          await Future.delayed(const Duration(seconds: 1));
                          _controllerwin.stop();

                          next();
                        }),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.2,
                          height: MediaQuery.of(context).size.width / 5,
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(
                                    "assets/images/next.png",
                                  ))),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).then((value) {
          setState(() {
            dialogshow = true;
          });
        });
      }
      setState(() {
        dialogshow = true;
      });
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) =>
            print('%ad onAdShowedFullScreenContent.'),
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          print('$ad onAdDismissedFullScreenContent.');
          ad.dispose();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          print('$ad onAdFailedToShowFullScreenContent: $error');
          ad.dispose();
        },
        onAdImpression: (InterstitialAd ad) =>
            print('$ad impression occurred.'),
      );
      _interstitialAd!.show();
    }
  }
}
