import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFCE4EC),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  bool _turn = true;
  bool _win = false;
  int _boxes = 0;
  final List<String> _playerTurn = ['', '', '', '', '', '', '', '', ''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE57373),
        title: const Center(
          child: Text("Tic Tac Toe",
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w800)),
        ),
      ),
      body: Column(
        children: [_buildGrid(), _buildTurn()],
      ),
    );
  }

  Widget _buildGrid() {
    return Expanded(
      child: Center(
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  _tapped(index);
                  if (_win == false) {
                    _ia();
                  }
                },
                child: Container(
                  decoration:
                      BoxDecoration(color: Color(0xFFFCE4EC),border: Border.all(color: Colors.black)),
                  child: Center(
                    child: Text(
                      _playerTurn[index],
                      style: TextStyle(
                        color: _playerTurn[index] == 'X'
                            ? Colors.black
                            : Colors.blueAccent,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
                
              );
            }),
      ),
    );
  }

  Widget _buildTurn() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            _turn ? 'Turno di O' : 'Turno di X',
            style: const TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (_turn && _playerTurn[index] == '' && _playerTurn[index] != 'X') {
        _playerTurn[index] = 'O';
        _boxes++;
      } else if (!_turn &&
          _playerTurn[index] == '' &&
          _playerTurn[index] != 'O') {
        _playerTurn[index] = 'X';
        _boxes++;
      }
      _turn = !_turn;
      _checkTheWinner(context);
    });
  }

  void _ia() {
    setState(() {
      for (int i = 0; i < _playerTurn.length; i++) {
        if (_playerTurn[i] == '') {
          _tapped(i);
          return;
        }
      }
    });
  }

  void _checkTheWinner(BuildContext context) {
    if (_playerTurn[0] == _playerTurn[1] &&
        _playerTurn[0] == _playerTurn[2] &&
        _playerTurn[0] != '') {
      _win = true;
      showDialogWindow(_playerTurn[0]);
      print('Vincitore ' + _playerTurn[0]);
      return;
    }

    if (_playerTurn[3] == _playerTurn[4] &&
        _playerTurn[3] == _playerTurn[5] &&
        _playerTurn[3] != '') {
      _win = true;
      showDialogWindow(_playerTurn[3]);
      print('Vincitore ' + _playerTurn[3]);
      return;
    }

    if (_playerTurn[6] == _playerTurn[7] &&
        _playerTurn[6] == _playerTurn[8] &&
        _playerTurn[6] != '') {
      _win = true;
      showDialogWindow(_playerTurn[6]);
      print('Vincitore ' + _playerTurn[6]);
      return;
    }

    if (_playerTurn[0] == _playerTurn[3] &&
        _playerTurn[0] == _playerTurn[6] &&
        _playerTurn[0] != '') {
      _win = true;
      showDialogWindow(_playerTurn[0]);
      print('Vincitore ' + _playerTurn[0]);
      return;
    }

    if (_playerTurn[1] == _playerTurn[4] &&
        _playerTurn[1] == _playerTurn[7] &&
        _playerTurn[1] != '') {
      _win = true;
      showDialogWindow(_playerTurn[1]);
      print('Vincitore ' + _playerTurn[1]);
      return;
    }

    if (_playerTurn[2] == _playerTurn[5] &&
        _playerTurn[2] == _playerTurn[8] &&
        _playerTurn[2] != '') {
      _win = true;
      showDialogWindow(_playerTurn[2]);
      print('Vincitore ' + _playerTurn[2]);
      return;
    }

    if (_playerTurn[0] == _playerTurn[4] &&
        _playerTurn[0] == _playerTurn[8] &&
        _playerTurn[0] != '') {
      _win = true;
      showDialogWindow(_playerTurn[0]);
      print('Vincitore ' + _playerTurn[0]);
      return;
    }

    if (_playerTurn[2] == _playerTurn[4] &&
        _playerTurn[2] == _playerTurn[6] &&
        _playerTurn[2] != '') {
      _win = true;
      showDialogWindow(_playerTurn[2]);
      print('Vincitore ' + _playerTurn[2]);
      return;
    }

    if (_boxes == 9) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('Nessun vincitore!'),
                content: Text('Pareggio'),
                actions: [
                  TextButton(
                      onPressed: () =>
                          [Navigator.of(context).pop(), _clearBoard()],
                      child: Text('Nuova partita'))
                ],
              ));

      print('Pareggio');
    }
  }

  void showDialogWindow(String winner) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Abbiamo un vincitore!'),
              content: Text('Ha vinto: ' + winner),
              actions: [
                TextButton(
                    onPressed: () =>
                        [Navigator.of(context).pop(), _clearBoard()],
                    child: Text('Nuova partita'))
              ],
            ));
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        _playerTurn[i] = '';
      }
    });
    _boxes = 0;
    _win = false;
  }
}
