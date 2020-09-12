import 'package:flutter/material.dart';
import './client.dart' as client;
import './menupage.dart' as menupage;
import './parts.dart' as parts;
import './app.dart' as appcontext;

void main() async {
  // todo : to load data in Widget
  appcontext.todoMenus = await client.createMenuClient().getMenus();

  runApp( MaterialApp(
    home: menupage.MyMenuPage()
  ));
}

