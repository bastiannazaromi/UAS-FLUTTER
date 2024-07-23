import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title; // Teks yang ditampilkan pada tombol
  final VoidCallback? onTap; // Fungsi yang akan dipanggil saat tombol ditekan

  const ButtonWidget({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Memanggil fungsi saat tombol ditekan
      child: Container(
        width:
            double.infinity, // Lebar tombol penuh di sepanjang sumbu horisontal
        height: 50, // Tinggi tombol
        decoration: BoxDecoration(
          color: Colors.deepOrange, // Warna latar belakang tombol
          borderRadius: BorderRadius.circular(5), // Radius sudut tombol
        ),
        child: Center(
          child: Text(
            title, // Menampilkan teks pada tombol
            style: const TextStyle(
              fontSize: 18, // Ukuran teks
              color: Colors.white, // Warna teks
              fontWeight: FontWeight.bold, // Ketebalan teks
            ),
          ),
        ),
      ),
    );
  }
}
