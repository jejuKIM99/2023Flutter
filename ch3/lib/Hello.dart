import 'package:flutter/material.dart';

class Hello extends StatefulWidget{
  late String title;
  int count = 0;

  Hello({super.key, required String title}){
    this.title = title;
  }

  State<Hello> createState() => _HelloState();
}

class _HelloState extends State<Hello> {
  String message = 'Hello World';
  //int count = 0;

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: TextStyle(fontSize: 50),
            ),
            Text(
              '${widget.count}',
              style: TextStyle(fontSize: 50),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ChangeCounter,
      ),
    );
  }

  void ChangeCounter(){
    setState(() {
      widget.count++;
    });
  }

  void ChangeMessage(){
    setState(() {
      message = "Hello World!!";
    });
  }
}