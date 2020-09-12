import 'package:flutter/material.dart';
import './assets.dart' as assets;
import './client.dart' as client;


class CartItem {
  String id;
  String name;
  int price;
  // ...
  client.Item item;
}

class Cart {
  Map<String,CartItem>  items = {};
  addItem(CartItem item) {
    items[item.id] = item;
  }
  bool contain(String id){
    return items.containsKey(id);
  }

}

// Beak Time ..

//
// golobal prop
List<client.Item> __todoMenus;
Cart __cart = new Cart();

void main() async {
  // test 
  __todoMenus = await client.createMenuClient().getMenus();

  runApp( MaterialApp(
    home: MyApp()
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
    var itemIds =  __cart.items.keys.toList();
    var items = itemIds.map((e) => menuItemWidget(screenWidth,__cart.items[e].item)).toList();
   // var items = itemIds.map((e) => Text("${__cart.items[e].name}")).toList();

    return Scaffold(
      appBar: AppBar(title: Text("Cart!!"),),
      body:
      SingleChildScrollView(
        child: Column(
          children: /*[
            titleWidget(),
            Container(
              child: Column(
                children: items,
              ),
            ),
            RaisedButton(onPressed: (){
              print("order");
            }, child: Text("Order!!"),)
            ]*/
            items,

        ),
      )
    );
  }

  Widget itemList() {
    var items =  __cart.items.keys.toList();
    return 
    ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
      return Text("${__cart.items[items[index]].name}");
    },);
    //Text("Bucket !!");
  }
}

Widget menuItemWidget(double screenWidth, client.Item item){
  print(">>${screenWidth}");
  var info = Container(
    width: screenWidth-200,
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
            ImageWithLoading(100,item.getImage),
            info
          ],
        ));
}

//
// Start and Menus Page
//
class MyApp extends StatelessWidget {
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
                return MyBasket();
              },));
          })
        ],
      ),
      body: testWidget(),
    );
  }
}


Widget testWidget() {
  return ListView.builder(
    itemCount: __todoMenus.length,
    itemBuilder: (context, index) {
      var item = __todoMenus[index];
      var title = item.title; 
      var id = item.id;
      
      return Container(
        height: 200,
        color: (index%2==0?Colors.red:Colors.blue),
        child: Row(

          mainAxisSize: MainAxisSize.min ,
          children: [
            //
            // Container(width: 200,height: 200, color: Colors.amber,),
            ImageWithLoading(200,item.getImage),
            //
            //
            Expanded(child: 
            //Container(height: 200,color: Colors.white30, child: Text("xx"),),),            
             Container(
              color: Colors.white30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    color: Colors.black38,
                    child: Text("Food Name",style: TextStyle(fontSize: 40.0),),
                  ),                  
                  Container(
                    height: 60,
                    child: 
                    Text("desciption. asdfasdf.asdfa.sf..asdfasf,as ,asfd ,asf, asf,d a,sd,f "),
                  ),
                  Container(
                    width: 3000,
                    height: 60,
                    color: Colors.black38,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                         RaisedButton(
                            onPressed: (){
                              print("clicked ${id}");
                              __cart.addItem(
                                CartItem()
                                ..id = item.id
                                ..name = item.title
                                ..price = item.price
                                ..item = item
                                );
                            },
                            child: Icon(
                              Icons.add_shopping_cart,
                              color: Colors.pink,
                              size: 24.0,
                            ),
                         ),
                        Text("800",style: TextStyle(fontSize: 40.0),textAlign: TextAlign.end,),
                      ],)
                     
                  ),    
                ],)
            )),
          ],
        ),
      );     
    },);
}

typedef ImageGetFunction = Future<Image> Function();
class ImageWithLoading extends StatefulWidget {
  ImageGetFunction f;
  int size;
  ImageWithLoading(this.size, this.f) {
  }

  @override
  _ImageWithLoadingState createState() => _ImageWithLoadingState();
}


class _ImageWithLoadingState extends State<ImageWithLoading> {
  @override
  Widget build(BuildContext context) {
    var f  = this.widget.f;
    return Container(
        padding: EdgeInsetsDirectional.zero,
        margin: EdgeInsetsDirectional.zero,
        color: Colors.green,
        child: FutureBuilder<Image>(
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return  Container(
              width: this.widget.size.toDouble(),
              height: this.widget.size.toDouble(),
              child: snapshot.data
            );          
          }
          else if(snapshot.hasError) {
            return Text("??");
          }
          else {
            return Text("..");
          }
        },
        future: this.widget.f()
      ),
    );
  }
}