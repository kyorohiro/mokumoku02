import 'package:flutter/material.dart';
import './app.dart' as appcontext;
import './client.dart' as client;
import './parts.dart' as parts;


//
// Cart Pages
//
class MyBasket extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order List"),),
      body: body(context);
    );
  }

  Widget body(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var itemIds =  appcontext.cart.items.keys.toList();
    var items = itemIds.map((e) => menuItemWidget(screenWidth,appcontext.cart.items[e])).toList();
    return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: items,
              ),
            ),
            Builder(builder: (BuildContext context){
              return RaisedButton(
                onPressed: (){
                    print("order");
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text("not implement")));
                }, 
                child: Container(
                    width: double.infinity,
                    child: Text("Order!!", textAlign: TextAlign.center,)),
                );
            }),
          ]
        ),
      );
  }
  Widget menuItemWidget(double screenWidth, client.Item item){
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
}



