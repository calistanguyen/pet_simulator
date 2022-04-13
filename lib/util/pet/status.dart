abstract class Status {
  int _amount = 4;
  int minAmount = 0;
  int maxAmount = 4;

  void increaseAmount() {
    _amount += 1;
  }

  void decreaseAmount() {
    _amount -= 1;
  }

  int getAmount() {
    return _amount;
  }

  String getType();
}

class LoveStatus extends Status {
  LoveStatus();
  @override
  String getType() {
    return "LOVE";
  }
}

class WaterStatus extends Status {
  WaterStatus();
  @override
  String getType() {
    return "WATER";
  }
}

class BathroomStatus extends Status {
  BathroomStatus() {
    _amount = 0;
  }
  @override
  String getType() {
    return "POOP";
  }
}

class FoodStatus extends Status {
  FoodStatus();
  @override
  String getType() {
    return "FOOD";
  }
}
