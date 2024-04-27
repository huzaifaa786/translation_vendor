// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:translation_vendor/values/colors.dart';

class TitleTopbar extends StatelessWidget {
  const TitleTopbar({
    super.key,
    this.text,
    this.ontap,
    this.height = 0.2,
  });
  final text;
  final ontap;
  final height;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        height: MediaQuery.of(context).size.height * height,
        decoration: BoxDecoration(
          color: greenish,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(13),
              bottomRight: Radius.circular(13)),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: ontap,
                  child: Container(
                    margin: EdgeInsets.only(left: 10, top: 14),
                    decoration: BoxDecoration(
                      color: White,
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
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                  color: White,
                ),
              ),
            )

            // Text(
            //   '..........',
            //   style: TextStyle(color: greenish),
            // )
          ],
        ),
      ),
    );
  }
}
