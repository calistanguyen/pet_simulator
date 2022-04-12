import 'package:flutter/material.dart';
import 'package:pet_simulator/util/pet/status.dart';

class StatusButton extends StatelessWidget {
  const StatusButton({Key? key, required this.status}) : super(key: key);
  final Status status;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: ElevatedButton(
        onPressed: () => {status.increaseAmount()},
        style: ElevatedButton.styleFrom(
          primary: Colors.pink[100],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(status.getType()),
        ),
      ),
    );
  }
}
