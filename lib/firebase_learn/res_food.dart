import 'package:firebase_database/firebase_database.dart';

class ResFood{
  String? key, namaMakanan, asalMakanan, latMakanan, lonMakanan, userId;

  ResFood(this.namaMakanan, this.asalMakanan, this.latMakanan, this.lonMakanan, this.userId);

  ResFood.fromSnapshoot(DataSnapshot snapshot){
    var map = snapshot.value as Map;
    key = snapshot.key;
    namaMakanan = map["namaMakanan"];
    asalMakanan = map["asalMakanan"];
    latMakanan = map["latMakanan"];
    lonMakanan = map["lonMakanan"];
    userId = map["userId"];
  }
  toJson(){
    return{
      "namaMakanan" : namaMakanan,
      "asalMakanan" : asalMakanan,
      "latMakanan" : latMakanan,
      "lonMakanan" : lonMakanan,
      "userId" : userId

    };
  }
}