import 'package:flutter/material.dart';
class HomePage extends StatefulWidget
{
  @override
  State<HomePage> createState() 
  {
    return HomePageState();
  }
}
class HomePageState extends State<HomePage>
{
  int cont = 0;
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(title: Text("Página Inicial"),),
      body: Container(
        height: 100,
        width: 100,
        color: Colors.black,
        child: Center(
            child: Container(
              height: 50,
              width: 50,
              color: Colors.red),
        )
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () { 
            setState(() {
              cont++;
            });
           },
        ),
    );
  }
}