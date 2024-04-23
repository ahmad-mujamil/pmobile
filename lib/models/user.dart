class User {
  final int? id;
  final String nim;
  final String nama;
  final String jurusan;
  final String password;


  User({ this.id, required this.nim, required this.nama,required this.jurusan,required this.password});

  factory User.fromJson(Map<String, dynamic> json) =>
      User(
        id: json["id"],
        nim: json["nim"],
        nama: json["nama"],
        jurusan: json["jurusan"],
        password : json["password"],
      );

  Map<String, dynamic> toJson() => {
        "nim": nim,
        "nama": nama,
        "jurusan": jurusan,
        "password" : password,
      };

}
