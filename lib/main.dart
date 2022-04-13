import 'package:flutter/material.dart';
import 'package:pet_simulator/util/pet/pet.dart';
import 'game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Start(),
    );
  }
}

class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late Pet chosenPet;
    return Scaffold(
      appBar: AppBar(title: const Text("PET")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                "Choose Your Pet",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.pink[200],
                      padding: const EdgeInsets.all(10)),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GamePage(pet: Dog())),
                    )
                  },
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.pink[200],
                      image: const DecorationImage(
                        image: AssetImage('assets/dog/happy.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.pink[200],
                      padding: const EdgeInsets.all(10)),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GamePage(pet: Cat())),
                    )
                  },
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.pink[200],
                      image: const DecorationImage(
                        image: AssetImage('assets/cat/happy.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
