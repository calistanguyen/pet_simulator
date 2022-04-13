import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pet_simulator/util/pet/pet.dart';
import 'package:pet_simulator/util/pet/status.dart';
import 'package:pet_simulator/widget/button.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key, required this.pet}) : super(key: key);
  final Pet pet;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  void initState() {
    super.initState();
    if (widget.pet.getState() != PetState.DEAD) {
      Timer.periodic(const Duration(seconds: 1), (Timer t) {
        if (mounted) {
          setState(() {
            widget.pet.statusChange.statusChange(widget.pet);
            widget.pet.checkState();
          });
        }
      });
    }
  }

  void buttonPress(StatusType statusType) {
    if (widget.pet.getState() != PetState.DEAD) {
      setState(() {
        if (statusType == StatusType.BATHROOM) {
          widget.pet.getStatus(statusType).decreaseAmount();
        } else {
          widget.pet.getStatus(statusType).increaseAmount();
        }
        widget.pet.checkState();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("PET"), backgroundColor: Colors.pink[200]),
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
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
                    widget.pet.getState() == PetState.DEAD
                        ? Text("I died :(")
                        : Text("")
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 30),
              child: Text(
                widget.pet.getStateImage().toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StatusButton(
                  status: widget.pet.getStatus(StatusType.FOOD),
                  onPress: buttonPress,
                ),
                StatusButton(
                  status: widget.pet.getStatus(StatusType.BATHROOM),
                  onPress: buttonPress,
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 30)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StatusButton(
                  status: widget.pet.getStatus(StatusType.LOVE),
                  onPress: buttonPress,
                ),
                StatusButton(
                  status: widget.pet.getStatus(StatusType.WATER),
                  onPress: buttonPress,
                ),
              ],
            ),
          ],
        ),
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
