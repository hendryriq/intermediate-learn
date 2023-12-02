import 'package:flutter/material.dart';
import 'package:intermediate_learn/UI/uiberita/screen_user.dart';
import 'package:intermediate_learn/model/res_berita.dart';
import 'package:intermediate_learn/provider_berita/provider_berita.dart';
import 'package:provider/provider.dart';

class ScreenBerita extends StatelessWidget {
  const ScreenBerita({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return ProviderBerita();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "List Berita",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ScreenUser()));
                },
                icon: const Icon(Icons.person))
          ],
        ),
        body: Consumer<ProviderBerita>(
          builder: (BuildContext context, value, Widget? child) {
            return value.isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  )
                : ListView.builder(
                    itemCount: value.listBerita.length,
                    itemBuilder: (context, index) {
                      Berita data = value.listBerita[index];
                      return Column(
                        children: [
                          // Image.network(
                          //   "${data.gambarBerita}",
                          //   height: 250,
                          //   fit: BoxFit.fitWidth,
                          // ),
                          ListTile(
                            title: Text("${data.judul}"),
                          ),
                        ],
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
