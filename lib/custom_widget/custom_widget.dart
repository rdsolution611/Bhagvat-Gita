import 'package:flutter/material.dart';

import '../controller/controller.dart';

class CustomContainer extends StatelessWidget {
  final String first;
  final String second;
  CustomContainer({super.key, required this.first, required this.second});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        // border: Border.all(color: text),
        borderRadius: BorderRadius.circular(12),
        color: Color(0xff04879c),
      ),
      child: Column(
        children: [
          Text(
            first,
            style: TextStyle(
                fontSize: 20,
                color: Colors.tealAccent,
                fontWeight: FontWeight.w900,
                letterSpacing: 1),
          ),
          Divider(
            color: text,
            thickness: 1.5,
          ),
          Text(
            second,
            style: TextStyle(
                fontSize: 20,
                color: text,
                fontWeight: FontWeight.w900,
                letterSpacing: 2),
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 25,
          color: Colors.black,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
