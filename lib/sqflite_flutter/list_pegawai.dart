import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intermediate_learn/sqflite_flutter/alert_add_pegawai.dart';
import 'package:intermediate_learn/sqflite_flutter/db_helper.dart';
import 'package:intermediate_learn/sqflite_flutter/edit_pegawai.dart';
import 'package:intermediate_learn/sqflite_flutter/model_pegawai.dart';

class ListPegawai extends StatefulWidget {
  const ListPegawai({super.key});

  @override
  State<ListPegawai> createState() => _ListPegawaiState();
}

class _ListPegawaiState extends State<ListPegawai> {
  DatabaseHelper db = DatabaseHelper();
  List<ModelPegawai> listPegawai = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db.getAllpegawai().then((value) {
      setState(() {
        for (var i in value!) {
          listPegawai.add(ModelPegawai.fromMap(i));
          if (kDebugMode) {
            print("data $listPegawai");
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "List Pegawai",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: listPegawai.length,
        itemBuilder: (context, index) {
          ModelPegawai data = listPegawai[index];
          return Card(
            child: ListTile(
              onLongPress: (){
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertAddPegawai(data: data);
                    });
              },
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          "Anda yakin akan menghapus data atas nama ${data.firstName} ${data.lastName}?",
                          style: const TextStyle(fontSize: 12),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                              onPressed: () {
                                db.deletePegawai(data.id).then((_) {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const ListPegawai()),
                                      (route) => false);
                                });
                              },
                              child: const Text("OK"))
                        ],
                      );
                    });
              },
              trailing: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => EditPegawai(data)));
                },
                child: Icon(Icons.edit) ,
              ),
              title: Text("${data.firstName} ${data.lastName}"),
              subtitle: Text(data.emailId),
              leading: Text("${data.id}"),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertAddPegawai();
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
