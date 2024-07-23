import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uas00045/widgets/buttonWidget.dart';
import 'package:http/http.dart' as client;

import '../utils/successModel.dart';

// Deklarasi class TambahPage sebagai StatefulWidget
class TambahPage extends StatefulWidget {
  final bool
      isFirebase; // Parameter untuk menentukan apakah menggunakan Firebase
  const TambahPage({super.key, required this.isFirebase});

  @override
  State<TambahPage> createState() => _TambahPageState();
}

// Deklarasi state untuk TambahPage
class _TambahPageState extends State<TambahPage> {
  TextEditingController? kode_barang;
  TextEditingController? nama;
  TextEditingController? satuan;
  TextEditingController? tanggal;
  TextEditingController? stok;
  TextEditingController? terjual;

  @override
  void initState() {
    super.initState();
    // Inisialisasi TextEditingController untuk masing-masing field input
    kode_barang = TextEditingController();
    nama = TextEditingController();
    satuan = TextEditingController();
    tanggal = TextEditingController();
    stok = TextEditingController();
    terjual = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    // Dispose controller untuk menghindari memory leaks
    kode_barang?.dispose();
    nama?.dispose();
    satuan?.dispose();
    tanggal?.dispose();
    stok?.dispose();
    terjual?.dispose();
  }

  // Fungsi untuk menambah data ke server menggunakan HTTP POST request
  Future<SuccessModel> addData() async {
    Map<String, dynamic> body = {
      "kode_barang": kode_barang?.text ?? '',
      "nama": nama?.text ?? '',
      "satuan": satuan?.text,
      "tanggal": tanggal?.text,
      "stok": stok?.text,
      "terjual": terjual?.text,
    };

    final response = await client.post(
      Uri.parse('http://192.168.33.7/ppb/tambah.php'),
      body: body,
    );

    if (response.statusCode == 200) {
      return SuccessModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Simpan Data');
    }
  }

  // Fungsi untuk menambah data ke Firebase Firestore
  void addDataFirebase() async {
    var collection = FirebaseFirestore.instance.collection('materialbarang');
    collection.add({
      'kode_barang': kode_barang?.text,
      'nama': nama?.text,
      'satuan': satuan?.text,
      'tanggal': tanggal?.text,
      'stok': stok?.text,
      'terjual': terjual?.text,
    }).then((value) {
      addData(); // Panggil fungsi addData untuk menyimpan data ke server lokal

      Fluttertoast.showToast(msg: "Berhasil Tambah Material Barang");
      Navigator.pop(
          context); // Kembali ke halaman sebelumnya setelah data berhasil ditambahkan
    }).catchError((onError) {
      Fluttertoast.showToast(
          msg: 'Gagal Tambah Material Barang',
          backgroundColor: Colors.redAccent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Material Barang',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Input field untuk Kode Barang
              const Text(
                "Kode Barang",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: kode_barang,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "kode barang",
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
              // Input field untuk Nama Material Barang
              const Text(
                "Nama Material Barang",
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
              // Input field untuk Satuan
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
              // Input field untuk Tanggal
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
              // Input field untuk Stok
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
              // Input field untuk Terjual
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
              // Button untuk menambah data
              ButtonWidget(
                title: 'TAMBAH',
                onTap: () async {
                  if (kode_barang!.text.isEmpty &&
                      nama!.text.isEmpty &&
                      satuan!.text.isEmpty &&
                      tanggal!.text.isEmpty &&
                      stok!.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: 'Harap isi semua field yang ada',
                        backgroundColor: Colors.redAccent);
                  }

                  if (kode_barang!.text.isNotEmpty &&
                      nama!.text.isNotEmpty &&
                      satuan!.text.isNotEmpty &&
                      tanggal!.text.isNotEmpty &&
                      stok!.text.isNotEmpty) {
                    if (widget.isFirebase) {
                      addDataFirebase();
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
