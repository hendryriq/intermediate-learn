import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'res_food.dart';

class EditFoodFirebase extends StatefulWidget {
  final String? userId;
  const EditFoodFirebase({super.key, this.userId});

  @override
  State<EditFoodFirebase> createState() => _EditFoodFirebaseState();
}

class _EditFoodFirebaseState extends State<EditFoodFirebase> {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  TextEditingController nama = TextEditingController();
  TextEditingController asal = TextEditingController();
  TextEditingController lat = TextEditingController();
  TextEditingController lon = TextEditingController();

  Future<void> editKuliner() async{
    ResFood res = ResFood(nama.text, asal.text, lat.text, lon.text, widget.userId);
    await database.ref().child("kuliner").child(res.key ?? "").push().set(res.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Food",
        style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        iconTheme:  const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: nama,
                decoration: const InputDecoration(hintText: "FIRSTNAME"),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: asal,
                decoration: const InputDecoration(hintText: "LASTNAME"),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: lat,
                decoration: const InputDecoration(hintText: "MOBILE NUMBER"),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: lon,
                decoration: const InputDecoration(hintText: "EMAIL"),
              ),
              const SizedBox(
                height: 8,
              ),
              Center(
                child: MaterialButton(
                  height: 45,
                  minWidth: 200,
                  onPressed: (){},
                  color: Colors.green,
                  textColor: Colors.white,
                  child: const Text("UPDATE"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
