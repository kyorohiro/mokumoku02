import 'package:flutter/material.dart';
import './assets.dart' as assets;

abstract class Item {
  String title;
  int price;
  bool hasImage;
  Future<Image> getImage();
}

class TestItem extends Item {
  String assetPath;
  TestItem(String title, int price, this.assetPath) {
    this.title = title;
    this.price = price;
  }

  Future<Image> getImage() async {
    Image x;
  
    return Image.asset(assetPath,fit: BoxFit.fitHeight,);
  }
}

class MenuClient {
  Future<List<Item>> getMenus() async {
    return <Item>[
      TestItem("pizza", 800, assets.images_food_pizza_slice_fast_jpg),
      TestItem("squid", 800, assets.images_food_dim_sum_squid_jpg),
      TestItem("cheese bowls", 800, assets.images_food_chili_cheese_bowls_jpg),
      TestItem("flower", 800, assets.images_flower_orange_calendula_bright_0_jpg),
      TestItem("pasta", 800, assets.images_food_pasta_tomato_theme_jpg),
      TestItem("chocolate desert", 800, assets.images_food_purple_chocolate_dessert_jpg)
    ];
  } 
}


//
MenuClient createMenuClient() {
  return MenuClient();
}