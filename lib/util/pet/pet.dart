// ignore_for_file: constant_identifier_names

import 'package:pet_simulator/util/pet/status_change_strategy.dart';

import 'status.dart';

enum StatusType { LOVE, BATHROOM, WATER, FOOD }
enum PetState { HAPPY, SAD, DEAD }

abstract class Pet {
  Status _loveStatus = LoveStatus();
  Status _waterStatus = WaterStatus();
  Status _bathroomStatus = BathroomStatus();
  Status _foodStatus = FoodStatus();
  PetState _state = PetState.HAPPY;

  String _stateDead = "";
  String _stateSad = "";
  String _stateHappy = "";
  String name = "";

  late StatusChangeStrategy statusChange;

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

  bool checkStatusAlreadyFulfilled(StatusType statusType) {
    Status status = getStatus(statusType);
    if (statusType == StatusType.BATHROOM && status.getAmount() == 0) {
      return true;
    } else if (status.getAmount() == 4) {
      return true;
    }
    return false;
  }

  void changeStatusCommand(StatusType statusType) {
    switch (statusType) {
      case StatusType.WATER:
        _waterStatus.increaseAmount();
        break;
      case StatusType.BATHROOM:
        _bathroomStatus.decreaseAmount();
        break;
      case StatusType.LOVE:
        _loveStatus.increaseAmount();
        break;
      case StatusType.FOOD:
        _foodStatus.increaseAmount();
        break;
    }
  }

  //need to be updated later
  PetState checkState() {
    if (_loveStatus.getAmount() <= 0 ||
        _bathroomStatus.getAmount() >= 4 ||
        _foodStatus.getAmount() <= 0 ||
        _waterStatus.getAmount() <= 0) {
      _state = PetState.DEAD;
    } else if (_loveStatus.getAmount() <= 2 ||
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

  void petReset() {
    _loveStatus = LoveStatus();
    _waterStatus = WaterStatus();
    _bathroomStatus = BathroomStatus();
    _foodStatus = FoodStatus();
    _state = PetState.HAPPY;
  }
}

class Cat extends Pet {
  Cat(String name) {
    this.name = name;
    statusChange = CatStatusChange();
    _stateHappy = 'assets/cat/happy.png';
    _stateSad = 'assets/cat/sad.png';
    _stateDead = 'assets/cat/dead.png';
  }
}

class Dog extends Pet {
  Dog(String name) {
    this.name = name;
    statusChange = DogStatusChange();
    _stateHappy = 'assets/dog/happy.png';
    _stateSad = 'assets/dog/sad.png';
    _stateDead = 'assets/dog/dead.png';
  }
}
