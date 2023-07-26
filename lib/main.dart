import 'package:abg_app/common/theme.dart';
import 'package:abg_app/models/transactionRecord.dart';
import 'package:abg_app/screens/log.dart';
import 'package:abg_app/screens/normalSplit/normalSplit.dart';
import 'package:abg_app/screens/PerItemSplit/ImageProcessing/takePicturePage.dart';
import 'package:abg_app/screens/PerItemSplit/ImageProcessing/viewPicture.dart';
import 'package:camera/camera.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(const MyApp());
}

///Router used to go between different parts of the app
///Brings you to all main components of the app
// ? Indivual paths inside of these routes can be done with Router or internally
// ? Currently doing them with a pageView seperately

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
    return MultiProvider(
      //Using [GoRouter] to go between pages in the app
      providers: [ 
        ChangeNotifierProvider(create: (BuildContext context) => TransactionRecord(),
        ),
        ChangeNotifierProvider<ThemeModel>(
           create: (_) => ThemeModel(),
        )
      ],

      child: MaterialApp.router(
        title: 'Log It',
        debugShowCheckedModeBanner: false,
        theme:  Themes.darkTheme,
        routerConfig: router(),
        
      ),
    );
  }
}

///Home page of the app that allows navigation between different app functionalities
// TODO add animations to go router

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //Needs to be set up to look like figma design
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.sunny),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Log It',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                context.push('/normalSplit');
              },
              child: Text("Split Tax Tip Evenly", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),),
            ),
            ElevatedButton(
              onPressed: () async {
                //getting cameras from the device and using the first one
                await availableCameras()
                    .then((value) => context.push('/camera', extra: value[0]));
              },
              child: Text("Diving Per Item", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),),
            ),
            ElevatedButton(
              onPressed: () async {
                var logState = Provider.of<TransactionRecord>(context, listen: false);
                await logState.intializeRecord().then((value) => context.push('/log'));
                
              },
              child: Text("Past Logs", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),),
            ),
            ElevatedButton(
              onPressed: () {
                context.push('/viewImage');
              },
              child: Text("View Image", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),),
            ),
          ]),
    );
  }
}
