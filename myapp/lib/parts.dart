import 'package:flutter/material.dart';

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

