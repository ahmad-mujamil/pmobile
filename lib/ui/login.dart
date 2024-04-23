import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:latihan1_jamil002/db/database_helper.dart';
import 'package:latihan1_jamil002/models/user.dart';
import 'package:latihan1_jamil002/ui/component.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  TextEditingController textNim = TextEditingController();

  DatabaseHelper db = DatabaseHelper();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
  }
  resetText() {
    textNim.text = "";
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            const Expanded(flex : 2, child: Header() ),
            Expanded(flex : 3, child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                 
                children: [
                  TextFormField(
                    controller: textNim,
                    decoration:
                        InputDecoration(hintText: "Login Menggunakan NIM"),
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: (){
                        db.getUserByNim(textNim.text.trim()).then((value) async {
                          
                          if(value.length > 0)
                          {
                            final SharedPreferences sessionLogin = await SharedPreferences.getInstance();
                            sessionLogin.setString("auth",value[0].nim);
                            Navigator.pushNamed(context, '/home');
                          }else{
                            const snackBar = SnackBar(
                              content: Text('NIM Tidak Ditemukan'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                          
                        },);
                      }, 
                      child: Text("Login"),
                    ),
                  )
                ],),
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
        headerTemplate(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Login', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,color: Colors.white ),),
              IconButton(onPressed: () {}, icon: const Icon(Icons.login, color: Colors.white,))
            ],
          )
        ),
        // Align(
        //   alignment: Alignment.topLeft,
        //   child:IconButton(icon: Icon(Icons.arrow_back),onPressed: () => Navigator.pop(context), color: Colors.white,) ,
        // ),
      ],
    );
  }
}
