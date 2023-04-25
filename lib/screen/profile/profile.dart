import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translation_vendor/screen/profile/edit_model.dart';
import 'package:translation_vendor/static/button.dart';
import 'package:translation_vendor/static/imageinput.dart';
import 'package:translation_vendor/static/password.dart';
import 'package:translation_vendor/static/titletopbar.dart';
import 'package:translation_vendor/static/edit.dart';
import 'package:translation_vendor/static/inputfield.dart';
import 'package:translation_vendor/static/textbox.dart';
import 'package:translation_vendor/static/addpage.dart';
import 'package:translation_vendor/values/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool showCreate2 = false;
  bool showCreate = false;
  bool show = false;
  XFile? image = XFile('');
  selectimage() async {
    print('dsff');
    final ImagePicker _picker = ImagePicker();
    var image1 = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = image1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TitleTopbar(
                text: 'Profile',
                ontap: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 12,),
              Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(45),
                    ),
                  ),
                  child: Image.asset('assets/images/profile.png')),
              SizedBox(
                height: 12,
              ),
              Text(
                'Waston',
                style: TextStyle(
                  fontFamily: 'Mazzard',
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Waston ',
                    style: TextStyle(
                      fontFamily: 'Mazzard',
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                          color: Color.fromARGB(255, 218, 211, 211)),
                      child: SvgPicture.asset('assets/images/edit.svg')),
                ],
              ),
              EditPage(
                title: 'About(English)',
              ),
              Text(
                'Lorem ipsum dolor sit amet, consectetur\n adipiscing elit. Vitae amet placerat dignissim nibh\n dictum sit. Pretium ornare viverra.',
                style: TextStyle(
                  fontFamily: 'Mazzard',
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
              EditPage(
                title: 'About(Arabic)',
              ),
              Text(
                'Lorem ipsum dolor sit amet, consectetur\n adipiscing elit. Vitae amet placerat dignissim nibh\n dictum sit. Pretium ornare viverra.',
                style: TextStyle(
                  fontFamily: 'Mazzard',
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
              EditPage(
                title: 'Mobile',
              ),
              Row(
                children: [
                  Text(
                    '+3942398345',
                    style: TextStyle(
                      fontFamily: 'Mazzard',
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              AddPage(
                title: 'Certificate',
                onPressed: () {
                  print(showCreate);
                  setState(() {
                    showCreate2 = !showCreate2;
                    print(showCreate);
                  });
                },
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/certificate.svg',
                    height: 24,
                    width: 24,
                  ),
                  Text(
                    ' Lorem ipsum dolor sit ',
                    style: TextStyle(
                      fontFamily: 'Mazzard',
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              showCreate2 == true
                  ? Imageinput(
                      labelText: 'Certificate',
                      imageIcon: 'assets/images/image.svg',
                      onpressed: () {
                        selectimage();
                      },
                    )
                  : Container(),
              AddPage(
                title: 'Language',
                onPressed: () {
                  print(showCreate);
                  setState(() {
                    showCreate = !showCreate;
                    print(showCreate);
                  });
                },
              ),
              showCreate == true
                  ? InputFields(
                      hint: 'Add language',
                      showSuffix: true,
                      suffix: 'ADD',
                      onpressed: () {},
                    )
                  : Container(),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextBox(
                    title: 'English',
                  ),
                  TextBox(
                    title: 'Arabic',
                  ),
                  TextBox(
                    title: 'Persion',
                  ),
                ],
              ),
              ChangePassword(
                title: 'Change Password',
                onPressed: (){ChangePasswords(context);},
              ),
              SizedBox(
                height: 15,
              ),
              LargeButton(
                title: "Update",
                onPressed: () {},
                textcolor: White,
              )
            ],
          ),
        ),
      )),
    );
  }
   ChangePasswords(context) {
    Alert(context: context, content: EditModel(), buttons: [
      DialogButton(
          height: 0, color: White, onPressed: () async {}, child: Text(''))
    ]).show();
  }
}
