import 'package:flutter/material.dart';
import './assets.dart' as assets;
import './client.dart' as client;


List<client.Item> todoMenus;

class Cart {
  List<client.Item> items = [];
}



void main() async {
  // test 
  todoMenus = await client.createMenuClient().getMenus();

  runApp( MaterialApp(
    home: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
      ),
      body: testWidget(),
    );
  }
}


Widget testWidget() {
  return ListView.builder(
    itemCount: todoMenus.length,
    itemBuilder: (context, index) {
      var item = todoMenus[index];
      var title = item.title; 
      
      return Container(
        height: 200,
        color: (index%2==0?Colors.red:Colors.blue),
        child: Row(

          mainAxisSize: MainAxisSize.min ,
          children: [
            //
            // Container(width: 200,height: 200, color: Colors.amber,),
            ImageWithLoading(item.getImage),
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
                    child:
                     Text("800",style: TextStyle(fontSize: 40.0),textAlign: TextAlign.end,),
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
  ImageWithLoading(this.f) {
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
              width: 200,
              height: 200,
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