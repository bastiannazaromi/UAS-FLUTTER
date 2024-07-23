class MaterialBarang {
  final String kode_barang; // Kode unik barang
  final String nama; // Nama barang
  final String satuan; // Satuan barang (misal: kg, liter)
  final String tanggal; // Tanggal masuknya barang
  final String stok; // Jumlah stok barang
  final String terjual; // Jumlah barang yang terjual

  // Constructor untuk menginisialisasi semua properti
  MaterialBarang({
    required this.kode_barang,
    required this.nama,
    required this.satuan,
    required this.tanggal,
    required this.stok,
    required this.terjual,
  });

  // Factory constructor untuk membuat instance MaterialBarang dari JSON
  factory MaterialBarang.fromJson(Map<String, dynamic> json) {
    return MaterialBarang(
      kode_barang: json['kode_barang'],
      nama: json['nama'],
      satuan: json['satuan'],
      tanggal: json['tanggal'],
      stok: json['stok'],
      terjual: json['terjual'],
    );
  }

  // Method untuk mengubah instance MaterialBarang menjadi Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'kode_barang': kode_barang,
      'nama': nama,
      'satuan': satuan,
      'tanggal': tanggal,
      'stok': stok,
      'terjual': terjual,
    };
  }
}
