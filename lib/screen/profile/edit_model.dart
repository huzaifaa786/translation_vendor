import 'package:flutter/material.dart';
import 'package:translation_vendor/static/button.dart';
import 'package:translation_vendor/static/password_field_two.dart';
import 'dart:ui' as ui;

import 'package:translation_vendor/values/colors.dart';

class EditModel extends StatefulWidget {
  const EditModel({Key? key, }) : super(key: key);
  
  @override
  State<EditModel> createState() => _EditModelState();
}

class _EditModelState extends State<EditModel> {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();
  bool _passwordVisible = true;
  bool _newpasswordVisible = true;
  bool _cpasswordVisible = true;

  void _toggle() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _toggle1() {
    setState(() {
      _newpasswordVisible = !_newpasswordVisible;
    });
  }

  void _toggle2() {
    setState(() {
      _cpasswordVisible = !_cpasswordVisible;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 6),
         
          SizedBox(height: 4),
          InputFieldPasswordTwo(
            hint: 'Enter current password',
            toggle: _toggle,
            // imageIcon: 'assets/images/lock.svg',
            obscure: _passwordVisible,
            controller: currentPassword,
          ),
          SizedBox(height: 6),
         
          SizedBox(height: 4),
          InputFieldPasswordTwo(
            hint: 'Enter new password',
            toggle: _toggle1,
            // imageIcon: 'assets/images/lock.svg',
            obscure: _newpasswordVisible,
            controller: newPassword,
          ),
          SizedBox(height: 6),
        
          SizedBox(height: 4),
          InputFieldPasswordTwo(
            hint: 'Enter confirm new password',
            toggle: _toggle2,
            // imageIcon: 'assets/images/lock.svg',
            obscure: _cpasswordVisible,
            controller: confirmNewPassword,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: LargeButton(
              title: 'Change',
              textcolor: White,
              onPressed: ()  {
                
              },
            ),
          )
        ],
      ),
    );
  }
}
