import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uas00045/utils/materialModel.dart';
import 'package:uas00045/widgets/buttonWidget.dart';
import 'package:http/http.dart' as client;

import '../utils/successModel.dart';

class EditPage extends StatefulWidget {
  final MaterialBarang materialBarang;
  final bool isFirebase;
  final String idFirebase;
  const EditPage({
    super.key,
    required this.materialBarang,
    required this.isFirebase,
    required this.idFirebase,
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController? kode_barang = TextEditingController();
  TextEditingController? nama = TextEditingController();
  TextEditingController? satuan = TextEditingController();
  TextEditingController? tanggal = TextEditingController();
  TextEditingController? stok = TextEditingController();
  TextEditingController? terjual = TextEditingController();

  @override
  void initState() {
    super.initState();
    kode_barang?.text = widget.materialBarang.kode_barang;
    nama?.text = widget.materialBarang.nama;
    satuan?.text = widget.materialBarang.satuan;
    tanggal?.text = widget.materialBarang.tanggal;
    stok?.text = widget.materialBarang.stok;
    terjual?.text = widget.materialBarang.terjual;
  }

  @override
  void dispose() {
    super.dispose();
    kode_barang?.dispose();
    nama?.dispose();
    satuan?.dispose();
    tanggal?.dispose();
    stok?.dispose();
    terjual?.dispose();
  }

  Future<SuccessModel> updateData() async {
    Map<String, dynamic> body = {
      "kode_barang": widget.materialBarang.kode_barang,
      "nama": nama?.text ?? '',
      "satuan": satuan?.text ?? '',
      "tanggal": tanggal?.text ?? '',
      "stok": stok?.text ?? '',
      "terjual": terjual?.text ?? '',
    };

    final response = await client.post(
      Uri.parse('http://192.168.21.55/ppb/edit.php'),
      body: body,
    );

    if (response.statusCode == 200) {
      return SuccessModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Update Data');
    }
  }

  void updateDataFirebase() async {
    var collection = FirebaseFirestore.instance.collection('materialbarang');
    collection.doc(widget.idFirebase).update({
      'nama': nama?.text,
      'satuan': satuan?.text,
      'tanggal': tanggal?.text,
      'stok': stok?.text,
      'terjual': terjual?.text,
    }).then((value) {
      updateData();

      Fluttertoast.showToast(
        msg: "Berhasil edit data",
        backgroundColor: Colors.black,
      );
      Navigator.pop(context);
    }).catchError((error) {
      Fluttertoast.showToast(
        msg: 'Gagal edit data',
        backgroundColor: Colors.redAccent,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Material Barang',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                "Nama Material",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: nama,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "nama material barang",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(217, 217, 217, 0.7),
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(217, 217, 217, 0.7),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Satuan",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: satuan,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "satuan",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(217, 217, 217, 0.7),
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(217, 217, 217, 0.7),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Tanggal",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: tanggal,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  hintText: "tanggal",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(217, 217, 217, 0.7),
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(217, 217, 217, 0.7),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Stok",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: stok,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "stok",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(217, 217, 217, 0.7),
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(217, 217, 217, 0.7),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Terjual",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: terjual,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "terjual",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(217, 217, 217, 0.7),
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(217, 217, 217, 0.7),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ButtonWidget(
                title: 'UPDATE',
                onTap: () async {
                  if (widget.isFirebase) {
                    updateDataFirebase();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
