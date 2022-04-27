import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pet_simulator/util/pet/pet.dart';
import 'package:pet_simulator/util/pet/pet_command.dart';
import 'package:pet_simulator/util/pet/pet_command_invoker.dart';
import 'package:pet_simulator/util/pet/status.dart';
import 'package:pet_simulator/widget/button.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key, required this.pet}) : super(key: key);
  final Pet pet;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool mispressed = false;
  int disabledButton = -1;
  int seconds = 0;
  bool startGame = false;
  final stopwatch = Stopwatch();
  late Timer timer;
  PetCommandInvoker invoker = PetCommandInvoker();
  @override
  void initState() {
    super.initState();
  }

  void startingGame() {
    if (widget.pet.getState() != PetState.DEAD) {
      startGame = true;
      timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        if (mounted) {
          setState(() {
            seconds += 1;
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

  void stopGame() {
    if (widget.pet.getState() == PetState.DEAD) {
      stopwatch.stop();
      startGame = false;
      timer.cancel();
    }
  }

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

  void buttonPress(StatusType statusType) {
    if (widget.pet.getState() != PetState.DEAD) {
      bool alreadyFull = widget.pet.checkStatusAlreadyFulfilled(statusType);
      if (!alreadyFull) {
        setState(() {
          setCommand(statusType);
          invoker.executeCommand();
          widget.pet.checkState();
        });
      } else {
        setState(() {
          mispressed = true;
          widget.pet.checkState();
          Random random = Random();
          disabledButton = random.nextInt(4) + 1;
        });
      }
    }
  }

  bool isDead() {
    if (widget.pet.getState() != PetState.DEAD) {
      return false;
    }
    stopGame();
    return true;
  }

//https://itnext.io/create-a-stopwatch-app-with-flutter-f0dc6a176b8a#:~:text=Flutter%20provided%20a%20Stopwatch%20class,elapsedMilliseconds%20.
  String formatTime(int milliseconds) {
    var secs = milliseconds ~/ 1000;
    var hours = (secs ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (secs % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

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
          Center(
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
              widget.pet.getStateImage().toString(),
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
            ),
          ),
          Visibility(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StatusButton(
                    status: widget.pet.getStatus(StatusType.FOOD),
                    onPress: buttonPress,
                    enabled: !(disabledButton == 1)),
                StatusButton(
                    status: widget.pet.getStatus(StatusType.BATHROOM),
                    onPress: buttonPress,
                    enabled: !(disabledButton == 2)),
              ],
            ),
            visible: !isDead() && startGame,
          ),
          Visibility(
              visible: !startGame && !isDead(),
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
              visible: isDead(),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.pet.petReset();
                    stopwatch.reset();
                    stopwatch.start();
                    startGame = true;
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
          Visibility(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StatusButton(
                      status: widget.pet.getStatus(StatusType.LOVE),
                      onPress: buttonPress,
                      enabled: !(disabledButton == 3)),
                  StatusButton(
                      status: widget.pet.getStatus(StatusType.WATER),
                      onPress: buttonPress,
                      enabled: !(disabledButton == 4)),
                ],
              ),
            ),
            visible: !isDead() && startGame,
          ),
        ],
      ),
    );
  }
}

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
