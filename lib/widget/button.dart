import 'package:flutter/material.dart';
import 'package:pet_simulator/util/pet/status.dart';

class StatusButton extends StatelessWidget {
  const StatusButton({Key? key, required this.status}) : super(key: key);
  final Status status;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {status.increaseAmount()},
      child: Text(status.getType()),
    );
  }
}
