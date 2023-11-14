import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:translation_vendor/values/colors.dart';

class InputField1 extends StatelessWidget {
  const InputField1(
      {Key? key,
      this.controller,
      this.hint,
      this.text,
      this.color = Colors.white,
      this.obscure = false,
      this.maxlines = false,
      this.enabled = true,
      this.readOnly = false,
      this.onChange,
      this.imageIcon,
      this.validator,
      this.autovalidateMode,
      this.validate,
      this.icon,
      this.type = TextInputType.text,
      this.fontSize = 17.0,
      this.onpressed})
      : super(key: key);

  final controller;
  final validator;
  final validate;
  final obscure;
  final hint;
  final type;
  final imageIcon;
  final icon;
  final text;
  final autovalidateMode;
  final color;
  final maxlines;
  final onChange;
  final onpressed;
  final fontSize;
  final enabled;
  final readOnly;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: Color.fromRGBO(255, 255, 255, 1),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey[400]!,
            )),
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: mainColor,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: SvgPicture.asset(icon, height: 20, width: 20),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.72,
                child: TextFormField(
                  readOnly: readOnly,
                  enabled: enabled,
                  controller: controller,
                  style: TextStyle(fontSize: fontSize),
                  obscureText: obscure,
                  keyboardType: type,
                  validator: validator,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 4),
                    hintText: hint,
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    fillColor: color,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: color, width: 1.0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: color, width: 1.0),
                    ),
                  ),
                  cursorColor: Colors.black,
                  maxLines: maxlines == true ? null : 1,
                  autovalidateMode: autovalidateMode ??
                      (validate == true.obs
                          ? AutovalidateMode.always
                          : AutovalidateMode.onUserInteraction),
                )),
          ],
        ),
      ),
    );
  }
}
