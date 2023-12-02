import 'package:flutter/material.dart';
import 'package:intermediate_learn/sqflite_flutter/list_pegawai.dart';
import 'package:intermediate_learn/sqflite_flutter/model_pegawai.dart';
import 'package:intermediate_learn/sqflite_flutter/db_helper.dart';

class EditPegawai extends StatefulWidget {
  final ModelPegawai data;
  const EditPegawai(this.data,{super.key});

  @override
  State<EditPegawai> createState() => _EditPegawaiState();
}

class _EditPegawaiState extends State<EditPegawai> {
  DatabaseHelper db = DatabaseHelper();
  TextEditingController? firstName, lastName, mobileNo, emailId;
  GlobalKey<FormState> key = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Pegawai",
          style: TextStyle(color:  Colors.white),
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
                controller: firstName,
                decoration: const InputDecoration(hintText: "FIRSTNAME"),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: lastName,
                decoration: const InputDecoration(hintText: "LASTNAME"),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: mobileNo,
                decoration: const InputDecoration(hintText: "MOBILE NUMBER"),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: emailId,
                decoration: const InputDecoration(hintText: "EMAIL"),
              ),
              const SizedBox(
                height: 8,
              ),
              Center(
                child: MaterialButton(
                  height: 45,
                  minWidth: 200,
                  onPressed: (){
                    db.updatePegawai(ModelPegawai.fromMap({
                      "id": widget.data.id,
                      "firstname": firstName?.text,
                      "lastname": lastName?.text,
                      "mobileno": mobileNo?.text,
                      "emailid": emailId?.text,

                    }))
                        .then((_) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ListPegawai()),
                              (route) => false);
                    });
                  },
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
