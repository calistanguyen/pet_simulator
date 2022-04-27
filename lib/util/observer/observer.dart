import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:pet_simulator/util/observer/subject.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

//OBSERVER PATTERN
class Observer {
  void update(Subject subject, TypeUpdate typeUpdate) {}
}

//This observer keeps track of the top 3 high scores
class HighScore implements Observer {
  List<String> text = [];
  List<int> scores = [];
  //implementing Eager Singleton
  static final HighScore _instance = HighScore._();

  HighScore._();

  static HighScore get instance => _instance;

  Future<String> _getDirPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  //check if the update is regarding the score
  @override
  void update(Subject subject, TypeUpdate typeUpdate) {
    subject as Publisher;
    _read();
    if (typeUpdate == TypeUpdate.SCORE) {
      scores.add(subject.getTime());
      scores.sortReversed();
      convertScoreToText();
      _write();
      _read();
    }
  }

  //write to the file in case there is a new high score
  Future<File> _write() async {
    String newText = "";
    int scoreSize = text.length;
    if (text.length >= 3) {
      scoreSize = 3;
    }
    for (int i = 0; i < scoreSize; i++) {
      newText += text[i] + '\n';
    }
    final path = await _getDirPath();
    File file = File('$path/scores.txt');
    file.writeAsString(newText);
    return file;
  }

  //read the txt file
  Future<void> _read() async {
    try {
      final path = await _getDirPath();
      File file = File('$path/scores.txt');
      text = file.readAsLinesSync();
    } catch (e) {
      print("Couldn't read file");
    }
  }

  //change string to int
  void convertTextToScore() {
    for (int i = 0; i < text.length; i++) {
      scores.add(int.parse(text[i]));
    }
  }

  //change int to string
  void convertScoreToText() {
    text = [];
    for (int i = 0; i < scores.length; i++) {
      text.add(scores[i].toString());
    }
  }
}
