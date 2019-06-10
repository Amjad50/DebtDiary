import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // root
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Debt Diary',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MainPage(title: 'Debt Diary'),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            // TODO: add main page
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        // TODO implement click
      }, child: Icon(Icons.add),),
    );
  }
}
