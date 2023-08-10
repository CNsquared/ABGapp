import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/expenses.dart';
import '../common/friend.dart';
import '../models/friends_record.dart';

class FriendsPage extends StatefulWidget {
  static const routeName = '/friends';
  
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  late List<Friend> friends;
  bool initialized = false;

  @override
  void initState() {
    var friendsRecord = Provider.of<FriendsRecord>(context, listen: false);
    friendsRecord.intializeRecord().then((value) {
      
      setState(() {
        friends = friendsRecord.friends;
        log("set friends: $friends");
        initialized = true;
      });
      
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Friends"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                var friendsRecord =
                    Provider.of<FriendsRecord>(context, listen: false);
                friendsRecord.addFriend(Friend(name: "Chaewon"));
              });
            },
          )
        ],
      ),
      body: Consumer<FriendsRecord>(
        builder: (context, value, child) {
          if (initialized) {
            return ListView.builder(
              itemCount: friends.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(friends[index].name),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        var friendsRecord =
                            Provider.of<FriendsRecord>(context, listen: false);
                        friendsRecord.removeFriend(friends[index]);
                      });
                    },
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
