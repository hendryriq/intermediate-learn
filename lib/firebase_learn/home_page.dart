import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intermediate_learn/firebase_learn/add_food_firebase.dart';
import 'package:intermediate_learn/firebase_learn/authentication.dart';
import 'package:intermediate_learn/firebase_learn/detail_food.dart';
import 'package:intermediate_learn/firebase_learn/login_signup_screen.dart';
import 'package:intermediate_learn/firebase_learn/res_food.dart';
import 'package:intermediate_learn/firebase_learn/root_page.dart';

class HomePage extends StatefulWidget {
  final String? userId;
  final BaseAuth? auth;
  final VoidCallback? onSignOut;
  const HomePage({super.key, this.userId, this.auth, this.onSignOut});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference? databaseReference;
  List<ResFood> listFood = [];
  Query? queryFood;
  StreamSubscription<DatabaseEvent>? onAddList;

  Future<void> getData() async {
    queryFood = database
        .ref()
        .child("kuliner")
        .orderByChild("userId")
        .equalTo(widget.userId);
    onAddList = queryFood?.onChildAdded.listen(updateList);
  }

  Future<void> updateList(DatabaseEvent event) async {
    setState(() {
      listFood.add(ResFood.fromSnapshoot(event.snapshot));
    });
  }

  Future<void> deleteFood(String key, int index) async{
    await databaseReference?.child("kuliner").child(key).remove();
    setState(() {
      listFood.removeAt(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    onAddList?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Food Apps",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        actions: [
          GestureDetector(
            onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          "Anda yakin ingin Logout??",
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
                                FirebaseAuth.instance.signOut();
                                // if(widget.onSignOut != null){
                                //   widget.onSignOut!();
                                // }
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (_) => LoginSignupPage()),
                                        (route) => false);
                              },
                              child: const Text("Logout"))
                        ],
                      );
                    });

            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
      body: listFood.isEmpty
          ? const Center(
              child: Text("Belum ada data"),
            )
          : ListView.builder(
              itemCount: listFood.length,
              itemBuilder: (context, index) {
                ResFood data = listFood[index];
                return ListTile(
                  onLongPress: () async{
                    await deleteFood(data.key ?? "", index).then((value){
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                          (route) => false);
                    });
                },
                  subtitle: Text("${data.lonMakanan}"),
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => DetailFood(data)));
                  },
                  title: Text("${data.namaMakanan}"),
                );
              },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          showDialog(context: context, builder: (context){
            return addFoodFirebase(userId: widget.userId);
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
