import 'package:flutter/material.dart';

class ListData extends StatelessWidget {
  const ListData({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(children: [], mainAxisAlignment: MainAxisAlignment.center,)
            ],
          ),
        ),
      ),
    );
  }
}
