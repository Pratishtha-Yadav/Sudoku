class GameStatsService {
  int gamesPlayed = 0;
  int gamesWon = 0;

  void recordWin() {
    gamesPlayed++;
    gamesWon++;
  }

  void recordLoss() {
    gamesPlayed++;
  }

  double get winRate {
    if (gamesPlayed == 0) return 0;
    return (gamesWon / gamesPlayed) * 100;
  }
}