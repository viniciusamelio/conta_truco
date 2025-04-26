import 'package:conta_truco/colors.dart';
import 'package:conta_truco/dtos/score.dart';
import 'package:conta_truco/text_styles.dart';
import 'package:flutter/material.dart';

class ScoreBar extends StatelessWidget implements PreferredSizeWidget {
  const ScoreBar({super.key, required this.score});
  final Score score;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: elevated01,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          spacing: 18,
          children: [
            Text("Placar", style: baseText.copyWith(fontSize: 16)),
            Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TeamIndicator(color: score.team1.color.color),
                Text(score.score, style: baseText.copyWith(fontSize: 32)),
                TeamIndicator(color: score.team2.color.color),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 180);
}

class TeamIndicator extends StatelessWidget {
  const TeamIndicator({super.key, required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18,
      width: 18,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
