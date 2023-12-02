import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intermediate_learn/model/res_berita.dart';
import 'package:intermediate_learn/repository/repo_berita.dart';

class ProviderBerita extends ChangeNotifier{
  ProviderBerita(){
    getBerita();
  }
  ProviderBerita.iniBerita(){
    getBerita();
  }
  RepoBerita repo = RepoBerita();
  bool isLoading = false;
  List<Berita> listBerita = [];

  Future<void> getBerita() async{
    try{
      isLoading = true;
      notifyListeners();
      ResBerita? res = await repo.getBerita();
      if (res?.isSuccess == true){
        isLoading = false;
        listBerita = res?.data ?? [];
        notifyListeners();
      }
    }catch(e){
      isLoading = false;
      if (kDebugMode){
        print("Error bloc ${e.toString()}");
      }
      notifyListeners();
    }
  }
}