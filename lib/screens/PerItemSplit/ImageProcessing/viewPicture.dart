import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

///Displays the logged transations in [TransactionRecord]
///
// TODO #4 Bug dont know how to make so that if the image doesnt exisit it catches expection and shows another image.
class ViewPicture extends StatelessWidget {
  late final String imagePath;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        FutureBuilder<String>(
          future: getPath(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // If the Future is complete, display the preview.
              try {
                var file = File(snapshot.data!);
                log("Got the file");
                var image = Image.file(file);
                log("created image object");
                return image;
              }on PathNotFoundException{
                log("Expection Caught");
                return const Center(child: CircularProgressIndicator());
              }
            } else {
              // Otherwise, display a loading indicator.
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        ElevatedButton(
          onPressed: () {
            context.go("/home");
          },
          child: Icon(Icons.home),
        ),
      ],
    );

    //just shows the hard coded first image taken
  }

  Future<String> getPath() async {
    return join(
      // Store the picture in the temp directory.
      // Find the temp directory using the `path_provider` plugin.
      (await getApplicationDocumentsDirectory()).path,
      '0.png',
    );
  }
}
