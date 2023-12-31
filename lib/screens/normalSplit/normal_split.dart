import 'package:abg_app/screens/normalSplit/final_display_page.dart';
import 'package:flutter/material.dart';

import '../PerItemSplit/data_entry_page.dart';

///Home page of the normal spilting process
///
///Controllers wether in the data entry page or final screen page
///
class NormalSplit extends StatelessWidget {
  static const String routeName = "/normalSplit";

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);

    return Container(
      //*DESGIN TEAM
      padding: EdgeInsets.all(8.0),
      //*DESGIN TEAM
      color: Colors.grey,
      child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: <Widget>[
            DataEntryPage(pageController: controller),
            FinalDisplayPage(
              pageController: controller,
            ),
          ]),
    );
  }
}
