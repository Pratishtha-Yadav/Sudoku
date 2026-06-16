import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A),

      appBar: AppBar(
        title: const Text("Statistics"),
        backgroundColor: Colors.transparent,
      ),

      body: const Center(
        child: Text(
          "Statistics Coming Soon",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}