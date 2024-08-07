// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:translation_vendor/values/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatButton extends StatelessWidget {
  const ChatButton(
      {Key? key,
      @required this.title,
      @required this.onPressed,
      this.count,
      this.textcolor,
      this.icon,
      this.imgicon,
      this.iconTrue = true,
      this.screen = '',
      this.screenRatio = 0.9,
      this.rounded = false,
      this.color = mainColor})
      : super(key: key);

  final title;
  final count;
  final imgicon;
  final iconTrue;
  final onPressed;
  final screenRatio;
  final color;
  final textcolor;
  final icon;
  final rounded;
  final screen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: color,
            shadowColor: mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: rounded == true
                  ? BorderRadius.all(Radius.circular(10))
                  : BorderRadius.all(Radius.circular(10)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              screen == 'Chat'
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SvgPicture.asset(
                        "assets/images/chat.svg",
                        color: White,
                      ))
                  : Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SvgPicture.asset(
                          imgicon,
                          height: 27,
                          width: 27,
                        ),
                      ),
                    ),
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: textcolor,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: count != null
                        ? count != '0'
                            ? Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(count),
                              )
                            : Container()
                        : Container(),
                  )
                ],
              ),
              // Container(
              //   height: 40,
              //   width: 40,
              //   decoration: BoxDecoration(
              //     // border: Border.all(
              //     //   color: Colors.black,
              //     // ),
              //     borderRadius: BorderRadius.all(Radius.circular(45)),
              //     color: Colors.white,
              //   ),
              //   child: Icon(
              //     Icons.keyboard_arrow_right_outlined,
              //     color: Colors.black,
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
