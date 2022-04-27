// ignore_for_file: constant_identifier_names

import 'package:pet_simulator/util/observer/observer.dart';

import '../pet/pet.dart';

enum TypeUpdate { SCORE, CLICKSFOOD, CLICKSBATHROOM, CLICKSWATER, CLICKSLOVE }

class Subject {
  void register(Observer observer) {}
  void remove(Observer observer) {}
  void notifyObserver(TypeUpdate typeUpdate) {}
}

class Publisher implements Subject {
  late int totalPoopClicks;
  late int totalLoveClicks;
  late int totalWaterClicks;
  late int totalFoodClicks;
  late int time;
  late List<Observer> observers;
  Publisher() {
    totalFoodClicks = 0;
    totalLoveClicks = 0;
    totalPoopClicks = 0;
    totalWaterClicks = 0;
    observers = [];
    register(HighScore());
  }
  @override
  void notifyObserver(TypeUpdate typeUpdate) {
    for (var i = 0; i < observers.length; i++) {
      observers[i].update(this, typeUpdate);
    }
  }

  @override
  void register(Observer observer) {
    if (observers.isEmpty) {}
    if (!observers.contains(observer)) {
      observers.add(observer);
    }
    return;
  }

  @override
  void remove(Observer observer) {
    if (observers.contains(observer)) {
      observers.remove(observer);
    }
    return;
  }

  int getTime() {
    return time;
  }

  void setTime(int newTime) {
    time = newTime;
    notifyObserver(TypeUpdate.SCORE);
  }
}
