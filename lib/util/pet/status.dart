// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pet_simulator/util/pet/pet.dart';

class Status {
  int _amount;
  int MINAMOUNT = 0;
  int MAXAMOUNT = 4;

  Status(
    this._amount,
  ) {
    _amount = MAXAMOUNT;
  }

  void increaseAmount() {
    _amount += 1;
  }

  void decreaseAmount() {
    _amount -= 1;
  }

  int getAmount() {
    return _amount;
  }

  String getType() {
    return "Status";
  }
}

class LoveStatus extends Status {
  LoveStatus(int amount) : super(amount);

  @override
  String getType() {
    return "LOVE";
  }
}

class WaterStatus extends Status {
  WaterStatus(int amount) : super(amount);
  @override
  String getType() {
    return "WATER";
  }
}

class BathroomStatus extends Status {
  BathroomStatus(int amount) : super(amount);
  @override
  String getType() {
    return "POOP";
  }
}

class FoodStatus extends Status {
  FoodStatus(int amount) : super(amount);
  @override
  String getType() {
    return "FOOD";
  }
}
