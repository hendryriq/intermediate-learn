import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intermediate_learn/model/res_berita.dart';
import 'package:intermediate_learn/model/res_users.dart';

class RepoBerita {
  Future<ResBerita?> getBerita() async {
    try {
      http.Response res = await http.get(Uri.parse("http://192.168.0.167/beritadb/getBerita.php"));
      return resBeritaFromJson(res.body);
    } catch (e, st) {
      if (kDebugMode) {
        print("Error ${e.toString()}");
        print("Errorst ${st.toString()}");
      }
    }
  }

  Future<ResGetUsers?> getUsers(int id) async{
    try{
      http.Response res = await http.post(
          Uri.parse("http://192.168.0.167/beritadb/getUser.php"),
          body: {"id" : "$id"});
      return resGetUsersFromJson(res.body);
    }catch(e, st){
      if (kDebugMode){
        print ("Error ${e.toString()}");
        print("Errorst ${st.toString()}");
      }
    }
  }
}
