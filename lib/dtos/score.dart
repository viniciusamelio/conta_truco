// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import '../colors.dart';

class Score {
  const Score({required this.team1, required this.team2});

  factory Score.empty() => const Score(
    team1: Team(players: [], score: 0, color: TeamColor.purple, name: "Time A"),
    team2: Team(players: [], score: 0, color: TeamColor.green, name: "Time B"),
  );

  final Team team1;
  final Team team2;

  Team? get winner => team1.score > team2.score ? team1 : team2;

  String get score => '${team1.score} X ${team2.score}';

  Score copyWith({Team? team1, Team? team2}) {
    return Score(team1: team1 ?? this.team1, team2: team2 ?? this.team2);
  }
}

class Team {
  const Team({
    required this.players,
    required this.score,
    required this.color,
    required this.name,
  });

  final List<String> players;
  final int score;
  final TeamColor color;
  final String name;

  Team copyWith({List<String>? players, int? score, TeamColor? color}) {
    return Team(
      name: name,
      players: players ?? this.players,
      score: score ?? this.score,
      color: color ?? this.color,
    );
  }
}

enum TeamColor {
  purple(purpleTeam),
  green(greenTeam);

  final Color color;
  const TeamColor(this.color);
}
