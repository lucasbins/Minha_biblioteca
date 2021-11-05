class Todo {
  int _id;
  String _title;
  String _autor;
  String _date;

  String _lido;

  Todo(this._title, this._date, this._lido,
      [this._autor]); // construtor do objeto
  Todo.comId(this._id, this._title, this._date, this._lido,
      [this._autor]); //construtor nomeado

  int get id => _id;

  String get title => _title;

  String get autor => _autor;

  String get date => _date;

  String get lido => _lido;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set description(String newDesc) {
    if (newDesc.length <= 255) {
      this._autor = newDesc;
    }
  }

  set lido(String newLido) {
    this._lido = newLido;
  }

  set date(String newDate) {
    this._date = newDate;
  }

  Map<String, dynamic> toMap() {
    //convete um obj para um mapa
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['desc'] = _autor;
    map['date'] = _date;
    map['lido'] = _lido;
    return map;
  }

  Todo.fromMapObject(Map<String, dynamic> map) {
    //Pega um mapa e convente para um obj.
    this._id = map['id'];
    this._title = map['title'];
    this._autor = map['desc'];
    this._date = map['date'];
    this._lido = map['lido'];
  }
}
