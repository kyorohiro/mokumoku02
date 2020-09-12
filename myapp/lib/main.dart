import 'package:flutter/material.dart';
import './client.dart' as client;
import './menupage.dart' as menupage;
import './parts.dart' as parts;

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

// Beak Time ..

//
// golobal prop
List<client.Item> todoMenus;
Cart cart = new Cart();

void main() async {
  // test 
  todoMenus = await client.createMenuClient().getMenus();

  runApp( MaterialApp(
    home: menupage.MyMenuPage()
  ));
}


//
// Cart Pages
//
class MyBasket extends StatelessWidget {
  Widget titleWidget() {
    return 
    Container(
      child:
        Text("order list",
          textAlign: TextAlign.center,
          style: 
            TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              ),
          ), 
      color:Colors.amber, 
      width: double.infinity,);
  }
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var density = MediaQuery.of(context).devicePixelRatio; 
    var itemIds =  cart.items.keys.toList();
    var items = itemIds.map((e) => menuItemWidget(screenWidth,cart.items[e].item)).toList();
   // var items = itemIds.map((e) => Text("${__cart.items[e].name}")).toList();

    return Scaffold(
      appBar: AppBar(title: Text("Cart!!"),),
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            titleWidget(),
            Container(
              child: Column(
                children: items,
              ),
            ),
            RaisedButton(onPressed: (){
              print("order");
            }, child: Text("Order!!"),)
            ]

        ),
      )
    );
  }

  Widget itemList() {
    var items =  cart.items.keys.toList();
    return 
    ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
      return Text("${cart.items[items[index]].name}");
    },);
    //Text("Bucket !!");
  }
}

Widget menuItemWidget(double screenWidth, client.Item item){
  print(">>${screenWidth}");
  var info = Container(
    width: screenWidth-100,
    color: Colors.white30,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 30,
          color: Colors.black38,
          child: Text("Food Name",style: TextStyle(fontSize: 20.0),),
        ), 
        Container(
          width: double.infinity,
          height: 40,
          color: Colors.black38,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("800",style: TextStyle(fontSize: 40.0),textAlign: TextAlign.end,),
            ],)
        ),    
      ],)
  );

  return Container(
        height: 100,
        //color: (index%2==0?Colors.black54:Colors.white54),
        child: Row(
          children: [
            parts.ImageWithLoading(100,item.getImage),
            info
          ],
        ));
}


