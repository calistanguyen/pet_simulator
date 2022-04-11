import 'status.dart';

enum StatusType { LOVE, BATHROOM, WATER, FOOD }
enum PetState { HAPPY, SAD, DEAD }

class Pet {
  late String _petName;
  late Status _loveStatus;
  late Status _waterStatus;
  late Status _bathroomStatus;
  late Status _foodStatus;
  late PetState _state;

  final String _stateDead = "";
  final String _stateSad = "";
  final String _stateHappy = "";

  Pet(String chosenPetName) {
    _petName = chosenPetName;
    _loveStatus = LoveStatus(4);
    _waterStatus = WaterStatus(4);
    _bathroomStatus = BathroomStatus(4);
    _foodStatus = FoodStatus(4);
    _state = PetState.HAPPY;
  }

  String getPetName() {
    return _petName;
  }

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
        _bathroomStatus.getAmount() <= 2 ||
        _foodStatus.getAmount() <= 2 ||
        _waterStatus.getAmount() <= 2) {
      _state = PetState.SAD;
    } else if (_loveStatus.getAmount() >= 3 &&
        _bathroomStatus.getAmount() >= 3 &&
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
  @override
  final String _stateHappy = 'assets/cat/happy.png';
  @override
  final String _stateSad = 'assets/cat/sad.png';
  @override
  final String _stateDead = 'assets/cat/dead.png';
  Cat(String chosenPetName) : super(chosenPetName);
}

class Dog extends Pet {
  @override
  final String _stateHappy = 'assets/dog/happy.png';
  @override
  final String _stateSad = 'assets/dog/sad.png';
  @override
  final String _stateDead = 'assets/dog/dead.png';
  Dog(String chosenPet) : super(chosenPet);
}
