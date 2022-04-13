import 'package:pet_simulator/util/pet/pet.dart';

abstract class Status {
  int _amount = 4;
  int minAmount = 0;
  int maxAmount = 4;

  void increaseAmount() {
    _amount += 1;
    if (_amount >= 4) {
      _amount = maxAmount;
    }
  }

  void decreaseAmount() {
    _amount -= 1;
    if (_amount <= 0) {
      _amount = 0;
    }
  }

  int getAmount() {
    return _amount;
  }

  StatusType getType();
  String getName();
}

class LoveStatus extends Status {
  LoveStatus();
  @override
  StatusType getType() {
    return StatusType.LOVE;
  }

  @override
  String getName() {
    return "LOVE";
  }
}

class WaterStatus extends Status {
  WaterStatus();
  @override
  StatusType getType() {
    return StatusType.WATER;
  }

  @override
  String getName() {
    return "WATER";
  }
}

class BathroomStatus extends Status {
  BathroomStatus() {
    _amount = 0;
  }
  @override
  StatusType getType() {
    return StatusType.BATHROOM;
  }

  @override
  String getName() {
    return "POOP";
  }
}

class FoodStatus extends Status {
  FoodStatus();
  @override
  StatusType getType() {
    return StatusType.FOOD;
  }

  @override
  String getName() {
    return "FOOD";
  }
}
