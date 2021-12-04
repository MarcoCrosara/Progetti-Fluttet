import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePageStopwatch extends StatefulWidget {
  const HomePageStopwatch({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageStopwatchState();
  }
}

class _HomePageStopwatchState extends State<HomePageStopwatch> {
  bool flag = true;
  Stream<int>? timerStream;
  StreamSubscription<int>? timerSubscription;
  String h = '00';
  String m = '00';
  String s = '00';
  bool start = false;
  bool stop = false;
  String buttonName = "Start";
  MaterialColor _color = Colors.blue;

  Stream<int>? stopWatchStream() {
    StreamController<int>? streamController;
    Timer? timer;
    Duration timerInterval = Duration(seconds: 1);
    int counter = 0;

    void stopTimer() {
      if (timer != null) {
        timer!.cancel();
        timer = null;
        counter = 0;
        streamController!.close();
      }
    }

    void tick(_) {
      if (start == true) {
        counter++;
        streamController!.add(counter);
      } else {
        //counter += 0;
      }
      if (!flag) {
        stopTimer();
      }
    }

    void startTimer() {
      timer = Timer.periodic(timerInterval, tick);
    }

    streamController = StreamController<int>(
      onListen: startTimer,
      onCancel: stopTimer,
      onResume: startTimer,
      onPause: stopTimer,
    );

    return streamController.stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Text("$h:$m:$s",
                      style: const TextStyle(
                        fontSize: 70,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Table(
                    children: [
                      TableRow(children: [
                        ElevatedButton(
                          onPressed: _choosingFunction,
                          child: Text(buttonName),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            primary: _color,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            textStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 10, height: 0),
                        ElevatedButton(
                          onPressed: _stopFunction,
                          child: const Text("Reset"),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            primary: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            textStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ])
                    ],
                  ),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _startFunction() {
    if (start == false && stop == false) {
      start = true;
      timerStream = stopWatchStream();
      timerSubscription = timerStream!.listen((int newTick) {
        setState(() {
          h = ((newTick / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
          m = ((newTick / 60) % 60).floor().toString().padLeft(2, '0');
          s = (newTick % 60).floor().toString().padLeft(2, '0');
          buttonName = "Pause";
          _color = Colors.red;
        });
      });
    }
  }

  void _pauseFunction() {
    setState(() {
      if (start == true) {
        start = false;
        stop = true;
      }
      buttonName = "Resume";
      _color = Colors.blue;
    });
  }

  void _resumeFunction() {
    setState(() {
      if (stop == true) {
        start = true;
        stop = false;
      }
      buttonName = "Pause";
      _color = Colors.red;
    });
  }

  void _stopFunction() {
    timerSubscription!.cancel();
    timerStream = null;
    start = false;
    stop = false;
    setState(() {
      h = '00';
      m = '00';
      s = '00';
      buttonName = "Start";
      _color = Colors.blue;
    });
  }

  void _choosingFunction() {
    if (buttonName == "Start") {
      _startFunction();
    } else if (buttonName == "Pause") {
      _pauseFunction();
    } else if (buttonName == "Resume") {
      _resumeFunction();
    }
  }
}
