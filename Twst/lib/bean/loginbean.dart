/// code : "1"
/// msg : {"name":"Jason","description":"提示，登录成功！"}

class Loginbean {
  Loginbean({
    String? code,
    Msg? msg,
  }) {
    _code = code;
    _msg = msg;
  }

  Loginbean.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'] != null ? Msg.fromJson(json['msg']) : null;
  }
  String? _code;
  Msg? _msg;
  Loginbean copyWith({
    String? code,
    Msg? msg,
  }) =>
      Loginbean(
        code: code ?? _code,
        msg: msg ?? _msg,
      );
  String? get code => _code;
  Msg? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    if (_msg != null) {
      map['msg'] = _msg?.toJson();
    }
    return map;
  }
}

/// name : "Jason"
/// description : "提示，登录成功！"

class Msg {
  Msg({
    String? name,
    String? description,
  }) {
    _name = name;
    _description = description;
  }

  Msg.fromJson(dynamic json) {
    _name = json['name'];
    _description = json['description'];
  }
  String? _name;
  String? _description;
  Msg copyWith({
    String? name,
    String? description,
  }) =>
      Msg(
        name: name ?? _name,
        description: description ?? _description,
      );
  String? get name => _name;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['description'] = _description;
    return map;
  }
}
