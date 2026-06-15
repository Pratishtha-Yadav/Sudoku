class GameStats {
  int gamesPlayed;
  int gamesWon;
  int bestTime;

  GameStats({
    this.gamesPlayed = 0,
    this.gamesWon = 0,
    this.bestTime = 0,
  });

  double get winRate {
    if (gamesPlayed == 0) return 0;
    return (gamesWon / gamesPlayed) * 100;
  }
}