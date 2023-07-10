import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        title: const Text(''),
        backgroundColor: Color.fromARGB(255, 87,78,78),
      ),
      body: Center(
        child: Container(
          height: 5500.0,
          width: 10000,
          color: Color.fromARGB(255,255,248,231),
        child: Align(
          alignment: Alignment(.85,.9),
          child: FloatingActionButton(
            backgroundColor: Color.fromARGB(255,87,78,78),
  // When the user presses the button, show an alert dialog containing
  // the text that the user has entered into the text field.
            onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Title'),
          shape: RoundedRectangleBorder(
    borderRadius:
      BorderRadius.all(
        Radius.circular(10.0))),
          backgroundColor: Color.fromARGB(255, 255, 248, 231),
          content: const Text('Description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Clear'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('Edit'),
            ),
          ],
        ),
      ),
  tooltip: 'Show me the value!',
  child: const Icon(Icons.monetization_on),
),
        // child: ElevatedButton(
        //   style: ElevatedButton.styleFrom(
        //       backgroundColor: Color.fromARGB(255, 87,78,78),
        //     ),
        //   onPressed: () {
        //     Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => const ThirdRoute())
        //   );
        //   },
          //child: const Text('Confirm?'),
        ),
      ),
        ),
      //),
    );
  }
}

// class ThirdRoute extends StatelessWidget {
//   const ThirdRoute({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//     body: Center(
//       child: Container(
//         height: 5500.0,
//           width: 10000,
//           color: Color.fromARGB(255,255,248,231),
//           child: Align (
//             alignment: Alignment.center,
//     child: ElevatedButton(
//       style: ElevatedButton.styleFrom(
//               backgroundColor: Color.fromARGB(255, 87,78,78),
//             ),
//       onPressed: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const FirstRoute())
//           );
//         },
//         child: const Text("final button lol"),
//         )
//       )
//       )
//     )
//     );
//   }
// }