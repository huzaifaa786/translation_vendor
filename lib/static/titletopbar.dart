// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

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
        padding: const EdgeInsets.only(top: 25, right: 2, left: 2 ,bottom: 10),
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
                      Radius.circular(45),
                    ),
                ),
                child: Icon(
                  Icons.keyboard_arrow_left_outlined,
                ),
              ),
            ),
            Text(
              text,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 19,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text('')
          ],
        ),
      ),
    );
  }
}
