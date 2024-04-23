import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:latihan1_jamil002/db/database_helper.dart';
import 'package:latihan1_jamil002/models/user.dart';
import 'package:latihan1_jamil002/ui/component.dart';
import 'package:shared_preferences/shared_preferences.dart';


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
    // TODO: implement initState
    super.initState();
    getAuth();
    
  }

  getAuth() async {
    final SharedPreferences sessionLogin = await SharedPreferences.getInstance();
    db.getUserByNim(sessionLogin.getString("auth")!).then((value) {
      authUser = value[0];
      setState(() {
        
      });
    });
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (authUser==null) ? SizedBox() : Column(
        children: [
          const Expanded(flex: 2, child: HeaderBio()),
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
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton.extended(
                        onPressed: () {},
                        heroTag: 'nim',
                        elevation: 0,
                        label: Text("NIM : ${authUser!.nim}",style: TextStyle(fontWeight: FontWeight.bold),),
                      ),
                      const SizedBox(width: 16.0),
                      FloatingActionButton.extended(
                        onPressed: () {},
                        heroTag: 'jurusan',
                        elevation: 0,
                        backgroundColor: Colors.green,
                        label: Text(authUser!.jurusan,style: TextStyle(fontWeight: FontWeight.bold),),
                    
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const _ProfileInfoRow()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({Key? key}) : super(key: key);

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
            style: Theme.of(context).textTheme.caption,
          )
        ],
      );
}

class ProfileInfoItem {
  final String title;
  final int value;
  const ProfileInfoItem(this.title, this.value);
}

class HeaderBio extends StatelessWidget {
  const HeaderBio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        headerTemplate(SizedBox()),
        Align(
          alignment: Alignment.topLeft,
          child:IconButton(icon: Icon(Icons.arrow_back),onPressed: () => Navigator.pop(context), color: Colors.white,) ,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            'assets/IMG_2441.jpg')),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
