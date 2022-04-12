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
                      offset: Offset(3, 9), // changes position of shadow
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
                ),
              ),
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
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 30),
              child: Text(
                pet.getStateImage().toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StatusButton(status: pet.getStatus(StatusType.FOOD)),
                StatusButton(
                  status: pet.getStatus(StatusType.BATHROOM),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 30)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StatusButton(status: pet.getStatus(StatusType.LOVE)),
                StatusButton(
                  status: pet.getStatus(StatusType.WATER),
                ),
              ],
            ),
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
