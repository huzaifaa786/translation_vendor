import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:translation_vendor/values/colors.dart';

class Badgee extends StatelessWidget {
  const Badgee({
    Key? key,
    @required this.title,
    this.color,
    this.rounded = false,
    this.ontap,
    this.icon,
    this.iconcolor,
    this.prefixicon,
  }) : super(key: key);
  final title;
  final color;
  final rounded;
  final ontap;
  final icon;
  final iconcolor;
  final prefixicon;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 35,
      // width: MediaQuery.of(context).size.width * 0.23,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      child: Center(
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/images/loading.svg",
              height: 18,
              width: 29,
              color: greenish,
            ),
            Text(
              title,
              style: TextStyle(
                  color: color, fontSize: 12, fontWeight: FontWeight.w400),
            ),
            SvgPicture.asset(
              icon,
              color: iconcolor,
              height: 13,
              width: 13,
            ),
          ],
        ),
      ),
    );
  }
}
