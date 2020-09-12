import './client.dart' as client;

List<client.Item> todoMenus;
Cart cart = new Cart();


class CartItem {
  String id;
  String name;
  int price;
  // ...
  client.Item item;
}

class Cart {
  Map<String,CartItem>  items = {};
  Map<String,int>  numberOfOrderSet = {};
  plusItem(CartItem item) {
    items[item.id] = item;
    if(!numberOfOrderSet.containsKey(item.id)) {
      numberOfOrderSet[item.id] = 1;
    } else {
      numberOfOrderSet[item.id] = numberOfOrderSet[item.id] + 1;
    }
  }

  minusItem(CartItem item) {
    if(numberOfOrderSet.containsKey(item.id)) {
      numberOfOrderSet[item.id] = numberOfOrderSet[item.id] - 1;
    }
  }

  bool contain(String id){
    return items.containsKey(id);
  }

  int getNumberOfOrder(String id) {
    if(numberOfOrderSet.containsKey(id)) {
      return numberOfOrderSet[id];
    } else {
      return 0;
    } 
  }

}
