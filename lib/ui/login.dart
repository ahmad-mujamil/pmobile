import 'package:flutter/material.dart';
import 'package:latihan1_jamil002/api.dart';
import 'package:latihan1_jamil002/db/database_helper.dart';
import 'package:latihan1_jamil002/ui/component.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController textNim = TextEditingController();
  TextEditingController textPassword = TextEditingController();

  DatabaseHelper db = DatabaseHelper();
  @override
  void initState() {
    super.initState();
  }

  resetText() {
    textNim.text = "";
    textPassword.text = "";
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
                              textPassword.text.isEmpty) {
                            const snackBar = SnackBar(
                              content: Text('Data Tidak Boleh Kosong'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            Api()
                                .login(
                                    nim: textNim.text,
                                    password: textPassword.text)
                                .then((value) async {
                              final SharedPreferences sessionLogin =
                                  await SharedPreferences.getInstance();
                              sessionLogin.setString("nim", value['nim']);
                              sessionLogin.setString("token", value['token']);
                              if (!context.mounted) return;
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Login Berhasil"),
                                backgroundColor: Colors.green,
                              ));
                              Navigator.pushNamed(context, '/home');
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
                          // db.getUserByNim(textNim.text.trim()).then(
                          //   (value) async {
                          //     if (value.isNotEmpty) {
                          //       final SharedPreferences sessionLogin =
                          //           await SharedPreferences.getInstance();
                          //       sessionLogin.setString("auth", value[0].nim);
                          //       Navigator.pushNamed(context, '/home');
                          //     } else {
                          //       const snackBar = SnackBar(
                          //         content: Text('NIM Tidak Ditemukan'),
                          //       );
                          //       ScaffoldMessenger.of(context)
                          //           .showSnackBar(snackBar);
                          //     }
                          //   },
                          // );
                        },
                        child: const Text("Login"),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/registrasi');
                      },
                      child: const Text(
                        "Registrasi Disini",
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
              'Login',
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.login,
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
