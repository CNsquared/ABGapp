import 'package:abg_app/models/normalSplitRecipt.dart';
import 'package:abg_app/screens/normalSplit/dataEntryPage.dart';
import 'package:abg_app/screens/normalSplit/finalDisplayPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///Home page of the normal spilting process
///
///Controllers wether in the data entry page or final screen page
///
class NormalSplit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);

    return ChangeNotifierProvider(
      create: (BuildContext context) => NormalSplitRecipt(),
      child: Container(
        //DESGIN TEAM
        padding: EdgeInsets.all(8.0),
        //DESGIN TEAM
        color: Colors.grey,
        child: PageView(controller: controller, children: <Widget>[
          DataEntryPage(controller),
          FinalDisplayPage(controller),
          Placeholder(),
        ]),
      ),
    );
  }
}