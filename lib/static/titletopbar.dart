// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:translation_vendor/values/colors.dart';

class TitleTopbar extends StatelessWidget {
  const TitleTopbar({
    super.key,
    this.text,
    this.ontap,
  });
  final text;
  final ontap;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.only(top: 12, right: 2, left: 2 ,bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: ontap,
              child: Container(
                decoration: BoxDecoration(
                 border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(60),
                    ),
                ),
                child: Icon(
                   size: 28,
                  Icons.keyboard_arrow_left_outlined,
                  
                ),
              ),
            ),
            Text(
              text,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 21,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text('..........',style: TextStyle(color: White),)
          ],
        ),
      ),
    );
  }
}
