import 'package:flutter/material.dart';
import 'package:pet_simulator/util/pet/pet.dart';
import 'package:pet_simulator/util/pet/status.dart';

class StatusButton extends StatelessWidget {
  const StatusButton(
      {Key? key,
      required this.status,
      required this.onPress,
      required this.enabled})
      : super(key: key);
  final Status status;
  final Function(StatusType) onPress;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: ElevatedButton(
        onPressed: enabled
            ? () {
                onPress(status.getType());
              }
            : null,
        style: ElevatedButton.styleFrom(
          primary: enabled ? Colors.pink[100] : Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(status.getName()),
        ),
      ),
    );
  }
}
