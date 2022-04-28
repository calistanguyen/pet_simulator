import 'package:pet_simulator/util/pet/pet_command.dart';

//Command pattern invoker that takes in PetCommand and calls execute
class PetCommandInvoker {
  late PetCommand command;

  void setCommand(PetCommand command) {
    this.command = command;
  }

  void executeCommand() {
    command.execute();
  }
}
