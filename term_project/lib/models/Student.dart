class Student{
  int? id;
  String? username;
  String? password;

  Student({this.id,required this.username,required this.password});

  Map<String, dynamic> toMap(){
    var map = new Map<String,dynamic>();
    map["username"] = this.username;
    map["password"] = this.password;
    if(id != null){
      map["Id"] = this.id;
    }
    return map;
  }

  Student.fromJsonObject(dynamic o){
    // this.id = int.tryParse(o["id"]);
    this.id = o["id"];
    this.username = o["username"].toString();
    this.password = o["password"].toString();
  }
}