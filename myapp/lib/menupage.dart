import 'package:flutter/material.dart';
import './client.dart' as client;
import 'main.dart' as basketpage;
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
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return basketpage.MyBasket();
              },));
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
    return testWidget();
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
                  child: Text(item.title, style: TextStyle(fontSize: 40.0),),
                ),          
                // menu item description        
                Container(
                  height: 60,
                  child: 
                  Text(""),
                ),

                // menu item price
                Container(
                  width: 3000,
                  height: 60,
                  color: Colors.black38,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // + button
                      Container(
                        width: 45,
                        child: 
                          RaisedButton(
                            onPressed: (){
                              print("clicked ${id}");
                              appcontext.cart.plusItem(
                                appcontext.CartItem()
                                ..id = item.id
                                ..name = item.title
                                ..price = item.price
                                ..item = item
                                );
                                setState(() {
                                  
                                });
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
                              appcontext.cart.minusItem(
                                appcontext.CartItem()
                                ..id = item.id
                                ..name = item.title
                                ..price = item.price
                                ..item = item
                                );
                                setState(() {
                                  
                                });
                            },
                            child: Text("-"),
                          ),
                          
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30),
                        child: Text("${item.price}",style: TextStyle(fontSize: 40.0),textAlign: TextAlign.end,)
                      )
                    ],)
                  
                ),    
              ],)
          );
  }
  Widget testWidget() {

    return ListView.builder(
      itemCount: appcontext.todoMenus.length,
      itemBuilder: (context, index) {
        var item = appcontext.todoMenus[index];
        var title = item.title; 
        var id = item.id;
        
        return Container(
          height: 200,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          color: (index%2==0?Colors.red:Colors.blue),
          child: Row(

            mainAxisSize: MainAxisSize.min ,
            children: [
              //
              // Container(width: 200,height: 200, color: Colors.amber,),
              parts.ImageWithLoading(200,item.getImage),
              //
              //
              Expanded(child: menuItemWidget(id, item)),
            ],
          ),
        );     
      },);
  }
}
