// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:translation_vendor/values/colors.dart';

class DropdownField extends StatelessWidget {
  const DropdownField(
      {Key? key,
      this.controller,
      this.selectedvalue,
      this.text,
      this.icon,
      this.imageIcon,
      this.color = mainColor,
      this.items,
      this.maxlines = false,
      this.onChange,
      this.type = TextInputType.text,
      this.onpressed})
      : super(key: key);

  final controller;
  final List? items;
  final selectedvalue;
  final type;
  final text;
  final icon;
  final imageIcon;
  final color;
  final maxlines;
  final onChange;
  final onpressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
          items: items!
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
          value: selectedvalue,
          onChanged: (value) {
            onChange(value);
          },
          buttonStyleData: ButtonStyleData(
            height: 55,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 12, right: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.black26,
                ),
                color: White),
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          iconStyleData:
              IconStyleData(icon: Image.asset('assets/images/drop_arrow.png')),
        ),
      ),
    );
  }
}
