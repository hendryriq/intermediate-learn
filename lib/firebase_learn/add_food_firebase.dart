import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intermediate_learn/firebase_learn/home_page.dart';
import 'package:intermediate_learn/firebase_learn/res_food.dart';

class addFoodFirebase extends StatefulWidget {
  final String? userId;
  const addFoodFirebase({super.key, this.userId});

  @override
  State<addFoodFirebase> createState() => _addFoodFirebaseState();
}

class _addFoodFirebaseState extends State<addFoodFirebase> {

  final FirebaseDatabase database = FirebaseDatabase.instance;
  TextEditingController nama = TextEditingController();
  TextEditingController asal = TextEditingController();
  TextEditingController lat = TextEditingController();
  TextEditingController lon = TextEditingController();

  Future<void> addKuliner() async{
    ResFood res = ResFood(nama.text, asal.text, lat.text, lon.text, widget.userId);
    await database.ref().child("kuliner").child(res.key ?? "").push().set(res.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Center(child: Text("Add Food ")),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: nama,
              decoration: const InputDecoration(hintText: "Nama Makanan"),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: asal,
              decoration: const InputDecoration(hintText: "Asal Makanan"),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: lat,
              decoration: const InputDecoration(hintText: "Latitude"),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: lon,
              decoration: const InputDecoration(hintText: "Longitude"),
            ),
            const SizedBox(
              height: 8,
            ),
            Center(
              child: MaterialButton(
                color: Colors.green,
                height: 45,
                minWidth: 200,
                textColor: Colors.white,
                onPressed: () async {
                  if (nama.text.isEmpty ||
                      asal.text.isEmpty ||
                      lat.text.isEmpty ||
                      lon.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Form wajib diisi semua"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }else{
                    await addKuliner().then((value){
                      Navigator.pop(context);
                      // Navigator.pushAndRemoveUntil(
                      //   context,
                      //   MaterialPageRoute(builder: (_) => const HomePage()),
                      //   (route) => false);
                    });

                  }
                },
                child: const Text("SIMPAN"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
