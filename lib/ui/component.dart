import 'package:flutter/material.dart';

Widget menuButton (String text, String url, IconData icon, BuildContext context) {
  return Center(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, url),
        child: Card(
          child: Container(
            height: 90,
            width: (MediaQuery.of(context).size.width-60)/2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon),
                Text(text),
              ],
            ),
          ),
        ),
      ),
    );
}

Widget headerTemplate(Widget widget) {
  return Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0xff0043ba), Color(0xff006df1)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),

              child: widget
        );
}