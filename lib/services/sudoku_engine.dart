import 'dart:math';
import '../models/sudoku_game.dart';

class SudokuEngine {
  static const int size = 9;

SudokuGame generateGame(String difficulty) {
  List<List<int>> solution = generateSolvedBoard();




  List<List<int>> puzzle =
      solution.map((row) => List<int>.from(row)).toList();

  int cellsToRemove;

  switch (difficulty.toLowerCase()) {
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

  removeCells(puzzle, cellsToRemove);

  return SudokuGame(
    puzzle: puzzle,
    solution: solution,
  );
}  



List<List<int>> generatePuzzle(String difficulty) {
  return generateGame(difficulty).puzzle;
}
  List<List<int>> generateSolvedBoard() {
    List<List<int>> board =
        List.generate(size, (_) => List.filled(size, 0));

    fillBoard(board);

    return board;
  }

  void removeCells(
  List<List<int>> board,
  int cellsToRemove,
) {
  final random = Random();

  while (cellsToRemove > 0) {
    int row = random.nextInt(9);
    int col = random.nextInt(9);

    if (board[row][col] != 0) {
      board[row][col] = 0;
      cellsToRemove--;
    }
  }
}



  bool fillBoard(List<List<int>> board) {
    for (int row = 0; row < size; row++) {
      for (int col = 0; col < size; col++) {
        if (board[row][col] == 0) {
          List<int> numbers =
              List.generate(9, (index) => index + 1);

          numbers.shuffle(Random());

          for (int number in numbers) {
            if (isValid(board, row, col, number)) {
              board[row][col] = number;

              if (fillBoard(board)) {
                return true;
              }

              board[row][col] = 0;
            }
          }

          return false;
        }
      }
    }

    return true;
  }

  bool isValid(
    List<List<int>> board,
    int row,
    int col,
    int number,
  ) {
    for (int i = 0; i < 9; i++) {
      if (board[row][i] == number) return false;
      if (board[i][col] == number) return false;
    }


    bool isCorrectMove(
  List<List<int>> solution,
  int row,
  int col,
  int value,
) {
  return solution[row][col] == value;
}

bool isPuzzleSolved(
  List<List<int>> board,
  List<List<int>> solution,
) {
  for (int row = 0; row < 9; row++) {
    for (int col = 0; col < 9; col++) {
      if (board[row][col] != solution[row][col]) {
        return false;
      }
    }
  }

  return true;
}

    int startRow = row - row % 3;
    int startCol = col - col % 3;

    for (int r = startRow; r < startRow + 3; r++) {
      for (int c = startCol; c < startCol + 3; c++) {
        if (board[r][c] == number) {
          return false;
        }
      }
    }

    return true;
  }
}