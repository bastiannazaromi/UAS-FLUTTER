import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uas00045/pages/editPage.dart';
import 'package:uas00045/pages/tambahPage.dart';
import 'package:uas00045/utils/materialModel.dart';
import 'package:uas00045/utils/successModel.dart';
import 'package:uas00045/widgets/itemWidget.dart';

import 'package:http/http.dart' as client;

class ListviewPage extends StatefulWidget {
  const ListviewPage({super.key});

  @override
  State<ListviewPage> createState() => _ListviewPageState();
}

class _ListviewPageState extends State<ListviewPage> {
  Stream<QuerySnapshot>? materialBarangs =
      FirebaseFirestore.instance.collection('materialbarang').snapshots();

  Future<SuccessModel> deleteData(String kode_barang) async {
    final response = await client
        .post(Uri.parse('http://192.168.33.7/ppb/hapus.php'), body: {
      'kode_barang': kode_barang,
    });

    if (response.statusCode == 200) {
      return SuccessModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Delete Data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Firebase & MYSQL Database',
        ),
      ),
      body: StreamBuilder(
        stream: materialBarangs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          }

          if (snapshot.hasData == false) {
            return const Center(
              child: Text("Data tidak ditemukan"),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("Data tidak ditemukan"),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ItemWidget(
                kode_barang: data['kode_barang'],
                nama: data['nama'],
                satuan: data['satuan'],
                tanggal: data['tanggal'],
                stok: data['stok'],
                terjual: data['terjual'],
                onDelete: () {
                  document.reference.delete();
                  deleteData(data['kode_barang']);
                  Fluttertoast.showToast(
                    msg: 'Berhasil hapus data',
                    backgroundColor: Colors.black,
                  );
                },
                onEdit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPage(
                        materialBarang: MaterialBarang(
                          kode_barang: data['kode_barang'],
                          nama: data['nama'],
                          satuan: data['satuan'],
                          tanggal: data['tanggal'],
                          stok: data['stok'],
                          terjual: data['terjual'],
                        ),
                        isFirebase: true,
                        idFirebase: document.reference.id,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const TambahPage(
                isFirebase: true,
              ),
            ),
          );
        },
      ),
    );
  }
}
