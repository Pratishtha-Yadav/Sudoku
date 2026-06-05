import '../models/dashboard_stats_model.dart';

class DashboardService {
  Future<DashboardStatsModel> getDashboardStats() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return const DashboardStatsModel(
      currentStreak: 7,
      bestStreak: 21,
      xp: 2450,
    );
  }
}