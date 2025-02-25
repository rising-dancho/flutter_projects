mixin Stats {
  int _points = 10;
  int _health = 10;
  int _attack = 10;
  int _defense = 10;
  int _skill = 10;

  // getters
  int get points => _points;

  // format: map, type: getter
  Map<String, int> get statsAsMap => {
        "health": _health,
        "attack": _attack,
        "defense": _defense,
        "skill": _skill,
      };

  // format: List of Maps, type: getter
  List<Map<String, String>> get statsAsFormatterList => [
        {"title": "health", "value": _health.toString()},
        {"title": "attack", "value": _attack.toString()},
        {"title": "defense", "value": _defense.toString()},
        {"title": "skill", "value": _skill.toString()},
      ];

  void increaseStats(String stat) {
    // check if there is available points
    if (_points > 0) {
      if (stat == "health") {
        _health++;
      }
      if (stat == "attack") {
        _attack++;
      }
      if (stat == "defense") {
        _defense++;
      }
      if (stat == "skill") {
        _skill++;
      }
    }
  }

  void decreaseStats(String stat) {
    // 5 is the minimum value for any stats
    if (stat == "health" && _health > 5) {
      _health--;
      _points++;
    }
    if (stat == "attack" && _attack > 5) {
      _attack--;
      _points++;
    }
    if (stat == "defense" && _defense > 5) {
      _defense--;
      _points++;
    }
    if (stat == "skill" && _skill > 5) {
      _skill--;
      _points++;
    }
  }
}
