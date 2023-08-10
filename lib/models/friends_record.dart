import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../common/friend.dart';

class FriendsRecord extends ChangeNotifier {
  FriendsRecord() : initialized = false {
    intializeRecord();
  }
  bool initialized;
  List<Friend> _friends = [];

  List<Friend> get friends => _friends;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _friendFile async {
    final path = await _localPath;
    return File('$path/friends.json');
  }

  //intializes each time add friend
  Future<void> intializeRecord() async {
    if (initialized) {
      log("friends file already initialized");
      return;
    }

    await _friendFile.then((value) {
      try {
        log("starting intialization of friends file");
        String jsonString = value.readAsStringSync();
        log("jsonString: $jsonString");
        if (jsonString != "") {
          List json = jsonDecode(jsonString);
          _friends =
              json.map((friendsJson) => Friend.fromJson(friendsJson)).toList();
          log("Set friends as ${friends.toString()}");
        } else {
          log("Friend file blank");
        }
      } on PathNotFoundException {
        log("created friend file");
        value.createSync(recursive: true);
      }
      initialized = true;
      log("intialization of friend file complete");
    });
  }

  void addFriend(Friend friend) {
    _friends.add(friend);
    writeRecord();
    notifyListeners();
  }

  void removeFriend(Friend friend) {
    _friends.remove(friend);
    writeRecord();
    notifyListeners();
  }

  void clearFriends() {
    _friends.clear();
    notifyListeners();
  }

  void setFriends(List<Friend> friends) {
    _friends = friends;
    notifyListeners();
  }

  //rewrites every single log, should just appened
  Future<void> writeRecord() async {
    log("writing record to friend file: ${friends.toString()}");
    var json = jsonEncode(friends.map((e) => e.toJson()).toList());
    log("json: $json");
    await _friendFile.then((value) {
      value.writeAsStringSync(json, mode: FileMode.write);
      log("wrote record to friend file");
    });
  }
}
