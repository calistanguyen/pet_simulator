// ignore_for_file: constant_identifier_names

import 'package:pet_simulator/util/observer/observer.dart';

enum TypeUpdate { SCORE }

abstract class Subject {
  void register(Observer observer) {}
  void remove(Observer observer) {}
  void notifyObserver(TypeUpdate typeUpdate) {}
}

//keeps the list of observers
class Publisher implements Subject {
  late int time;
  late List<Observer> observers;
  Publisher() {
    observers = [];
    register(HighScore.instance);
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
