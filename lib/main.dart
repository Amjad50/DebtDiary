import 'package:debtdiary/DataBaseHandler.dart';
import 'package:debtdiary/Debt.dart';
import 'package:flutter/material.dart';

void main() async {
  all = await db.getAllDebts();
  runApp(MyApp());
}

DataBaseHandler db = DataBaseHandler();
List<Debt> all = [];

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
  int _id = all.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (selected) async {
              if (selected == 0) {
                await db.clearDataBase().then((_) {
                  db.getAllDebts().then((list) {
                    setState(() {
                      all = list;
                      _id = 0;
                    });
                  });
                });
              }
            },
            itemBuilder: (_) => <PopupMenuEntry<int>>[
                  PopupMenuItem(
                    child: Text("delete"),
                    value: 0,
                  )
                ],
          ),
        ],
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Center(
            child: Container(
          child: ListView(
            children: all.map((e) => e.getUIView()).toList(),
          ),
        )),
      ),
      floatingActionButton: FloatingActionButton(
        // TODO: dialog
        onPressed: () {
          db
              .insertDebt(Debt(
                  id: _id++, amount: -500, reason: "HiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHiHi", toPersonID: "welcome"))
              .then((e) {
            db.getAllDebts().then((list) {
              setState(() {
                all = list;
              });
            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
