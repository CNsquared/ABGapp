import 'dart:developer';

import 'package:abg_app/common/theme.dart';
import 'package:abg_app/models/transaction_record.dart';
import 'package:abg_app/screens/friends_page.dart';
import 'package:abg_app/screens/log_page.dart';
import 'package:abg_app/screens/normalSplit/normal_split.dart';
import 'package:abg_app/screens/PerItemSplit/ImageProcessing/take_picture_page.dart';
import 'package:abg_app/screens/PerItemSplit/ImageProcessing/view_picture.dart';
import 'package:camera/camera.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'models/friends_record.dart';

void main() {
  runApp(const MyApp());
}

///Router used to go between different parts of the app
///Brings you to all main components of the app
// ? Indivual paths inside of these routes can be done with Router or internally
// ? Currently doing them with a pageView seperately

GoRouter router() {
  return GoRouter(
    initialLocation: HomePage.routeName,
    routes: [
      GoRoute(
        path: HomePage.routeName,
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: NormalSplit.routeName,
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context, state: state, child: NormalSplit()),
      ),
      GoRoute(
        path: Log.routeName,
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context, state: state, child: Log()),
      ),
      GoRoute(
        path: ViewPicture.routeName,
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context, state: state, child: ViewPicture()),
      ),
      GoRoute(
        path: TakePicturePage.routeName,
        pageBuilder: (context, state) {
          CameraDescription camera = state.extra as CameraDescription;
          return buildPageWithDefaultTransition(
              context: context,
              state: state,
              child: TakePicturePage(
                camera: camera,
              ));
        },
      ),
      GoRoute(
        path: FriendsPage.routeName,
        pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context, state: state, child: FriendsPage()),
      ),
    ],
  );
}

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

///Starting point of the app that creates the state [TransactionRecord]
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String appName = "Log It";

  @override
  Widget build(BuildContext context) {
    // Builds the home page of the app
    return MultiProvider(
      //Using [GoRouter] to go between pages in the app
      providers: [
        ChangeNotifierProvider<TransactionRecord>(
          create: (_) => TransactionRecord(),
        ),
        ChangeNotifierProvider<ThemeModel>(
          create: (_) => ThemeModel(),
        ),
        ChangeNotifierProvider<FriendsRecord>(create: (_) => FriendsRecord()),
      ],

      child: Consumer<ThemeModel>(
        builder: (context, theme, _) => MaterialApp.router(
          title: appName,

          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',
          debugShowCheckedModeBanner: false,

          theme: theme.theme,
          //in the future do something with themeMode and themeDark

          routerConfig: router(),
        ),
      ),
    );
  }
}

///Home page of the app that allows navigation between different app functionalities
// TODO add animations to go router

class HomePage extends StatelessWidget {
  static const String routeName = "/";

  @override
  Widget build(BuildContext context) {
    var themeData = Provider.of<ThemeModel>(context, listen: false);
    //Needs to be set up to look like figma design
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.wb_sunny_outlined,
            color: themeData.iconColor,
          ),
          onPressed: () {
            themeData.toggleTheme();
          },
        ),
        actions: [
          IconButton(
            icon: Image.asset('images/chaewon.jpeg'),
            onPressed: () {
              context.push(FriendsPage.routeName);
            },
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
              style: ElevatedButton.styleFrom(
                  side: BorderSide(width: 5, color: Colors.grey),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  fixedSize: Size(250, 75)),
              onPressed: () {
                log("Pushing Normal Split");
                context.push(NormalSplit.routeName);
              },
              child: Text(
                "Dividing Equally",
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                //getting cameras from the device and using the first one
                await availableCameras().then((value) =>
                    context.push(TakePicturePage.routeName, extra: value[0]));
              },
              style: ElevatedButton.styleFrom(
                  side: BorderSide(width: 5, color: Colors.grey),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  fixedSize: Size(250, 75)),
              child: Text(
                "Diving Per Item",
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                var logState =
                    Provider.of<TransactionRecord>(context, listen: false);
                await logState
                    .intializeRecord()
                    .then((value) => context.push(Log.routeName));
              },
              style: ElevatedButton.styleFrom(
                  side: BorderSide(width: 5, color: Colors.grey),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  fixedSize: Size(250, 75)),
              child: Text(
                "Past Logs",
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium?.color),
              ),
            ),
          ]),
    );
  }
}
