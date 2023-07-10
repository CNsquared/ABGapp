import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

<<<<<<< HEAD
void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}
=======

void main() => runApp(const MyApp());
>>>>>>> 092eeb11b83e422179d68b6daa98c15d7dc0cd47

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color.fromARGB(255, 238, 232, 222),
      //   forceMaterialTransparency: true,
      //   // title: const Text('Homescreen'),
      // ),
      body: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            style: TextStyle(fontSize: 20),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Tax',
              prefixIcon: Padding(
                        padding: EdgeInsetsDirectional.only(start: 20, top: 10),
                        child: Text("\$",
                                    style: TextStyle(fontSize: 25),)
                        ), 
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters:[ 
              FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
             ],
        

          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            style: TextStyle(fontSize: 20),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Tip',
              prefixIcon: Padding(
                        padding: EdgeInsetsDirectional.only(start: 20, top: 10),
                        child: Text("\$",
                                    style: TextStyle(fontSize: 25),)
                        ), 
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [ FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
            ],
            
          ),
        ),
        ElevatedButton(
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
      ],)
        
        
        
        
        
        
        
        
      //   Container(
      //     height: 5500.0,
      //     width: 1000,
      //     color: Color.fromARGB(255,255,248,231),
      //   child: Align(
      //     alignment: Alignment.bottomCenter,
      //     child: ElevatedButton(
      //       style: ElevatedButton.styleFrom(
      //         backgroundColor: Color.fromARGB(255, 87,78,78),
      //       ),
      //       child: const Text(
      //       'Submit',
      //       style: TextStyle(color: Color.fromARGB(255, 238, 232, 222)),
            
      //       ),
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => const SecondRoute()),
      //         );
      //       },
      //     ),
      //   ),
      // ),
      
=======
    const appTitle = 'ABG App';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
>>>>>>> 092eeb11b83e422179d68b6daa98c15d7dc0cd47
      ),
    );
  }
}

<<<<<<< HEAD
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
=======
class MyCustomForm extends StatelessWidget {
  const MyCustomForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: TextFormField(
            style: TextStyle(fontSize: 20),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Tax',
              prefixIcon: Padding(
                        padding: EdgeInsetsDirectional.only(start: 20, top: 10),
                        child: Text("\$",
                                    style: TextStyle(fontSize: 25),)
                        ), 
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters:[ 
              FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
             ],
        

          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
          child: TextFormField(
            style: TextStyle(fontSize: 20),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Tip',
              prefixIcon: Padding(
                        padding: EdgeInsetsDirectional.only(start: 20, top: 10),
                        child: Text("\$",
                                    style: TextStyle(fontSize: 25),)
                        ), 
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [ FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
            ],
            
          ),
        ),
      ],
    );
  }
>>>>>>> 092eeb11b83e422179d68b6daa98c15d7dc0cd47
}