class User {
  final int? id;
  final String nim;
  final String nama;
  final String jurusan;
  final String password;
  final String alamat;
  final String tglLahir;
  final String email;
  final String foto;

  User(
      {this.id,
      required this.nim,
      required this.nama,
      required this.jurusan,
      required this.password,
      required this.alamat,
      required this.tglLahir,
      required this.email,
      required this.foto});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        nim: json["nim"],
        nama: json["nama"],
        jurusan: json["jurusan"] ?? "",
        password: json["password"] ?? "",
        alamat: json["alamat"] ?? "",
        tglLahir: json["tgl_lahir"] ?? "",
        email: json["email"],
        foto: json["foto"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "nim": nim,
        "nama": nama,
        "jurusan": jurusan,
        "password": password,
        "alamat": alamat,
        "tgl_lahir": tglLahir,
        "email": email,
        "foto": foto
      };
}
