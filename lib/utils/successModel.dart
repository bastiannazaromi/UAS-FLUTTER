class SuccessModel {
  final String
      status; // Status dari respons API (misalnya 'success' atau 'error')
  final String message; // Pesan dari respons API

  // Constructor untuk menginisialisasi semua properti
  SuccessModel({
    required this.status,
    required this.message,
  });

  // Factory constructor untuk membuat instance SuccessModel dari JSON
  factory SuccessModel.fromJson(Map<String, dynamic> json) {
    return SuccessModel(
      status: json['status'],
      message: json['message'],
    );
  }
}
