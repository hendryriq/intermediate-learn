import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AksesGambar extends StatefulWidget {
  const AksesGambar({super.key});

  @override
  State<AksesGambar> createState() => _AksesGambarState();
}

class _AksesGambarState extends State<AksesGambar> {
  XFile? image;


  Future<void> getFromKamera() async{
    var res = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(res !=null){
      setState(() {
        image = res;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Akses Gambar",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: image!= null
        ? Center(
        child: Image.file(
          File(image!.path),
          width: 250,
          height: 350,
        ),
      )
          :const Center(child: Text("Silahkan Pilih gambar")),
      floatingActionButton: FloatingActionButton(
          onPressed: () async{
            await getFromKamera();
          },
        child: const Icon(
          Icons.photo,
          color: Colors.green,
        ),
      ),
    );
  }
}
