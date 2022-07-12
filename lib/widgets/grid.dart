import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:soundpool/soundpool.dart';

class grid extends StatefulWidget {
  grid(
      {Key? key,
      required this.numbers,
      required this.onClick,
      required this.noOfmoves,
      required this.playtype,
      required this.animation,
      required this.one,
      required this.mute})
      : super(key: key);

  var numbers = [];

  Function onClick;
  int noOfmoves = 0;
  int playtype;
  bool mute ;
  GlobalKey one = GlobalKey();
  bool animation = true;
  @override
  State<grid> createState() => _gridState();
}

class _gridState extends State<grid> {
  Soundpool pool = Soundpool(streamType: StreamType.notification);
  late int soundId;

  tilesound() async {
    soundId = await rootBundle
        .load("assets/sounds/slide_3.wav")
        .then((ByteData soundData) {
      return pool.load(soundData);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tilesound();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 1.1,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 16,
              width: MediaQuery.of(context).size.width / 2,
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/move_bg.png",
                    height: MediaQuery.of(context).size.height / 16,
                    width: MediaQuery.of(context).size.width / 2,
                    fit: BoxFit.fill,
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Moves ${widget.noOfmoves}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Showcase(
            key: widget.one,
            disposeOnTap: false,
            overlayColor: Colors.transparent,
            onTargetClick: () {},
            radius: BorderRadius.circular(20),
            description: '',
            showcaseBackgroundColor: Colors.transparent,
            child: Align(
              alignment: Alignment.center,
              child: Card(
                elevation: 10,
                color: Colors.transparent,
                child: Container(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(42),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/puzzle_bg.png')),
                      borderRadius: BorderRadius.circular(8)),
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(8),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: widget.playtype,
                      ),
                      itemCount: widget.numbers.length,
                      itemBuilder: (context, index) {
                        return widget.numbers[index] != 0
                            ? GestureDetector(
                                onPanUpdate: (details) async {
                                  widget.onClick(index);
                                  if(widget.mute==false){
                                  int streamId = await pool.play(soundId);}
                                },
                                child: widget.animation
                                    ? DelayedDisplay(
                                        delay: Duration(
                                            milliseconds:
                                                int.parse('${index}00')),
                                        slidingBeginOffset: Offset(-5, 0),
                                        child: Tile(index),
                                      )
                                    : Tile(index))
                            : const SizedBox.shrink();
                      }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Card Tile(int index) {
    return Card(
      color: Colors.transparent,
      elevation: 10,
      child: Container(
        //height: 20,
        //width: 20,
        decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(image: AssetImage('assets/images/tile.png')),
            borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: FittedBox(
                child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(widget.numbers[index].toString(),
              style: TextStyle(
                  color: Color(0xff5D4632),
                  fontSize: 50,
                  fontFamily: 'woodfont',
                  fontWeight: FontWeight.bold)),
        ))),
      ),
    );
  }
}
