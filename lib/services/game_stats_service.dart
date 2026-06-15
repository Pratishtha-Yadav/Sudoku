import '../models/game_stats.dart';

class GameStatsService {
  final GameStats stats = GameStats();

  void recordWin(int completionTime) {
    stats.gamesPlayed++;
    stats.gamesWon++;

    if (stats.bestTime == 0 ||
        completionTime < stats.bestTime) {
      stats.bestTime = completionTime;
    }
  }

  void recordLoss() {
    stats.gamesPlayed++;
  }

  GameStats getStats() {
    return stats;
  }
}