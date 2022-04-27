import 'package:flutter/material.dart';

class Scoreboard extends StatelessWidget {
  const Scoreboard({Key? key, required this.scores}) : super(key: key);
  final List<String> scores;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Your Top Scores",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 5),
          scores.isNotEmpty ? Text("1. ${scores[0]}") : Container(),
          scores.length >= 2 ? Text("2. ${scores[1]}") : Container(),
          scores.length >= 3 ? Text("3. ${scores[2]}") : Container(),
        ],
      ),
    ));
  }
}
