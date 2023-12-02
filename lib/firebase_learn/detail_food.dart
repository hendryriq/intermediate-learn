import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intermediate_learn/firebase_learn/home_page.dart%20';
import 'package:intermediate_learn/firebase_learn/res_food.dart';
import '';

class DetailFood extends StatefulWidget {
  final ResFood? data;
  const DetailFood(this.data, {super.key});

  @override
  State<DetailFood> createState() => _DetailFoodState();
}

class _DetailFoodState extends State<DetailFood> {
  TextEditingController? nama, asal, lat, lon;
  final FirebaseDatabase database = FirebaseDatabase.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nama = TextEditingController(text: widget.data?.namaMakanan);
    asal = TextEditingController(text: widget.data?.asalMakanan);
    lat = TextEditingController(text: widget.data?.latMakanan);
    lon = TextEditingController(text: widget.data?.lonMakanan);
  }

  Future<void> updateFood(ResFood food) async {
    food.namaMakanan = nama?.text;
    food.asalMakanan = asal?.text;
    food.latMakanan = lat?.text;
    food.lonMakanan = lon?.text;
    food.userId = widget.data?.userId;
    await database
        .ref()
        .child("kuliner")
        .child(food.key!)
        .set(food.toJson())
        .then((_) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update Food",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.green),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: Colors.green),
                ),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      double.parse(widget.data?.latMakanan ?? ""),
                      double.parse(widget.data?.lonMakanan ?? ""),
                    ),
                    zoom: 16,
                  ),
                  mapType: MapType.normal,
                  markers: {
                    Marker(
                        markerId: const MarkerId("Udacoding"),
                        position: LatLng(
                          double.parse(widget.data?.latMakanan ?? ""),
                          double.parse(widget.data?.lonMakanan ?? ""),
                        ),
                        infoWindow: InfoWindow(
                            title: "${widget.data?.namaMakanan}",
                            snippet: "${widget.data?.asalMakanan}"))
                  },
                ),
              ),
              TextFormField(
                controller: nama,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: asal,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: lat,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: lon,
              ),
              const SizedBox(
                height: 8,
              ),
              Center(
                child: MaterialButton(
                  onPressed: () async {
                    await updateFood(widget.data!);
                  },
                  color: Colors.green,
                  height: 45,
                  minWidth: 200,
                  textColor: Colors.white,
                  child: const Text(
                    "Update",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
