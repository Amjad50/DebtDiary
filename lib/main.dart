import 'package:debtdiary/DataBaseHandler.dart';
import 'package:debtdiary/Debt.dart';
import 'package:debtdiary/UI/NewDialog.dart';
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
  // use the next id after the largest
  int _id = all.length > 0
      ? all.reduce((d1, d2) => d1.id > d2.id ? d1 : d2).id + 1
      : 0;

  @override
  Widget build(BuildContext context) {
    void _showNewDialog() {
      showDialog<Debt>(
        context: context,
        builder: (buildingContext) {
          return NewDebtDialog(id: _id++);
        },
      ).then((value) {
        print(value);
        if (value != null) {
          db.insertDebt(value).then((e) {
            db.getAllDebts().then((list) {
              setState(() {
                all = list;
              });
            });
          });
        }
      });
    }

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
        onPressed: () {
          _showNewDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
