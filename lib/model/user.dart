// ignore_for_file: unnecessary_getters_setters

class Usuario {
  String _name;
  String _number;
  String _email;
  String _password;

  Usuario(this._name, this._number, this._email, this._password);

  Map<String, dynamic> toMap(){ 
    Map<String, dynamic> map = {
      'nome': _name,
      'numero': _number,
      'email': _email
    };
    return map;
  }

  String get name => _name;
  set name(String value) {
    _name = value;
  }

  String get number => _number;
  set number(String value) {
    _number = value;
  }

  String get email => _email;
  set email(String value) {
    _email = value;
  }

  String get password => _password;
  set password(String value) {
    _password = value;
  }
}
