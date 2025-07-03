import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: XOHome());
  }
}

class XOHome extends StatefulWidget {
  const XOHome({super.key});

  @override
  State<XOHome> createState() => _XOHomeState();
}

class _XOHomeState extends State<XOHome> {
  int playerXScore = 0;
  int playerOScore = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              SizedBox(height: 50),
              HeaderSection(x: playerXScore, o: playerOScore),
              XOBox(
                onPressed: (turn) {
                  if (turn == 'X wins') {
                    setState(() {
                      playerXScore++;
                    });
                  } else if (turn == 'O wins') {
                    setState(() {
                      playerOScore++;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  final int x;
  final int o;
  const HeaderSection({super.key, required this.x, required this.o});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Tic Tac Teo',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Text(
          'Player X =$x',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          'Player X = $o',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class XOBox extends StatefulWidget {
  final void Function(String turn) onPressed;
  const XOBox({super.key, required this.onPressed});

  @override
  State<XOBox> createState() => _XOBoxState();
}

class _XOBoxState extends State<XOBox> {
  String checkWineer() {
    //handle rows
    if (boxes[0] == boxes[1] && boxes[0] == boxes[2] && boxes[0] != '') {
      return '${boxes[0]} wins';
    }
    if (boxes[3] == boxes[4] && boxes[3] == boxes[5] && boxes[3] != '') {
      return '${boxes[3]} wins';
    }
    if (boxes[6] == boxes[7] && boxes[6] == boxes[8] && boxes[6] != '') {
      return '${boxes[6]} wins';
    }
    //handle columns
    if (boxes[0] == boxes[3] && boxes[0] == boxes[6] && boxes[0] != '') {
      return '${boxes[0]} wins';
    }
    if (boxes[1] == boxes[4] && boxes[1] == boxes[7] && boxes[1] != '') {
      return '${boxes[1]} wins';
    }
    if (boxes[2] == boxes[5] && boxes[2] == boxes[8] && boxes[2] != '') {
      return '${boxes[2]} wins';
    }
    //handle diagonals
    if (boxes[0] == boxes[4] && boxes[0] == boxes[8] && boxes[0] != '') {
      return '${boxes[0]} wins';
    }
    if (boxes[2] == boxes[4] && boxes[2] == boxes[6] && boxes[2] != '') {
      return '${boxes[2]} wins';
    }
    return '';
  }

  String turn = 'X';
  List<String> boxes = List.filled(9, '');
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                if (boxes[index] == '') {
                  boxes[index] = turn;
                  turn = turn == 'X' ? 'O' : 'X';
                }
              });
              String winner = checkWineer();
              if (winner != '') {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Game Over'),
                      content: Text(winner),
                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              boxes = List.filled(9, '');
                            });
                            Navigator.pop(context);
                          },
                          child: Text('Play Again'),
                        ),
                      ],
                    );
                  },
                );
                widget.onPressed(winner);
              }
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              color: Colors.orange,
              child: Center(
                child: Text(
                  boxes[index],
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
        itemCount: 9,
      ),
    );
  }
}
