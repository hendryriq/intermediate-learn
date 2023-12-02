import 'package:flutter/material.dart';
import 'package:intermediate_learn/sqflite_flutter/db_helper.dart';
import 'package:intermediate_learn/sqflite_flutter/list_pegawai.dart';
import 'package:intermediate_learn/sqflite_flutter/model_pegawai.dart';

class AlertAddPegawai extends StatefulWidget {

  final ModelPegawai? data;
  AlertAddPegawai({super.key, this.data});

  @override
  State<AlertAddPegawai> createState() => _AlertAddPegawaiState();
}

class _AlertAddPegawaiState extends State<AlertAddPegawai> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController emailId = TextEditingController();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  DatabaseHelper db = DatabaseHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.data != null){
      firstName = TextEditingController(text: widget.data?.firstName);
      lastName = TextEditingController(text: widget.data?.lastName);
      mobileNo = TextEditingController(text: widget.data?.mobileNo);
      emailId = TextEditingController(text: widget.data?.emailId);
    }

  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      scrollable: true,
      title: Center(child: Text(widget.data == null ? "Add pegawai" : "Update Pegawai")),
      content: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  validator: (val){
                    return val!.isEmpty ? "required" : null;
                  },
                  controller: firstName,
                  decoration: const InputDecoration(
                      hintText: "FIRSTNAME"
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  validator: (val){
                    return val!.isEmpty ? "required" : null;
                  },
                  controller: lastName,
                  decoration: const InputDecoration(
                      hintText: "LASTNAME"
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  validator: (val){
                    return val!.isEmpty ? "required" : null;
                  },
                  controller: mobileNo,
                  decoration: const InputDecoration(
                      hintText: "Mobile No"
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  validator: (val){
                    return val!.isEmpty ? "required" : null;
                  },
                  controller: emailId,
                  decoration: const InputDecoration(
                      hintText: "EMAIL"
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Center(
                  child: MaterialButton(
                    height: 45,
                    minWidth: 200,
                    onPressed: (){
                      if(key.currentState!.validate()){
                        if(widget.data == null){
                          print("save data");
                          db.saveData(ModelPegawai(firstName.text,
                              lastName.text, mobileNo.text, emailId.text))
                              .then((value){
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => const ListPegawai()),
                                    (route) => false);
                          });
                        }else{
                          print("edit data");
                          db.updatePegawai(ModelPegawai.fromMap({
                            "id": widget.data?.id,
                            "firstname": firstName.text,
                            "lastname": lastName.text,
                            "mobileno": mobileNo.text,
                            "emailid": emailId.text,

                          }))
                          .then((value){
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => const ListPegawai()),
                                    (route) => false);
                          });
                        }
                      }
                    },
                    color: Colors.green,
                    textColor: Colors.white,
                    child: Text(widget.data == null ? "SIMPAN" : "Update"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
