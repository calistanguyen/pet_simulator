//strategy pattern

//dart doesn't have explicit interfaces, so interfaces are implemented implicitly using classes

import 'package:pet_simulator/util/pet/pet.dart';

abstract class BathroomStrategy {
  useBathroom(Pet pet);
}

class TakeOutside implements BathroomStrategy {
  @override
  useBathroom(Pet pet) {}
}
