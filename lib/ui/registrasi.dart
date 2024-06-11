import 'package:flutter/material.dart';
import 'package:latihan1_jamil002/api.dart';
import 'package:latihan1_jamil002/db/database_helper.dart';
import 'package:latihan1_jamil002/ui/component.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registrasi extends StatefulWidget {
  const Registrasi({super.key});
  @override
  State<Registrasi> createState() => _RegistrasiState();
}

class _RegistrasiState extends State<Registrasi> {
  TextEditingController textNim = TextEditingController();
  TextEditingController textNama = TextEditingController();
  TextEditingController textEmail = TextEditingController();
  TextEditingController textPassword = TextEditingController();

  DatabaseHelper db = DatabaseHelper();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(flex: 2, child: Header()),
          Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: textNim,
                      decoration: const InputDecoration(hintText: "NIM"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: textNama,
                      decoration: const InputDecoration(hintText: "Nama"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: textEmail,
                      decoration: const InputDecoration(hintText: "Email"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: textPassword,
                      decoration: const InputDecoration(hintText: "Password"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          if (textNim.text.isEmpty ||
                              textPassword.text.isEmpty ||
                              textEmail.text.isEmpty ||
                              textNama.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Semua field harus diisi")));
                          } else {
                            Api()
                                .registrasi(
                                    nim: textNim.text,
                                    nama: textNama.text,
                                    email: textEmail.text,
                                    password: textPassword.text)
                                .then((value) async {
                              //handle success
                              final SharedPreferences sessionLogin =
                                  await SharedPreferences.getInstance();
                              sessionLogin.setString("nim", value['nim']);
                              sessionLogin.setString("token", value['token']);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Registrasi Berhasil"),
                                backgroundColor: Colors.green,
                              ));
                              Navigator.pushReplacementNamed(context, '/home');
                            }).catchError((error) {
                              //handle error
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    error.message.toString(),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            });
                          }
                        },
                        child: const Text("Submit"),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(
                        "Login Disini",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        headerTemplate(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Registrasi',
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                icon: const Icon(
                  Icons.home,
                  color: Colors.white,
                ))
          ],
        )),
        // Align(
        //   alignment: Alignment.topLeft,
        //   child:IconButton(icon: Icon(Icons.arrow_back),onPressed: () => Navigator.pop(context), color: Colors.white,) ,
        // ),
      ],
    );
  }
}
