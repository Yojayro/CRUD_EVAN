import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app_evang/model/even.dart';

class EvenScreen extends StatefulWidget {
  final Even even;
  EvenScreen (this.even);
  @override
  _EvenScreenState createState() => _EvenScreenState();
}

final evenReference = FirebaseDatabase.instance.reference().child('even');

class _EvenScreenState extends State<EvenScreen> {

  List<Even> items;

  TextEditingController _nameController;
  TextEditingController _codeController;
  TextEditingController _descriptionController;
  TextEditingController _lugarController;
  TextEditingController _salaController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = new TextEditingController(text: widget.even.name);
    _codeController = new TextEditingController(text: widget.even.code);
    _descriptionController = new TextEditingController(text: widget.even.description);
    _lugarController = new TextEditingController(text: widget.even.lugar);
    _salaController = new TextEditingController(text: widget.even.sala);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Eventos'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        height: 570.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  style: TextStyle(fontSize: 17.0,color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(icon: Icon(Icons.person),
                  labelText: 'Name'),
                ),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                TextField(
                  controller: _codeController,
                  style: TextStyle(fontSize: 17.0,color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(icon: Icon(Icons.list),
                      labelText: 'codigo'),
                ),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                TextField(
                  controller: _descriptionController,
                  style: TextStyle(fontSize: 17.0,color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(icon: Icon(Icons.list),
                      labelText: 'descripcion'),
                ),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                TextField(
                  controller: _lugarController,
                  style: TextStyle(fontSize: 17.0,color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(icon: Icon(Icons.place),
                      labelText: 'Lugar'),
                ),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                TextField(
                  controller: _salaController,
                  style: TextStyle(fontSize: 17.0,color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(icon: Icon(Icons.home),
                      labelText: 'Sala'),
                ),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                FlatButton(onPressed: () {
                  if (widget.even.id != null) {
                    evenReference.child(widget.even.id).set({
                      'name': _nameController.text,
                      'code': _codeController.text,
                      'description': _descriptionController.text,
                      'lugar': _lugarController.text,
                      'sala': _salaController.text,
                    }).then((_) {
                      Navigator.pop(context);
                    });
                  } else {
                    evenReference.push().set({
                      'name': _nameController.text,
                      'code': _codeController.text,
                      'description': _descriptionController.text,
                      'lugar': _lugarController.text,
                      'sala': _salaController.text,

                    }).then((_) {
                      Navigator.pop(context);
                    });
                  }
                },
                child: (widget.even.id != null) ? Text('Update') : Text('Add')),


              ],
            ),
          ),
        ),
      ),
    );
  }
}

