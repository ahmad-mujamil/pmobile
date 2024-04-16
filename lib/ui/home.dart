import 'package:flutter/material.dart';
import 'package:latihan1_jamil002/ui/component.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: const Column(
          children: [
            Expanded(flex : 2, child:  Header()),
            Expanded(flex : 3, child:  Menu()),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return headerTemplate(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Latihan Mobile App', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,color: Colors.white ),),
          IconButton(onPressed: () {
            const snackBar = SnackBar(
              content: Text('By Ahmad Mujamil - 2301011002'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }, icon: Icon(Icons.info, color: Colors.white,))
        ],
      )
    );
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     Text('Latihan Mobile App', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, ),),
    //     IconButton(onPressed: () {
    //       const snackBar = SnackBar(
    //         content: Text('By Ahmad Mujamil - 2301011002'),
    //       );
    //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //     }, icon: Icon(Icons.info))
    //   ],
    // );
  }
}

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            menuButton("Bio Data",'/bio',Icons.person,context),
            menuButton("Galery", '/galery',Icons.image, context)
          ],
        ),
      
      ],
    );
  }
}
 
 
