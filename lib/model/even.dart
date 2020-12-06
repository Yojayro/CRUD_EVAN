import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Even {
  String _id;
  String _name;
  String _code;
  String _description;
  String _sala;
  String _lugar;

  Even (this._id,this._name,this._code,this._description,this._lugar,this._sala);

  Even.map(dynamic obj) {
    this._name = obj['name'];
    this._code = obj['code'];
    this._description = obj['description'];
    this._lugar = obj['lugar'];
    this._sala = obj['sala'];

  }

  String get id => _id;
  String get name => _name;
  String get code => _code;
  String get description => _description;
  String get lugar => _lugar;
  String get sala => _sala;

  Even.fromSnapShop (DataSnapshot snapshot){
    _id = snapshot.key;
    _name = snapshot.value['name'];
    _code = snapshot.value['code'];
    _description = snapshot.value['description'];
    _lugar = snapshot.value['lugar'];
    _sala = snapshot.value['sala'];
  }

}