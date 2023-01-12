import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe_game/constants/colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool oTurn = true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  String resultDeclaration = '';
  static var customFontWhite = GoogleFonts.ubuntu(
    textStyle: const TextStyle(
      color: Colors.white,
      letterSpacing: 3,
      fontSize: 28,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Expanded(
              flex: 1,
              child: Text('Score Board'),
            ),
            Expanded(
              flex: 5,
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          width: 5,
                          color: MainColor.primaryColor,
                        ),
                        color: MainColor.secondaryColor,
                      ),
                      child: Center(
                        child: Text(
                          displayXO[index],
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              fontSize: 64,
                              fontWeight: FontWeight.w500,
                              color: MainColor.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                resultDeclaration,
                style: customFontWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (oTurn && displayXO[index] == '') {
        displayXO[index] = 'O';
      } else if (!oTurn && displayXO[index] == '') {
        displayXO[index] = 'X';
      }
      oTurn = !oTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[0]} Wins!';
        // matchedIndexes.addAll([0, 1, 2]);
        // stopTimer();
        // _updateScore(displayXO[0]);
      });
    }

    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[3]} Wins!';
        // matchedIndexes.addAll([3, 4, 5]);
        // stopTimer();
        // _updateScore(displayXO[3]);
      });
    }

    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[6]} Wins!';
        // matchedIndexes.addAll([6, 7, 8]);
        // stopTimer();
        // _updateScore(displayXO[6]);
      });
    }

    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[0]} Wins!';
        // matchedIndexes.addAll([0, 3, 6]);
        // stopTimer();
        // _updateScore(displayXO[0]);
      });
    }

    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[1]} Wins!';
        // matchedIndexes.addAll([1, 4, 7]);
        // stopTimer();
        // _updateScore(displayXO[1]);
      });
    }

    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[2]} Wins!';
        // matchedIndexes.addAll([2, 5, 8]);
        // stopTimer();
        // _updateScore(displayXO[2]);
      });
    }

    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[0]} Wins!';
        // matchedIndexes.addAll([0, 4, 8]);
        // stopTimer();
        // _updateScore(displayXO[0]);
      });
    }

    if (displayXO[6] == displayXO[4] &&
        displayXO[6] == displayXO[2] &&
        displayXO[6] != '') {
      setState(() {
        resultDeclaration = 'Player ${displayXO[6]} Wins!';
        // matchedIndexes.addAll([6, 4, 2]);
        // stopTimer();
        // _updateScore(displayXO[6]);
      });
    }
  }
}
