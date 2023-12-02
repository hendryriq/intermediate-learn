class ModelPegawai{
  int? _id;
  String? _firstName, _lastName, _mobileNo, _emailId;

  ModelPegawai(this._firstName, this._lastName, this._mobileNo, this._emailId);

  int get id => _id ?? 0;
  String get firstName => _firstName ?? "";
  String get lastName => _lastName ?? "";
  String get mobileNo => _mobileNo ?? "";
  String get emailId => _emailId ?? "";

  Map<String, dynamic> toMap(){
    var map = <String, dynamic>{};
    if (_id !=null){
      map["id"] = _id;
    }

    map["firstname"] = _firstName;
    map["lastname"] = _lastName;
    map["mobileno"] = _mobileNo;
    map["emailid"] = _emailId;

    return map;
  }

  ModelPegawai.fromMap(Map<String, dynamic> map){
    _id = map["id"];
    _firstName = map["firstname"];
    _lastName = map["lastname"];
    _mobileNo = map["mobileno"];
    _emailId = map["emailid"];
  }
}