import 'package:flutter/material.dart';
import 'package:pet_simulator/util/pet/pet.dart';
import 'package:pet_simulator/util/pet/status.dart';
import 'package:pet_simulator/widget/button.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key, required this.pet}) : super(key: key);
  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PET")),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            Center(
              child: Container(
                  width: 300,
                  height: 200,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color.fromARGB(255, 251, 174, 200)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IndividualStatus(
                              status: pet.getStatus(StatusType.FOOD)),
                          IndividualStatus(
                              status: pet.getStatus(StatusType.BATHROOM))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IndividualStatus(
                              status: pet.getStatus(StatusType.LOVE)),
                          IndividualStatus(
                              status: pet.getStatus(StatusType.WATER))
                        ],
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(pet.getStateImage()),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Text(pet.getStateImage().toString()),
            Row(
              children: [StatusButton(status: pet.getStatus(StatusType.FOOD))],
            )
          ],
        ),
      ),
    );
  }
}

class IndividualStatus extends StatefulWidget {
  const IndividualStatus({Key? key, required this.status}) : super(key: key);
  final Status status;

  @override
  State<IndividualStatus> createState() => _IndividualStatusState();
}

class _IndividualStatusState extends State<IndividualStatus> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Text(
            widget.status.getType(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Text(
          widget.status.getAmount().toString(),
          style: (const TextStyle(fontSize: 20)),
        )
      ],
    );
  }
}
