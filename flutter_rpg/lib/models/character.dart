import 'package:flutter_rpg/models/stats.dart';

class Character with Stats {
  // fields
  final String name;
  final String slogan;
  final String id;
  bool _isFav = false;

  // constructor
  Character({required this.name, required this.slogan, required this.id});

  // getter: [syntax: get getter_variable => _private_variable] 
  // explanation: asigning the private_variable into the getter_variable
  bool get isFav => _isFav;

  void toggleIsFav() {
    _isFav = !_isFav;
  }
}
