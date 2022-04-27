import 'package:pet_simulator/util/pet/pet_command.dart';

class PetCommandInvoker {
  late PetCommand command;

  void setCommand(PetCommand command) {
    this.command = command;
  }

  void executeCommand() {
    command.execute();
  }
}
