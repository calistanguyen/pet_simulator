import 'dart:math';

//strategy pattern

//dart doesn't have explicit interfaces, so interfaces are implemented implicitly using classes

import 'package:pet_simulator/util/pet/pet.dart';

abstract class StatusChangeStrategy {
  statusChange(Pet pet);
}

class CatStatusChange implements StatusChangeStrategy {
  @override
  statusChange(Pet cat) {
    Random rand = Random();
    // 50% chance cat gets hungry
    if (rand.nextInt(4) <= 1) {
      cat.getStatus(StatusType.FOOD).decreaseAmount();
    }
    if (rand.nextInt(9) <= 2) {
      cat.getStatus(StatusType.WATER).decreaseAmount();
    }
    if (rand.nextInt(100) <= 9) {
      cat.getStatus(StatusType.LOVE).decreaseAmount();
    }
    if (rand.nextInt(100) <= 19) {
      cat.getStatus(StatusType.BATHROOM).increaseAmount();
    }
  }
}

class DogStatusChange implements StatusChangeStrategy {
  @override
  statusChange(Pet dog) {
    Random rand = Random();
    //50% chance cat gets hungry
    if (rand.nextInt(4) <= 3) {
      dog.getStatus(StatusType.FOOD).decreaseAmount();
    }
    if (rand.nextInt(4) <= 0) {
      dog.getStatus(StatusType.WATER).decreaseAmount();
    }
    if (rand.nextInt(100) <= 69) {
      dog.getStatus(StatusType.LOVE).decreaseAmount();
    }
    if (rand.nextInt(100) <= 9) {
      dog.getStatus(StatusType.BATHROOM).increaseAmount();
    }
  }
}
