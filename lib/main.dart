import 'package:abg_app/models/transactionRecord.dart';
import 'package:abg_app/screens/log.dart';
import 'package:abg_app/screens/normalSplit/normalSplit.dart';
import 'package:abg_app/screens/takePicture/takePicturePage.dart';
import 'package:abg_app/screens/takePicture/viewPicture.dart';
import 'package:camera/camera.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

///Router used to go between different parts of the app
GoRouter router() {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: '/normalSplit',
        builder: (context, state) => NormalSplit(),
      ),
      GoRoute(
        path: '/log',
        builder: (context, state) => Log(),
      ),
      GoRoute(
        path: '/viewImage',
        builder: (context, state) => ViewPicture(),
      ),
      GoRoute(
        path: '/camera',
        builder: (context, state) {
          CameraDescription camera = state.extra as CameraDescription;
          return TakePicturePage(
            camera: camera,
          );
        },
      ),
    ],
  );
}

///Starting point of the app that creates the state [TransactionRecord]
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Builds the home page of the app
    return ChangeNotifierProvider(
      create: (BuildContext context) => TransactionRecord(),
      //Using [GoRouter] to go between pages in the app
      child: MaterialApp.router(
        title: 'Log It',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme:
              //DESGIN TEAM
              //Create actual theme
              ColorScheme.fromSeed(
                  seedColor: Color.fromARGB(255, 104, 105, 105)),
        ),
        routerConfig: router(),
      ),
    );
  }
}

///Home page of the app that allows navigation between different app functionalities
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Needs to be set up to look like figma design
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    context.go('/normalSplit');
                  },
                  child: Text("Split Tax Tip Evenly"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    //getting cameras from the device and using the first one
                    await availableCameras().then(
                        (value) => context.go('/camera', extra: value[0]));
                  },
                  child: Text("Diving Per Item"),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.go('/log');
                  },
                  child: Text("Past Logs"),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.go('/viewImage');
                  },
                  child: Text("View Image"),
                ),
              ]),
        ),
      ),
    );
  }
}
