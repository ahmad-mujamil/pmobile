import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:latihan1_jamil002/db/database_helper.dart';
import 'package:latihan1_jamil002/models/user.dart';
import 'package:latihan1_jamil002/ui/component.dart';


class Crud extends StatefulWidget {
  const Crud({super.key});
  @override
  State<Crud> createState() => _CrudState();
}

class _CrudState extends State<Crud> {

  getUser() {
    db.getUsers().then((value) {
        print(value);
        dataUsers = value;
        setState(() {
          
        });
      });
  }

  TextEditingController textNim = TextEditingController();
  TextEditingController textNama = TextEditingController();
  TextEditingController textJurusan = TextEditingController();
  TextEditingController textPassword = TextEditingController();

  List<User> dataUsers = [];
  DatabaseHelper db = DatabaseHelper();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  resetText() {
    textJurusan.text = "";
    textNama.text = "";
    textNim.text = "";
    textPassword.text = "";
  }

  formDialog (BuildContext context, int tipe, int? userId) async {

  return await showDialog(
    barrierDismissible: false,
    context: context,builder: (context) {

        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(

            content: Form(
              
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: textNim,
                      decoration:
                          const InputDecoration(hintText: "NIM"),
                    ),
                    TextFormField(
                      controller: textNama,
                      decoration:
                          const InputDecoration(hintText: "Nama"),
                    ),
                    TextFormField(
                      controller: textJurusan,
                      decoration:
                          const InputDecoration(hintText: "Jurusan"),
                    ),
                    TextFormField(
                      obscureText: true,
                      controller: textPassword,
                      decoration:
                          const InputDecoration(hintText: "Password"),
                    ),
                  ],
                )),
            title: Text((tipe== 0 ? 'Tambah Data' : 'Edit Data')),
            actions: <Widget>[
              InkWell(
                child: const Text("Cancel",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                onTap: () {
                  resetText();
                  Navigator.pop(context);
                },
              ),
              InkWell(
                child: Text((tipe== 0 ? 'Simpan Data' : 'Update Data'),
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),),
                onTap: () {
                  User user = User(nim: textNim.text, nama: textNama.text, jurusan: textJurusan.text,password: textPassword.text);
                  if(tipe==0) {
              
                    db.createUser(user).then((value) {
                      getUser(); 
                  
                    });
                  }else {
                    db.updateUser(user,userId!).then((value) => getUser());
                  }
                  resetText();
                  Navigator.pop(context);
                },
              ),
              
            ],
          );
        });
    });      
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(onPressed: () async {
        formDialog(context,0,0);
      },child: const Icon(Icons.add),),
      body: Column(
          children: [
            const Expanded(flex : 2, child: Header() ),
            Expanded(flex : 3, child: Column( 
              children: [
                const Text('Data User', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,)),
                Expanded(
                  child: ListView.builder(
                    itemCount: dataUsers.length,
                    itemBuilder: (context, index) => 
                      ListTile(

                          title: Text(dataUsers[index].nama),
                          subtitle: Text(dataUsers[index].nim),
                          leading: const Icon(Icons.person),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(icon : const Icon(Icons.edit), onPressed: () {
                                textNim.text = dataUsers[index].nim;
                                textNama.text = dataUsers[index].nama;
                                textJurusan.text = dataUsers[index].jurusan;
                                textPassword.text = dataUsers[index].password;
                                formDialog(context,1,dataUsers[index].id);
                              }),
                              IconButton(icon: const Icon(Icons.delete),
                                onPressed: () {
                                db.deleteUser(dataUsers[index]).then((value) => getUser()) ;
                                resetText();
                              }),
                            ],
                          )
                          
                        ),
                    )
                  ),
              ],)),
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
              const Text('CRUD', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,color: Colors.white ),),
              IconButton(onPressed: () {}, icon: const Icon(Icons.stacked_bar_chart, color: Colors.white,))
            ],
          )
        ),
        Align(
          alignment: Alignment.topLeft,
          child:IconButton(icon: Icon(Icons.arrow_back),onPressed: () => Navigator.pop(context), color: Colors.white,) ,
        ),
      ],
    );
  }
}
