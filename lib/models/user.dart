class User {
  final int? id;
  final String nim;
  final String nama;
  final String jurusan;


  User({ this.id, required this.nim, required this.nama,required this.jurusan});

  factory User.fromJson(Map<String, dynamic> json) =>
      User(
        id: json["id"],
        nim: json["nim"],
        nama: json["nama"],
        jurusan: json["jurusan"],
      );

  Map<String, dynamic> toJson() => {
        "nim": nim,
        "nama": nama,
        "jurusan": jurusan,
      };

}
