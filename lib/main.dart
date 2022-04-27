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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Colors.pink[200]),
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
      appBar: AppBar(
        title: const Text("PET"),
        backgroundColor: Colors.pink[200],
      ),
      body: Column(
        children: [
          const Padding(
              padding: EdgeInsets.only(bottom: 20, top: 100),
              child: Text(
                "Choose Your Pet",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink[100],
                  padding: const EdgeInsets.all(10),
                ),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GamePage(pet: Dog("KIKI"))),
                  )
                },
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.pink[100],
                    image: const DecorationImage(
                      image: AssetImage('assets/dog/happy.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.pink[100],
                    padding: const EdgeInsets.all(10)),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GamePage(pet: Cat("LULU"))),
                  )
                },
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.pink[100],
                    image: const DecorationImage(
                      image: AssetImage('assets/cat/happy.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
