import 'package:flutter/material.dart';
import 'package:sudoku_test/models/sudoku_cell_model.dart';

import 'dart:async';
import '../../services/sudoku_engine.dart';
import 'package:sudoku_test/models/move.dart';
import '../../models/move.dart';

class GameScreen extends StatefulWidget {
  final String difficulty;

  const GameScreen({
    super.key,
    required this.difficulty,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int selectedRow = -1;
  int selectedCol = -1;
  
  

  List<SudokuCellModel> board = [];

  List<Move> moveHistory = [];

  final SudokuEngine engine = SudokuEngine();
  late List<List<int>> solutionBoard;
  Timer? timer;
  int secondsElapsed = 0;
  
  bool isPaused = false;

  


  void togglePause() {
  if (isPaused) {
    startTimer();
  } else {
    timer?.cancel();
  }

  setState(() {
    isPaused = !isPaused;
  });
}

  @override
void initState() {
  super.initState();
  loadPuzzle();
  startTimer();
}

void startTimer() {
  timer = Timer.periodic(
    const Duration(seconds: 1),
    (_) {
      setState(() {
        secondsElapsed++;
      });
    },
  );
}

String get formattedTime {
  final minutes = secondsElapsed ~/ 60;
  final seconds = secondsElapsed % 60;

  return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
}

void loadPuzzle() {
  solutionBoard = engine.generateSolvedBoard();

  List<List<int>> puzzle =
      solutionBoard.map((row) => List<int>.from(row)).toList();

  int cellsToRemove;

  switch (widget.difficulty.toLowerCase()) {
    case 'easy':
      cellsToRemove = 35;
      break;

    case 'medium':
      cellsToRemove = 45;
      break;

    case 'hard':
      cellsToRemove = 55;
      break;

    case 'expert':
      cellsToRemove = 60;
      break;

    default:
      cellsToRemove = 45;
  }

  engine.removeCells(puzzle, cellsToRemove);

  board.clear();

  for (int row = 0; row < 9; row++) {
    for (int col = 0; col < 9; col++) {
      board.add(
  SudokuCellModel(
    value: puzzle[row][col],
    isFixed: puzzle[row][col] != 0,
    isCorrect: false,
    isWrong: false,
  ),
);;
    }
  }
}




@override
void dispose() {
  timer?.cancel();
  super.dispose();

}


void checkWin() {
  for (int row = 0; row < 9; row++) {
    for (int col = 0; col < 9; col++) {
      final index = row * 9 + col;

      if (board[index].value !=
          solutionBoard[row][col]) {
        return;
      }
    }
  }

  timer?.cancel();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: const Text("🏆 Puzzle Complete"),
      content: Text(
        "Time: $formattedTime",
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: const Text("Back"),
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
  widget.difficulty,
  style: const TextStyle(color: Colors.white),
),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            // Timer Row
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      formattedTime,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
   
  ],
),

                Row(
                  children: [
                    GestureDetector(
  onTap: togglePause,
  child: Icon(
    isPaused
        ? Icons.play_arrow
        : Icons.pause,
    color: Colors.white,
  ),
),
                    
                  ],
                )
              ],
            ),

            const SizedBox(height: 10),

          // Sudoku Board
Expanded(
  child: Center(
    child: AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF15152B),
          borderRadius: BorderRadius.circular(20),
        ),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 81,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 9,
          ),
          itemBuilder: (context, index) {
            final row = index ~/ 9;
            final col = index % 9;

                    bool isSelected =
            selectedRow == row &&
            selectedCol == col;

        bool isSameRow =
            selectedRow == row;

        bool isSameCol =
            selectedCol == col;

            return GestureDetector(
  onTap: () {
    setState(() {
      selectedRow = row;
      selectedCol = col;
    });
  },

  child: Container(
    margin: const EdgeInsets.all(1),

    decoration: BoxDecoration(
      color: isSelected
          ? const Color.fromARGB(255, 171, 171, 244)
          : (isSameRow || isSameCol)
              ? const Color(0xFFEDE7F6)
              : Colors.white,

      boxShadow: isSelected
          ? [
              BoxShadow(
                color: Colors.deepPurple.withOpacity(0.6),
                blurRadius: 12,
                spreadRadius: 2,
              ),
            ]
          : [],

      border: Border(
        top: BorderSide(
          color: Colors.black,
          width: row % 3 == 0 ? 2 : 0.5,
        ),
        left: BorderSide(
          color: Colors.black,
          width: col % 3 == 0 ? 2 : 0.5,
        ),
        right: BorderSide(
          color: Colors.black,
          width: col == 8 ? 2 : 0.5,
        ),
        bottom: BorderSide(
          color: Colors.black,
          width: row == 8 ? 2 : 0.5,
        ),
      ),
    ),

    child: Center(
                child: Text(
                  board[index].value == 0
                      ? ""
                      : board[index].value.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                   color: board[index].isFixed
    ? const Color.fromARGB(255, 132, 89, 242)
    : board[index].isWrong
        ? Colors.red
        : board[index].isCorrect
            ? Colors.green
            : const Color(0xFF2196F3),
                  ),
                ),
              ),
            ),
          );
        },// itemBuilder
      ),
      ),
    ),
  ),
),
  

        const SizedBox(height: 10),

        const SizedBox(height: 12),

Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [

    IconButton(
      onPressed: () {
  if (moveHistory.isEmpty) return;

  final lastMove = moveHistory.removeLast();

  setState(() {
    board[lastMove.index].value =
        lastMove.previousValue;

    board[lastMove.index].isCorrect = false;
    board[lastMove.index].isWrong = false;
  });
},
      icon: const Icon(
        Icons.undo,
        color: Colors.white,
      ),
    ),

    IconButton(
      onPressed: () {
        if (selectedRow == -1 || selectedCol == -1) {
          return;
        }

        final cellIndex =
            selectedRow * 9 + selectedCol;

        if (!board[cellIndex].isFixed) {
          setState(() {

  moveHistory.add(
    Move(
      index: cellIndex,
      previousValue: board[cellIndex].value,
    ),
  );

  board[cellIndex].value = 0;

  board[cellIndex].isCorrect = false;
  board[cellIndex].isWrong = false;
});
        }
      },
      icon: const Icon(
        Icons.backspace_outlined,
        color: Colors.white,
      ),
    ),

      IconButton(
  onPressed: () {},
  icon: const Icon(
    Icons.edit_note,
    color: Colors.white,
  ),
),
    IconButton(
  onPressed: togglePause,
  icon: Icon(
    isPaused ? Icons.play_arrow : Icons.pause,
    color: Colors.white,
  ),
),
  ],
),  

           // Number Pad
SizedBox(
  height: 60,
  child: Row(
    children: List.generate(
      9,
      (index) => Expanded(
  child: GestureDetector(
    onTap: () {
  if (selectedRow == -1 || selectedCol == -1) return;

  final cellIndex = selectedRow * 9 + selectedCol;

  if (!board[cellIndex].isFixed) {
    final correctValue =
        solutionBoard[selectedRow][selectedCol];

    final enteredValue = index + 1;

    setState(() {

      moveHistory.add(
  Move(
    index: cellIndex,
    previousValue: board[cellIndex].value,
  ),
);
  board[cellIndex].value = enteredValue;

  final correctValue =
      solutionBoard[selectedRow][selectedCol];

  board[cellIndex].isCorrect =
      enteredValue == correctValue;

  board[cellIndex].isWrong =
      enteredValue != correctValue;

  moveHistory.add(
  Move(
    index: cellIndex,
    previousValue: board[cellIndex].value,
  ),
);
    
      
      board[cellIndex].value = enteredValue;
});
checkWin();

  } },


    child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
  color: const Color(0xFF1A1A35),
  borderRadius: BorderRadius.circular(20),
  boxShadow: [
    BoxShadow(
      color: const Color.fromARGB(255, 129, 104, 173).withOpacity(0.35),
      blurRadius: 20,
      spreadRadius: 2,
    ),
  ],
),
          child: Center(
            child: Text(
              "${index + 1}",
            
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    ),
  ),
),
)
          ],
        ),
      ),
    );  
  }
}     
