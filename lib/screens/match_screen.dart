import 'package:conta_truco/colors.dart';
import 'package:conta_truco/dtos/score.dart';
import 'package:conta_truco/text_styles.dart';
import 'package:conta_truco/widgets/score_bar.dart';
import 'package:flutter/material.dart';

enum TurnPoints {
  ordinary(1, Colors.white, "Pedir Truco"),
  truco(3, Colors.amber, "Pedir 6"),
  six(6, Colors.orange, "Pedir 9"),
  nine(9, Colors.red, "Pedir 12"),
  twelve(12, Colors.blueGrey, "Reset");

  final int points;
  final String label;
  final Color color;
  const TurnPoints(this.points, this.color, this.label);
}

class MatchScreen extends StatefulWidget {
  const MatchScreen({super.key});

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  final ValueNotifier<Score> score = ValueNotifier<Score>(Score.empty());
  final ValueNotifier<TurnPoints> turnPoints = ValueNotifier<TurnPoints>(
    TurnPoints.ordinary,
  );

  @override
  void initState() {
    super.initState();
    score.addListener(() async {
      turnPoints.value = TurnPoints.ordinary;
      final gameScore = score.value;
      final hasGameFinished =
          gameScore.team1.score == 12 || gameScore.team2.score == 12;
      if (hasGameFinished) {
        await showDialog(
          context: context,

          builder:
              (_) => AlertDialog(
                backgroundColor: elevated01,
                title: Text(
                  "Fim de jogo",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: Text("Parabéns ${gameScore.winner?.name}!"),
              ),
        );
        score.value = Score.empty();
      }
    });
  }

  int decrementTeamScore(Team team) {
    if (team.score <= 1) {
      return 0;
    }
    return team.score - 1;
  }

  int incrementTeamScore(Team team, int points) {
    if (team.score + points >= 12) {
      return 12;
    }
    return team.score + points;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: score,
      builder: (context, state, _) {
        return Scaffold(
          appBar: ScoreBar(score: state),
          backgroundColor: Color(0XFF131315),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: ValueListenableBuilder(
            valueListenable: turnPoints,
            builder:
                (context, points, _) => Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  child: OutlinedButton(
                    onPressed: () {
                      if (points == TurnPoints.twelve) {
                        turnPoints.value = TurnPoints.ordinary;
                        return;
                      }
                      turnPoints.value =
                          TurnPoints.values[turnPoints.value.index + 1];
                    },
                    style: ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.all(6)),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Color(0XFF242424)),
                        ),
                      ),
                    ),
                    child: Text(
                      points.label,
                      style: baseText.copyWith(
                        color: points.color,
                        fontSize: 32,
                      ),
                    ),
                  ),
                ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScoreHandlerButton(
                team: state.team1,
                onIncrement: () {
                  final newScore = incrementTeamScore(
                    state.team1,
                    turnPoints.value.points,
                  );
                  score.value = state.copyWith(
                    team1: state.team1.copyWith(score: newScore),
                  );
                },
                onDecrement: () {
                  final newScore = decrementTeamScore(state.team1);
                  score.value = state.copyWith(
                    team1: state.team1.copyWith(score: newScore),
                  );
                },
              ),
              Divider(),
              ScoreHandlerButton(
                team: state.team2,
                onIncrement: () {
                  final newScore = incrementTeamScore(
                    state.team2,
                    turnPoints.value.points,
                  );
                  score.value = state.copyWith(
                    team2: state.team2.copyWith(score: newScore),
                  );
                },
                onDecrement: () {
                  final newScore = decrementTeamScore(state.team2);
                  score.value = state.copyWith(
                    team2: state.team2.copyWith(score: newScore),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class ScoreHandlerButton extends StatelessWidget {
  const ScoreHandlerButton({
    super.key,
    required this.team,
    required this.onDecrement,
    required this.onIncrement,
  });
  final Team team;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              FilledButton.icon(
                onPressed: onDecrement,
                label: Text("-"),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(disabledColor),
                ),
              ),
              Text(
                team.score.toString(),
                style: baseText.copyWith(
                  color: team.color.color,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FilledButton.icon(
                onPressed: onIncrement,
                label: Text("+"),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                ),
              ),
            ],
          ),
          Text(
            team.name,
            style: baseText.copyWith(fontSize: 24, color: team.color.color),
          ),
        ],
      ),
    );
  }
}
