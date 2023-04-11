import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Badgee extends StatelessWidget {
  const Badgee({
    Key? key,
    @required this.title,
    this.color,
    this.rounded = false,
    this.ontap,
  }) : super(key: key);
  final title;
  final color;
  final rounded;
  final ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: MediaQuery.of(context).size.width * 0.3,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(30)),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
