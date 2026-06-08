class SudokuCellModel {
  int value;
  bool isFixed;
  bool isSelected;
  bool isCorrect;
  bool isWrong;

  SudokuCellModel({
    required this.value,
    required this.isFixed,
    this.isSelected = false,
    this.isCorrect = false,
    this.isWrong = false,
  });
}