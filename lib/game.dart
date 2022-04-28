import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pet_simulator/util/observer/subject.dart';
import 'package:pet_simulator/util/pet/pet.dart';
import 'package:pet_simulator/util/pet/pet_command.dart';
import 'package:pet_simulator/util/pet/pet_command_invoker.dart';
import 'package:pet_simulator/util/pet/status.dart';
import 'package:pet_simulator/widget/button.dart';
import 'package:pet_simulator/widget/scoreboard.dart';
import 'package:path_provider/path_provider.dart';

//This is the Page the game is running on
class GamePage extends StatefulWidget {
  const GamePage({Key? key, required this.pet}) : super(key: key);
  final Pet pet;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  //setting up the timer and the pet for the game
  bool mispressed = false;
  int disabledButton = -1;
  int seconds = 0;
  bool startGame = false;
  final stopwatch = Stopwatch();
  late Timer timer;
  Publisher publisher = Publisher();
  bool petDead = false;
  PetCommandInvoker invoker = PetCommandInvoker();
  String description = "";
  List<String> scores = [];
  @override
  void initState() {
    super.initState();
    _read();
  }

  //check if the game is starting
  void startingGame() {
    if (widget.pet.getState() != PetState.DEAD) {
      startGame = true;
      //This timer keeps track of the periodic status changes for the pet
      //the pet will get a random status change based on their StatusChange strategy every 1 second
      timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        if (mounted) {
          setState(() {
            seconds += 1;
            //If a button is mispressed, itll be un disabled after 4 seconds
            if (mispressed && seconds % 4 == 0) {
              disabledButton = -1;
              mispressed = false;
            }
            widget.pet.statusChange.statusChange(widget.pet);
            widget.pet.checkState();
          });
        }
      });
    }
  }

  //check if the game needs to stop
  void stopGame() {
    if (widget.pet.getState() == PetState.DEAD) {
      stopwatch.stop();
      publisher.setTime(stopwatch.elapsedMilliseconds);
      startGame = false;
      timer.cancel();
    }
  }

  //function to update the text based on the button clicked
  void changeDescription(String info) {
    setState(() {
      description = info;
    });
  }

  //This sets the command for the status change
  void setCommand(StatusType statusType) {
    switch (statusType) {
      case StatusType.WATER:
        invoker.setCommand(GiveWaterCommand(widget.pet));
        break;
      case StatusType.BATHROOM:
        invoker.setCommand(BathroomCommand(widget.pet));
        break;
      case StatusType.LOVE:
        invoker.setCommand(GiveLoveCommand(widget.pet));
        break;
      case StatusType.FOOD:
        invoker.setCommand(FeedCommand(widget.pet));
        break;
    }
  }

  //handling when a button is pressed
  void buttonPress(StatusType statusType) {
    if (widget.pet.getState() != PetState.DEAD) {
      //Checks if a status is already fulfilled for that particular button pressed
      bool alreadyFull = widget.pet.checkStatusAlreadyFulfilled(statusType);
      if (!alreadyFull) {
        setState(() {
          //if not already full, call the execute command
          setCommand(statusType);
          invoker.executeCommand();
          widget.pet.checkState();
        });
      } else {
        setState(() {
          //if status is already full, then it is a misspress and one button gets randomly disabled
          mispressed = true;
          widget.pet.checkState();
          Random random = Random();
          disabledButton = random.nextInt(4) + 1;
        });
      }
    }
  }

  //checking if the pet is Dead
  bool isDead() {
    if (widget.pet.getState() != PetState.DEAD) {
      return petDead;
    }
    setState(() {
      petDead = true;
      _read();
    });
    stopGame();
    return petDead;
  }

  //get the txt file for the scoreboard
  Future<String> _getDirPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<List<String>> _read() async {
    try {
      final path = await _getDirPath();
      File file = File('$path/scores.txt');
      return file.readAsLines();
    } catch (e) {
      print("Couldn't read file");
    }
    return [];
  }

//https://itnext.io/create-a-stopwatch-app-with-flutter-f0dc6a176b8a#:~:text=Flutter%20provided%20a%20Stopwatch%20class,elapsedMilliseconds%20.
  String formatTime(int milliseconds) {
    var secs = milliseconds ~/ 1000;
    var hours = (secs ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (secs % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  //UI FOR THE GAME PAGE
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("PET"), backgroundColor: Colors.pink[200]),
      body: Column(
        children: [
          Align(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20, right: 20),
              child: Text(
                formatTime(stopwatch.elapsedMilliseconds),
                style: const TextStyle(fontSize: 30),
              ),
            ),
            alignment: Alignment.topRight,
          ),
          Visibility(
            visible: !isDead(),
            child: Center(
              child: Container(
                width: 300,
                height: 150,
                padding: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 205, 205, 205)
                          .withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 4,
                      offset: const Offset(3, 9), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IndividualStatus(
                            status: widget.pet.getStatus(StatusType.FOOD)),
                        IndividualStatus(
                            status: widget.pet.getStatus(StatusType.BATHROOM))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IndividualStatus(
                            status: widget.pet.getStatus(StatusType.LOVE)),
                        IndividualStatus(
                            status: widget.pet.getStatus(StatusType.WATER))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: petDead,
            // child: Scoreboard(
            //   scores: publisher.getScores(),
            // )
            child: FutureBuilder<List<String>?>(
              future: _read(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      return Scoreboard(
                        scores: snapshot.data!.toList(),
                      );
                    }

                  default:
                    return const Text('Unhandle State');
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.pet.getStateImage()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 30),
            child: Text(
              description,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
            ),
          ),
          Visibility(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    StatusButton(
                      status: widget.pet.getStatus(StatusType.FOOD),
                      onPress: buttonPress,
                      enabled: !(disabledButton == 1),
                      description: 'NOM NOM',
                      callback: changeDescription,
                    ),
                    StatusButton(
                      status: widget.pet.getStatus(StatusType.BATHROOM),
                      onPress: buttonPress,
                      enabled: !(disabledButton == 2),
                      description: 'WHEWW',
                      callback: changeDescription,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      StatusButton(
                        status: widget.pet.getStatus(StatusType.LOVE),
                        onPress: buttonPress,
                        enabled: !(disabledButton == 3),
                        description: 'UWU',
                        callback: changeDescription,
                      ),
                      StatusButton(
                        status: widget.pet.getStatus(StatusType.WATER),
                        onPress: buttonPress,
                        enabled: !(disabledButton == 4),
                        description: 'AHHH~',
                        callback: changeDescription,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            visible: !petDead && startGame,
          ),
          Visibility(
              visible: !startGame && !petDead,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    startGame = true;
                    stopwatch.start();
                    startingGame();
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Start Game",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink[100],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              )),
          Visibility(
              visible: petDead,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.pet.petReset();
                    stopwatch.reset();
                    stopwatch.start();
                    startGame = true;
                    petDead = false;
                    disabledButton = -1;
                    mispressed = false;
                    startingGame();
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Try Again",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink[100],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
              )),
        ],
      ),
    );
  }
}

//UI for the status Display
class IndividualStatus extends StatelessWidget {
  const IndividualStatus({Key? key, required this.status}) : super(key: key);
  final Status status;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Text(
            status.getName(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Text(
          status.getAmount().toString(),
          style: (const TextStyle(fontSize: 20)),
        )
      ],
    );
  }
}
