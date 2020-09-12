import './client.dart' as client;

List<client.Item> todoMenus;
Cart cart = new Cart();


class Cart {
  Map<String, client.Item>  items = {};
  Map<String,int>  numberOfOrderSet = {};
  plusItem(client.Item item) {
    items[item.id] = item;
    if(!numberOfOrderSet.containsKey(item.id)) {
      numberOfOrderSet[item.id] = 1;
    } else {
      numberOfOrderSet[item.id] = numberOfOrderSet[item.id] + 1;
    }
  }

  minusItem(client.Item item) {
    if(!numberOfOrderSet.containsKey(item.id)) {
      return;
    }
    if(numberOfOrderSet[item.id] <= 0){
      return;
    }

    numberOfOrderSet[item.id] = numberOfOrderSet[item.id] - 1;
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
