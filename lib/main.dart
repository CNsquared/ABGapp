import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color.fromARGB(255, 238, 232, 222),
      //   forceMaterialTransparency: true,
      //   // title: const Text('Homescreen'),
      // ),
      body: Center(
        child: Container(
          height: 5500.0,
          width: 1000,
          color: Color.fromARGB(255,255,248,231),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 87,78,78),
            ),
            child: const Text(
            'Submit',
            style: TextStyle(color: Color.fromARGB(255, 238, 232, 222)),
            
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SecondRoute()),
              );
            },
          ),
        ),
      ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation Screen'),
        backgroundColor: Color.fromARGB(255, 87,78,78),
      ),
      body: Center(
        child: Container(
          height: 5500.0,
          width: 10000,
          color: Color.fromARGB(255,255,248,231),
        child: Align(
          alignment: Alignment.center,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 87,78,78),
            ),
          onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ThirdRoute())
          );
          },
          child: const Text('Confirm?'),
        ),
      ),
        ),
      ),
    );
  }
}

class ThirdRoute extends StatelessWidget {
  const ThirdRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Center(
      child: Container(
        height: 5500.0,
          width: 10000,
          color: Color.fromARGB(255,255,248,231),
          child: Align (
            alignment: Alignment.center,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 87,78,78),
            ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FirstRoute())
          );
        },
        child: const Text("final button lol"),
        )
      )
      )
    )
    );
  }
}