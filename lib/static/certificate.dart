// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Certificateinput extends StatelessWidget {
  const Certificateinput(
      {Key? key,
      this.controller,
      this.hint,
      this.labelText,
      this.icon,
      this.imageIcon,
      this.obscure = false,
      this.toggle,
      this.onChange,
      this.validator,
      this.validate,
      this.autovalidateMode,
      this.type = TextInputType.text,
      this.onpressed})
      : super(key: key);

  final controller;
  final validator;
  final RxBool? validate;
  final autovalidateMode;
  final obscure;
  final hint;
  final type;
  final labelText;
  final icon;
  final imageIcon;
  final toggle;
  final onChange;
  final onpressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 16),
            child: TextFormField(
              controller: controller,
              validator: validator,
              autovalidateMode: autovalidateMode ??
                  (validate == true.obs
                      ? AutovalidateMode.always
                      : AutovalidateMode.onUserInteraction),
              decoration: InputDecoration(
                fillColor: Colors.grey,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
                hoverColor: Colors.grey,
                focusColor: Colors.grey,
                labelText: labelText,
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    "assets/images/certificate.svg",
                  ),
                ),
                hintText: hint,
                hintStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    color: Colors.grey[500]),
                suffixIcon: InkWell(
                  onTap: onpressed,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: SvgPicture.asset(
                      'assets/images/upload.svg',
                      height: 17,
                      width: 17,
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
    // return Container(
    //     margin: EdgeInsets.only(top: 20),
    //     child: TextFormField(
    //       controller: controller,
    //       decoration: InputDecoration(
    //         fillColor: Colors.grey,
    //         border: OutlineInputBorder(),
    //         hoverColor: Colors.grey,
    //         focusColor: Colors.grey,
    //         labelText: hint,
    //         hintText: hint,
    //         suffixIcon: FittedBox(
    //           fit: BoxFit.scaleDown,
    //           child: SvgPicture.asset(
    //             'assets/images/image.svg',
    //             height: 17,
    //             width: 17,
    //           ),
    //         ),
    //       ),
    //       keyboardType: type,
    //       cursorColor: Colors.black,
    //       obscureText: obscure,
    //       maxLines: 1,
    //       validator: validator,
    //       autovalidateMode: autovalidateMode ??
    //           (validator == true.obs
    //               ? AutovalidateMode.always
    //               : AutovalidateMode.onUserInteraction),
    //     ));
  }
}
