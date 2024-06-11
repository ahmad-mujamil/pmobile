import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latihan1_jamil002/api.dart';
import 'package:latihan1_jamil002/db/database_helper.dart';
import 'package:latihan1_jamil002/models/user.dart';
import 'package:latihan1_jamil002/ui/component.dart';

class Bio extends StatefulWidget {
  const Bio({super.key});

  @override
  State<Bio> createState() => _BioState();
}

class _BioState extends State<Bio> {
  User? authUser;

  DatabaseHelper db = DatabaseHelper();
  @override
  void initState() {
    super.initState();
    getAuth();
  }

  TextEditingController textNim = TextEditingController();
  TextEditingController textNama = TextEditingController();
  TextEditingController textEmail = TextEditingController();
  TextEditingController textJurusan = TextEditingController();
  TextEditingController textTglLahir = TextEditingController();
  TextEditingController textAlamat = TextEditingController();
  String foto = "";

  DateTime selectedDate = DateTime.now();
  getAuth() async {
    Api().getUserByNim().then((value) {
      User user = User.fromJson(value);
      authUser = user;
      textNim.text = user.nim;
      textNama.text = user.nama;
      textEmail.text = user.email;
      textJurusan.text = user.jurusan;
      if (user.tglLahir != "") {
        var parsedDate = DateTime.parse(user.tglLahir);
        textTglLahir.text =
            "${parsedDate.day}/${parsedDate.month}/${parsedDate.year}";
        selectedDate = parsedDate;
      }

      foto = user.foto;

      textAlamat.text = user.alamat;
      setState(() {});
    });
    // db.getUserByNim(sessionLogin.getString("auth")!).then((value) {
    //   authUser = value[0];
    //   setState(() {});
    // });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1945, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        textTglLahir.text =
            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
        setState(() {});
      });
    }
  }

  String selectedImagePath = '';
  final ImagePicker _picker = ImagePicker();
  pickImage() async {
    var file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
    );

    if (file != null) {
      foto = "";
      selectedImagePath = file.path;
      setState(() {});
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (textAlamat.text.isEmpty ||
              textTglLahir.text.isEmpty ||
              textEmail.text.isEmpty ||
              textJurusan.text.isEmpty ||
              textNim.text.isEmpty ||
              textNama.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Data Tidak Boleh Kosong"),
              ),
            );
          } else {
            Api()
                .updateProfileDio(
              id: authUser!.id.toString(),
              nim: textNim.text,
              email: textEmail.text,
              jurusan: textJurusan.text,
              alamat: textAlamat.text,
              tglLahir:
                  "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
              nama: textNama.text,
              foto: selectedImagePath,
            )
                .then((value) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Berhasil Update Profile"),
                  backgroundColor: Colors.green,
                ),
              );
            });
          }
        },
        label: const Text("Update Bio"),
        icon: const Icon(Icons.send),
      ),
      body: (authUser == null)
          ? const SizedBox()
          : Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      headerTemplate(const SizedBox()),
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                          color: Colors.white,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 150,
                          height: 150,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              InkWell(
                                onTap: () {
                                  pickImage();
                                },
                                child: (foto != "")
                                    ? Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(foto),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: (selectedImagePath == "")
                                                ? const AssetImage(
                                                    'assets/IMG_2441.jpg')
                                                : AssetImage(
                                                    File(selectedImagePath)
                                                        .path),
                                          ),
                                        ),
                                      ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: Container(
                                    margin: const EdgeInsets.all(8.0),
                                    decoration: const BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          authUser!.nama,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: textNim,
                                    decoration: const InputDecoration(
                                      hintText: "NIM",
                                      label: Text("NIM"),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: textNama,
                                    decoration: const InputDecoration(
                                      hintText: "Nama",
                                      label: Text("Nama"),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                    controller: textEmail,
                                    decoration: const InputDecoration(
                                      hintText: "Email",
                                      label: Text("Email"),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                      controller: textJurusan,
                                      decoration: const InputDecoration(
                                        hintText: "Jurusan",
                                        label: Text("Jurusan"),
                                      )),
                                  const SizedBox(height: 10),
                                  InkWell(
                                    onTap: () => _selectDate(context),
                                    child: TextFormField(
                                        enabled: false,
                                        controller: textTglLahir,
                                        decoration: const InputDecoration(
                                          hintText: "Tgl Lahir",
                                          label: Text("Tgl Lahir"),
                                        )),
                                  ),
                                  const SizedBox(height: 10),
                                  TextFormField(
                                      controller: textAlamat,
                                      decoration: const InputDecoration(
                                        hintText: "Alamat",
                                        label: Text("Alamat"),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  const ProfileInfoRow({super.key});

  final List<ProfileInfoItem> _items = const [
    ProfileInfoItem("Posts", 900),
    ProfileInfoItem("Followers", 120),
    ProfileInfoItem("Following", 200),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      constraints: const BoxConstraints(maxWidth: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _items
            .map((item) => Expanded(
                    child: Row(
                  children: [
                    if (_items.indexOf(item) != 0) const VerticalDivider(),
                    Expanded(child: _singleItem(context, item)),
                  ],
                )))
            .toList(),
      ),
    );
  }

  Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.value.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Text(
            item.title,
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
      );
}

class ProfileInfoItem {
  final String title;
  final int value;
  const ProfileInfoItem(this.title, this.value);
}
