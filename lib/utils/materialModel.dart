class MaterialBarang {
  final String kode_barang;
  final String nama;
  final String satuan;
  final String tanggal;
  final String stok;
  final String terjual;

  MaterialBarang({
    required this.kode_barang,
    required this.nama,
    required this.satuan,
    required this.tanggal,
    required this.stok,
    required this.terjual,
  });

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
