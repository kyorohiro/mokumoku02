import 'package:flutter/material.dart';
import './client.dart' as client;
import './cartpage.dart' as basketpage;
import './app.dart' as appcontext;
import './parts.dart' as parts;


class MyMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
        actions: [
          RaisedButton(
            child: Icon(
              Icons.shopping_basket
            ),
            onPressed: (){
              print("click backet");
              Navigator.pushNamed(context, "/cart");
          })
        ],
      ),
      body: MenuItemWidget(),
    );
  }
}



class MenuItemWidget extends StatefulWidget {
  @override
  _MenuItemWidgetState createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<MenuItemWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: appcontext.todoMenus.length,
      itemBuilder: (context, index) {
        var item = appcontext.todoMenus[index];
        
        return Container(
          height: 200,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          color: (index%2==0?Colors.red:Colors.blue),
          child: Row(
            mainAxisSize: MainAxisSize.min ,
            children: [
              parts.ImageWithLoading(200,item.getImage),
              Expanded(child: menuItemWidget(item.id, item)),
            ],
          ),
        );     
      },);
  }

  Widget numOfItemWIdget(String id, client.Item item) {
    return Container(
      child: Row(children: [
            // + button
            Container(
              width: 45,
              child: 
                RaisedButton(
                  onPressed: (){
                    print("clicked ${id}");
                    appcontext.cart.plusItem(item);
                      setState(() {});
                  },
                  child: Text("+"),
                ),
                
            ),
            
            Container(
              color: Colors.white,
              height: 35,
              width: 45,
              child: Align(alignment: Alignment.center,child:Text("${appcontext.cart.getNumberOfOrder(item.id)}")),
            ),
            // - button
            Container(
              width: 45,
              child: 
                RaisedButton(
                  onPressed: (){
                    print("clicked ${id}");
                    appcontext.cart.minusItem(item);
                      setState(() {});
                  },
                  child: Text("-"),
                ),
                
            ),
      ],),
    );
  }
  Widget menuItemWidget(String id, client.Item item) {
    return Container(
            color: Colors.white30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // menu item name
                Container(
                  height: 60,
                  color: Colors.black38,
                  child: Text(item.name, style: TextStyle(fontSize: 40.0),),
                ),          
                // menu item description        
                Container(
                  height: 60,
                  child: 
                  Text(""),
                ),

                // menu item price
                Container(
                  //width: 3000,
                  height: 60,
                  color: Colors.black38,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      numOfItemWIdget(id, item),
                      Container(
                        margin: EdgeInsets.only(left: 30),
                        child: Text("${item.price}",style: TextStyle(fontSize: 40.0),textAlign: TextAlign.end,)
                      )
                    ],)
                  
                ),    
              ],)
          );
  }
}
