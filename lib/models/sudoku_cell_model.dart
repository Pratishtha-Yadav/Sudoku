class SudokuCellModel {
  int value;
  bool isFixed;
  bool isSelected;

  SudokuCellModel({
    required this.value,
    required this.isFixed,
    this.isSelected = false,
  });
}