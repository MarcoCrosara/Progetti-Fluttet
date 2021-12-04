import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePageTimer extends StatefulWidget {
  const HomePageTimer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageTimerState();
  }
}

class _HomePageTimerState extends State<HomePageTimer> {

  bool flag = true;
  bool _isButtonActive = true;
  Stream<int>? timerStream;
  StreamSubscription<int>? timerSubscription;
  String h = '00';
  String m = '00';
  String s = '00';
  bool start = false;
  bool stop = false;
  String buttonName = "Start";
  MaterialColor _colorButton = Colors.blue;
  Color _colorTimer = Colors.black;
  int counter = 0;
  bool _add = false;
  bool _notify = false;

  Stream<int>? stopWatchStream() {
    _valueCounter();
    StreamController<int>? streamController;
    Timer? timer;
    Duration timerInterval = Duration(seconds: 1);

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
        if (_add == false) {
          if (counter > 0) {
            counter--;
            streamController!.add(counter);
            _add = false;
          } else if (counter <= 0) {
            _add = true;
          }
        } else if (_add == true) {
          if (_notify == false) {
            _showDialogWindow();
            _notify = true;
          }
          counter++;
          streamController!.add(counter);
        }
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
              flex: 2,
              child: Container(
                color: Colors.white,
                child: null,
              )
            ),
            Expanded(
              
              flex: 1,
              child: Container(
                width: 280,
                color: Colors.white,
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Table(
                    children: [
                      TableRow(children: [
                        ElevatedButton(
                          onPressed: _isButtonActive
                          ? () {
                            setState(() {
                              int temp = int.parse(h);
                              temp++;
                              if (temp < 10) {
                                h = "0$temp";
                              } else {
                                h = "$temp";
                              }

                              if (h == "100") {
                                h = "00";
                              }
                            });
                          }
                          : null,
                          child: Icon(Icons.expand_less_rounded),
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
                        SizedBox(width: 10, height: 0),
                        ElevatedButton(
                          onPressed: _isButtonActive
                          ? () {
                            setState(() {
                              int temp = int.parse(m);
                              temp++;
                              if (temp < 10) {
                                m = "0$temp";
                              } else {
                                m = "$temp";
                              }

                              if (m == "60") {
                                m = "00";
                                int temp = int.parse(h);
                                temp++;
                                if (temp < 10) {
                                  h = "0$temp";
                                } else {
                                  h = "$temp";
                                }
                              }
                            });
                          }
                          : null,
                          child: Icon(Icons.expand_less_rounded),
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
                        SizedBox(width: 10, height: 0),
                        ElevatedButton(
                          onPressed: _isButtonActive
                          ? () {
                            setState(() {
                              int temp = int.parse(s);
                              temp++;
                              if (temp < 10) {
                                s = "0$temp";
                              } else {
                                s = "$temp";
                              }

                              if (s == "60") {
                                s = "00";
                                int temp = int.parse(m);
                                temp++;
                                if (temp < 10) {
                                  m = "0$temp";
                                } else {
                                  m = "$temp";
                                }

                                if (m == "60") {
                                  m = "00";
                                  int temp = int.parse(h);
                                  temp++;
                                  if (temp < 10) {
                                    h = "0$temp";
                                  } else {
                                    h = "$temp";
                                  }
                                }
                              }
                            });
                          }
                          : null,
                          child: Icon(Icons.expand_less_rounded),
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
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Text(_timerValue(),
                      style: TextStyle(
                        fontSize: 70,
                        color: _colorTimer,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: 280,
                color: Colors.white,
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Table(
                    children: [
                      TableRow(children: [
                        ElevatedButton(
                          onPressed: _isButtonActive 
                            ? () {
                              setState(() {
                                if (h != "00") {
                                  int temp = int.parse(h);
                                  temp--;
                                  if (temp < 10) {
                                    h = "0$temp";
                                  } else {
                                    h = "$temp";
                                  }
                                }
                              });
                            }
                            : null,
                          child: Icon(Icons.expand_more_rounded),
                          
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
                        SizedBox(width: 10, height: 0),
                        ElevatedButton(
                          onPressed: _isButtonActive 
                            ? () {
                              setState(() {
                                if (m != "00") {
                                  int temp = int.parse(m);
                                  temp--;
                                  if (temp < 10) {
                                    m = "0$temp";
                                  } else {
                                    m = "$temp";
                                  }
                                }
                              });
                            }
                            : null,
                          child: Icon(Icons.expand_more_rounded),
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
                        SizedBox(width: 10, height: 0),
                        ElevatedButton(
                          onPressed: _isButtonActive 
                            ? () {
                              setState(() {
                                if (s != "00") {
                                  int temp = int.parse(s);
                                  temp--;
                                  if (temp < 10) {
                                    s = "0$temp";
                                  } else {
                                    s = "$temp";
                                  }
                                }
                              });
                            }
                            : null,
                          child: Icon(Icons.expand_more_rounded),
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
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                child: null,
              )
            ),
            Expanded(
              flex: 2,
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
                            primary: _colorButton,
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
    _valueCounter();
    if (start == false && stop == false) {
      start = true;
      timerStream = stopWatchStream();
      timerSubscription = timerStream!.listen((int newTick) {
        setState(() {
          h = ((newTick / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
          m = ((newTick / 60) % 60).floor().toString().padLeft(2, '0');
          s = (newTick % 60).floor().toString().padLeft(2, '0');
          buttonName = "Pause";
          _colorButton = Colors.red;
          _isButtonActive = false;
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
      _colorButton = Colors.blue;
    });
  }

  void _resumeFunction() {
    setState(() {
      if (stop == true) {
        start = true;
        stop = false;
      }
      buttonName = "Pause";
      _colorButton = Colors.red;
    });
  }

  void _stopFunction() {
    timerSubscription!.cancel();
    timerStream = null;
    start = false;
    setState(() {
      h = '00';
      m = '00';
      s = '00';
      buttonName = "Start";
      _colorButton = Colors.blue;
      _add = false;
      _notify = false;
      _isButtonActive = true;
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

  String _timerValue() {
    String time_txt = "$h:$m:$s";
    setState(() {
      if (_add == true) {
        time_txt = "- $h:$m:$s";
        _colorTimer = Colors.red;
      } else if (_add == false) {
        time_txt = "$h:$m:$s";
        _colorTimer = Colors.black;
      }
    });
    return time_txt;
  }

  void _valueCounter() {
    setState(() {
      counter = (int.parse(h)*3600) + (int.parse(m)*60) + (int.parse(s));
    });
  }

  void _showDialogWindow() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: const Text('Time out!'),
              //content: Text('Ha vinto: ' + winner),
              actions: [
                TextButton(
                  onPressed: () =>
                      [Navigator.of(context).pop()],
                  child: const Text('Continue')
                ),
                TextButton(
                  onPressed: () =>
                      [Navigator.of(context).pop(), _stopFunction()],
                  child: const Text('Reset')
                ),
              ],
            ));
  }
}
