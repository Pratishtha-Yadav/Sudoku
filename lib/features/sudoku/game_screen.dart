import 'package:flutter/material.dart';
import 'package:sudoku_test/models/sudoku_cell_model.dart';
import '../../services/sudoku_generator.dart';

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

  @override
void initState() {
  super.initState();
  loadPuzzle();
}

void loadPuzzle() {
  final puzzle = SudokuGenerator.getMediumPuzzle();

  board.clear();

  for (int row = 0; row < 9; row++) {
    for (int col = 0; col < 9; col++) {
      board.add(
        SudokuCellModel(
          value: puzzle[row][col],
          isFixed: puzzle[row][col] != 0,
        ),
      );
    }
  }
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "0:00",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),

                Row(
                  children: [
                    Icon(Icons.lightbulb_outline,
                        color: Colors.white),
                    SizedBox(width: 12),
                    Icon(Icons.pause,
                        color: Colors.white),
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

            return GestureDetector(
            onTap: () {
            setState(() {
              selectedRow = index ~/ 9;
              selectedCol = index % 9;
                  }
                  );
              },

  child: Container(
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
  color: (selectedRow == index ~/ 9 &&
          selectedCol == index % 9)
      ? const Color(0xFFFFD54F)
      : Colors.white,
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
                        ? Colors.black
                        : Colors.blue,
                  ),
                ),
              ),
            ),
            );
          },
        ),
      ),
    ),
  ),
),
            const SizedBox(height: 10),

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
        setState(() {
          board[cellIndex].value = index + 1;
        });
      }
    },
    child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: const Color(0xFF15152B),
            borderRadius: BorderRadius.circular(10),
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
