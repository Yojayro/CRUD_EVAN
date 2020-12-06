import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:flutter_app_evang/ui/even_screen.dart';
import 'package:flutter_app_evang/ui/even_information.dart';
import 'package:flutter_app_evang/model/even.dart';


class ListViewEven extends StatefulWidget {
  @override
  _ListViewEvenState createState() => _ListViewEvenState();
}

final evenReference = FirebaseDatabase.instance.reference().child('even');

class _ListViewEvenState extends State<ListViewEven> {

  List<Even> items;
  StreamSubscription<Event> _onEvenAddSubscription;
  StreamSubscription<Event> _onEvenChangedSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items = new List();
    _onEvenAddSubscription = evenReference.onChildAdded.listen(_onEvenAdd);
    _onEvenChangedSubscription = evenReference.onChildChanged.listen(_onEvenUpdate);


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onEvenAddSubscription.cancel();
    _onEvenChangedSubscription.cancel();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Even DB',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Eventos Iglesia'),
            centerTitle: true,
            backgroundColor: Colors.orangeAccent,
          ),
          body: Center(
            child: ListView.builder(
                itemCount: items.length,
            padding: EdgeInsets.only(top: 12.0),
            itemBuilder: (context, position) {
              return Column(
                children: <Widget>[
                  Divider(height: 7.0,),
                  Row(
                    children: <Widget>[
                      Expanded(child: ListTile(title: Text(
                        '${items[position].name}',
                        style: TextStyle(
                          color: Colors.indigoAccent,
                          fontSize: 21.0,
                        ),
                      ),
                          subtitle:
                          Text('${items[position].description}',
                            style: TextStyle(
                              color: Colors.indigoAccent,
                              fontSize: 21.0,
                            ),
                          ),
                          leading: Column(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.amberAccent,
                                radius: 17.0,
                                child: Text('${position+1}',
                                  style: TextStyle(
                                    color: Colors.indigoAccent,
                                    fontSize: 21.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onTap: () =>
                              _navigateToEven(context, items[position])),),
                      IconButton(
                          icon: Icon(Icons.delete, color: Colors.red,),
                          onPressed: () =>
                              _deleteEven(context, items[position], position)),
                      IconButton(
                          icon: Icon(Icons.edit, color: Colors.black26,),
                          onPressed: () =>
                              _navigateToEvenInformation(context, items[position])),
                    ],
                  ),
                ],
              );
            }
                          ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add, color: Colors.white,),
            backgroundColor: Colors.deepOrangeAccent,
            onPressed: () => _createNewEven (context),
          ),
        ),
    );


  }

  void _onEvenAdd (Event event){
    setState(() {
      items.add(new Even.fromSnapShop(event.snapshot));
    });
  }

  void _onEvenUpdate (Event event){
    var oldEvenValue = items.singleWhere((even) => even.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldEvenValue)] = new Even.fromSnapShop(event.snapshot);

    });
  }
  void _deleteEven (BuildContext context, Even even, int position)async {
    await evenReference.child(even.id).remove().then((_){
      setState(() {
        items.removeAt(position);
      });
    });

  }
  void _navigateToEvenInformation(BuildContext context, Even even)async {
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) => EvenScreen(even)),
    );
  }


  }
  void _navigateToEven (BuildContext context, Even even)async {
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) => EvenInformation(even)),
    );
  }
  void _createNewEven (BuildContext context)async {
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) => EvenScreen(Even(null,'','','','',''))),
    );
  }

