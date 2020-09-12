import 'package:flutter/material.dart';
import './client.dart' as client;
import './menupage.dart' as menupage;
import './parts.dart' as parts;
import './app.dart' as appcontext;
import './cartpage.dart' as cartpage;
void main() async {
  // todo : to load data in Widget
  appcontext.todoMenus = await client.createMenuClient().getMenus();

  runApp( MaterialApp(
    routes: {
      "/menu": (BuildContext context){
        return menupage.MyMenuPage();
      },
      "/cart":  (BuildContext context){
        return cartpage.MyBasket();
      },
    },
    home: menupage.MyMenuPage()
  ));
}

