import 'package:flutter/material.dart';
import './assets.dart' as assets;

abstract class Item {
  String id;
  String name;
  int price;
  bool hasImage;
  Future<Image> getImage();
  // https://stackoverflow.com/questions/20577606/whats-a-good-recipe-for-overriding-hashcode-in-dart
  bool operator ==(o) => o is Item && o.id == this.id;
  int get hashCode => id.hashCode;
}

class TestItem extends Item {
  String assetPath;
  TestItem(String id, String title, int price, this.assetPath) {
    this.id = id;
    this.name = title;
    this.price = price;
  }

  Future<Image> getImage() async {
    Image x;
  
    return Image.asset(assetPath,fit: BoxFit.fitHeight,);
  }
}

// Mock now
class MenuClient {
  Future<List<Item>> getMenus() async {
    return <Item>[
      TestItem("01", "pizza", 800, assets.images_food_pizza_slice_fast_jpg),
      TestItem("02", "squid", 1200, assets.images_food_dim_sum_squid_jpg),
      TestItem("03", "cheese bowls", 200, assets.images_food_chili_cheese_bowls_jpg),
      TestItem("04", "flower", 900, assets.images_flower_orange_calendula_bright_0_jpg),
      TestItem("05", "pasta", 300, assets.images_food_pasta_tomato_theme_jpg),
      TestItem("06", "chocolate desert", 80, assets.images_food_purple_chocolate_dessert_jpg)
    ];
  } 
}


//
MenuClient createMenuClient() {
  return MenuClient();
}