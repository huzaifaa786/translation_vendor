// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:translation_vendor/values/colors.dart';

class InputFields extends StatelessWidget {
  const InputFields(
      {Key? key,
      this.controller,
      this.hint,
      this.text,
      this.keyboardType,
      this.maxlines = false,
      this.enabled = true,
      this.readOnly = false,
      this.obscure = false,
      this.onChange,
      this.showSuffix = false,
      this.validator,
      this.autovalidateMode,
      this.validate,
      this.suffix,
      this.type = TextInputType.text,
      this.fontSize = 14.0,
      this.width = 0.98,
      this.onpressed})
      : super(key: key);

  final controller;
  final validator;
  final bool? validate;
  final hint;
  final keyboardType;
  final width;
  final type;
  final showSuffix;
  final suffix;
  final obscure;
  final text;
  final autovalidateMode;
  final maxlines;
  final onChange;
  final onpressed;
  final fontSize;
  final enabled;
  final readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width * width,
        child: TextFormField(
          readOnly: readOnly,
          onChanged: onChange,
          enabled: enabled,
          obscureText: obscure,
          controller: controller,
          style: TextStyle(fontSize: fontSize),
          keyboardType: type,
          validator: validator,
          // autovalidateMode: autovalidateMode ??
          //     (validate == true
          //         ? AutovalidateMode.always
          //         : AutovalidateMode.onUserInteraction),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hint,
            suffixIcon: showSuffix == true
                ? InkWell(
                    onTap: onpressed,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          suffix,
                          style: TextStyle(
                              color: mainColor, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  )
                : Container(),
            contentPadding: const EdgeInsets.only(left: 12.0, right: 12),
            hintStyle: TextStyle(color: hintColor),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey[500]!),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.grey[500]!),
              borderRadius: BorderRadius.all(Radius.circular(6)),
            ),
          ),
          cursorColor: Colors.black,
          maxLines: maxlines == true ? null : 1,
        ),
      ),
    );
  }
}
