import 'package:flutter/material.dart';
import 'package:uas00045/pages/listviewPage.dart';

// Deklarasi class HomePage sebagai StatefulWidget
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// Deklarasi state untuk HomePage
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Membuat tampilan Scaffold
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container untuk menampilkan informasi data mahasiswa
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.deepOrange,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    offset: const Offset(0, 2),
                    blurRadius: 7,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: const Column(
                children: [
                  SizedBox(height: 10),
                  // CircleAvatar untuk menampilkan foto mahasiswa
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(3),
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage:
                            AssetImage('assets/images/fotosaya.png'),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  // Menampilkan nama mahasiswa
                  Text(
                    'Bastian Nazaromi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Menampilkan NIM mahasiswa
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'NIM',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'A18.2023.00045',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  // Menampilkan Fakultas mahasiswa
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Fakultas',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Ilmu Komputer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            // Tombol untuk navigasi ke halaman ListviewPage
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          // Ketika tombol ditekan, aplikasi akan menuju ke halaman ListviewPage.
                          MaterialPageRoute(
                            builder: (context) => const ListviewPage(),
                          ));
                    },
                    child: const Text(
                      "Lihat Data",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
