import 'package:pet_simulator/util/pet/pet.dart';

abstract class PetCommand {
  execute();
}

class FeedCommand implements PetCommand {
  Pet pet;
  FeedCommand(this.pet);
  @override
  execute() {
    pet.changeStatusCommand(StatusType.FOOD);
  }
}

class GiveLoveCommand implements PetCommand {
  Pet pet;
  GiveLoveCommand(this.pet);
  @override
  execute() {
    pet.changeStatusCommand(StatusType.LOVE);
  }
}

class GiveWaterCommand implements PetCommand {
  Pet pet;
  GiveWaterCommand(this.pet);
  @override
  execute() {
    pet.changeStatusCommand(StatusType.WATER);
  }
}

class BathroomCommand implements PetCommand {
  Pet pet;
  BathroomCommand(this.pet);
  @override
  execute() {
    pet.changeStatusCommand(StatusType.BATHROOM);
  }
}
