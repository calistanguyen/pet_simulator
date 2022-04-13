// ignore_for_file: constant_identifier_names

import 'status.dart';

enum StatusType { LOVE, BATHROOM, WATER, FOOD }
enum PetState { HAPPY, SAD, DEAD }

abstract class Pet {
  final Status _loveStatus = LoveStatus();
  final Status _waterStatus = WaterStatus();
  final Status _bathroomStatus = BathroomStatus();
  final Status _foodStatus = FoodStatus();
  PetState _state = PetState.HAPPY;

  String _stateDead = "";
  String _stateSad = "";
  String _stateHappy = "";

  Status getStatus(StatusType statusType) {
    switch (statusType) {
      case StatusType.WATER:
        return _waterStatus;
      case StatusType.BATHROOM:
        return _bathroomStatus;
      case StatusType.LOVE:
        return _loveStatus;
      case StatusType.FOOD:
        return _foodStatus;
    }
  }

  //need to be updated later
  PetState checkState() {
    if (_loveStatus.getAmount() <= 2 ||
        _bathroomStatus.getAmount() >= 3 ||
        _foodStatus.getAmount() <= 2 ||
        _waterStatus.getAmount() <= 2) {
      _state = PetState.SAD;
    } else if (_loveStatus.getAmount() >= 3 &&
        _bathroomStatus.getAmount() <= 2 &&
        _foodStatus.getAmount() >= 3 &&
        _waterStatus.getAmount() >= 3) {
      _state = PetState.HAPPY;
    }

    return _state;
  }

  PetState getState() {
    return _state;
  }

  String getStateImage() {
    PetState currentState = getState();
    switch (currentState) {
      case PetState.DEAD:
        return _stateDead;
      case PetState.HAPPY:
        return _stateHappy;
      case PetState.SAD:
        return _stateSad;
    }
  }
}

class Cat extends Pet {
  Cat() {
    _stateHappy = 'assets/cat/happy.png';
    _stateSad = 'assets/cat/sad.png';
    _stateDead = 'assets/cat/dead.png';
  }
}

class Dog extends Pet {
  Dog() {
    _stateHappy = 'assets/dog/happy.png';
    _stateSad = 'assets/dog/sad.png';
    _stateDead = 'assets/dog/dead.png';
  }
}
