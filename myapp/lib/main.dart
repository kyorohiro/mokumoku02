import 'package:flutter/material.dart';
import './client.dart' as client;
import './menupage.dart' as menupage;
import './parts.dart' as parts;
import './app.dart' as appcontext;

// Beak Time ..

//
// golobal prop


void main() async {
  // test 
  appcontext.todoMenus = await client.createMenuClient().getMenus();

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
    var itemIds =  appcontext.cart.items.keys.toList();
    var items = itemIds.map((e) => menuItemWidget(screenWidth,appcontext.cart.items[e].item)).toList();
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
    var items =  appcontext.cart.items.keys.toList();
    return 
    ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
      return Text("${appcontext.cart.items[items[index]].name}");
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


