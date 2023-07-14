import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translation_vendor/screen/profile/edit_model.dart';
import 'package:translation_vendor/screen/profile/profilecontroller.dart';
import 'package:translation_vendor/static/button.dart';
import 'package:translation_vendor/static/dropdown.dart';
import 'package:translation_vendor/static/heading.dart';
import 'package:translation_vendor/static/image.dart';
import 'package:translation_vendor/static/imageinput.dart';
import 'package:translation_vendor/static/password.dart';
import 'package:translation_vendor/static/titletopbar.dart';
import 'package:translation_vendor/static/edit.dart';
import 'package:translation_vendor/static/inputfield.dart';
import 'package:translation_vendor/static/textbox.dart';
import 'package:translation_vendor/static/addpage.dart';
import 'package:translation_vendor/values/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:translation_vendor/values/controllers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:translation_vendor/values/language.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool showCreate2 = false;
  bool showCreate = false;
  bool show = false;

  switchfromlang(value) {
    setState(() {
      profileController.selectedLanguage = value as String;
      profileController.addLanguage();
      showCreate = !showCreate;
    });
  }

  fetchVendor() async {
    await profileController.getVendor();
    setState(() {});
  }

  @override
  void initState() {
    fetchVendor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ProfileController>(
          builder: (controller) => Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TitleTopbar(
                    text: 'Profile',
                    ontap: () {
                      Get.back();
                    },
                  ),
                  profileController.vendor == null
                      ? Container()
                      : Column(
                          children: [
                            SizedBox(
                              height: 12,
                            ),
                            InkWell(
                              onTap: () {
                                profileController.profileImage();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(55),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(45),
                                  child: profileController.profileimg!.path ==
                                          ''
                                      ? profileController.vendor!.profilepic ==
                                              ''
                                          ? Image.asset(
                                              'assets/images/5907.jpg',
                                              height: 90,
                                              width: 90,
                                            )
                                          : CachedNetworkImage(
                                              imageUrl: profileController
                                                  .vendor!.profilepic!,
                                              height: 90,
                                              width: 90,
                                            )
                                      : Image.file(
                                          File(profileController
                                              .profileimg!.path),
                                          height: 90,
                                          width: 90,
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              profileController.vendor!.name!,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            profileController.showNameField == false.obs
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Text(
                                          profileController.vendor!.username! +
                                              ' ',
                                          maxLines: null,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          profileController.openTextField();
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(40),
                                                ),
                                                color: Color.fromARGB(
                                                    255, 218, 211, 211)),
                                            child: SvgPicture.asset(
                                                'assets/images/edit.svg')),
                                      )
                                    ],
                                  )
                                : AutoSizeTextField(
                                    controller:
                                        profileController.userNameController,
                                    fullwidth: false,
                                    style: TextStyle(fontSize: 18),
                                    // maxLines: null,
                                    minWidth:
                                        MediaQuery.of(context).size.width * 0.3,
                                    decoration: InputDecoration(
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          profileController.EditText();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Icon(
                                            Icons.check,
                                            color: mainColor,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            EditPage(
                              title: 'About(English)',
                              onPressed: () {
                                profileController.openEngField();
                              },
                            ),
                            profileController.showEnglishField == false.obs
                                ? profileController.vendor!.aboutEng == ''
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Text(
                                          'About In english is empty. please write something about yourself in english.',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[400]),
                                        ),
                                      )
                                    : Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            padding:
                                                const EdgeInsets.only(top: 4),
                                            child: Text(
                                              profileController
                                                  .vendor!.aboutEng!,
                                              maxLines: null,
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                : AutoSizeTextField(
                                    controller: profileController
                                        .userEngAboutController,
                                    fullwidth: true,
                                    maxLines: null,
                                    style: TextStyle(fontSize: 18),
                                    decoration: InputDecoration(
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          profileController.EditEngAbout();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Icon(
                                            Icons.check,
                                            color: mainColor,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            EditPage(
                              title: 'About(Arabic)',
                              onPressed: () {
                                profileController.openArabicField();
                              },
                            ),
                            profileController.showArabicField == false.obs
                                ? profileController.vendor!.aboutArabic == ''
                                    ? Text(
                                        'About In Arabic is empty. please write something about yourself in Arabic.',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[400]),
                                      )
                                    : Row(
                                        children: [
                                          Text(
                                            profileController
                                                .vendor!.aboutArabic!,
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey[600]),
                                          ),
                                        ],
                                      )
                                : AutoSizeTextField(
                                    controller: profileController
                                        .userArabicAboutController,
                                    fullwidth: true,
                                    maxLines: null,
                                    style: TextStyle(fontSize: 18),
                                    decoration: InputDecoration(
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          profileController.EditArabicAbout();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Icon(
                                            Icons.check,
                                            color: mainColor,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            EditPage(
                              title: 'Mobile',
                              onPressed: () {
                                profileController.openNumberField();
                              },
                            ),
                            profileController.showNumberField == false.obs
                                ? profileController.vendor!.number == ''
                                    ? Text(
                                        'No! Mobile number avaliable.',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    : Row(
                                        children: [
                                          Text(
                                            profileController.vendor!.number!,
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey[600]),
                                          ),
                                        ],
                                      )
                                : AutoSizeTextField(
                                    controller:
                                        profileController.userNumberController,
                                    fullwidth: true,
                                    style: TextStyle(fontSize: 18),
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          profileController.EditNumber();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Icon(
                                            Icons.check,
                                            color: mainColor,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            ProfileHeading(
                              title: 'Certificate',
                              onPressed: () {
                                profileController.openCertificateField();
                              },
                            ),
                            profileController.certificateImage!.path == ''
                                ? profileController.vendor!.certificate == ''
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Text(
                                          'No! Certificate Avaliable. Upload your certicate so customer see this before order it may be helpful for you to get more orders.',
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[400]),
                                        ),
                                      )
                                    : Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/certificate.svg',
                                            height: 24,
                                            width: 24,
                                          ),
                                          Flexible(
                                            child: Container(
                                              padding: EdgeInsets.only(left: 6),
                                              child: InkWell(
                                                onTap: () {
                                                  Get.to(
                                                    () => FullScreenImagePage(
                                                      imageUrl:
                                                          profileController
                                                              .vendor!
                                                              .certificate!,
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  Uri.parse(profileController
                                                          .vendor!.certificate!)
                                                      .pathSegments
                                                      .last,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.grey[600]),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                : Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/certificate.svg',
                                        height: 24,
                                        width: 24,
                                      ),
                                      Flexible(
                                        child: Container(
                                          padding: EdgeInsets.only(left: 6),
                                          child: Text(
                                            profileController
                                                .certificateImage!.path,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey[600]),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                            profileController.showCertificateField == true.obs
                                ? Imageinput(
                                    labelText: 'Certificate',
                                    imageIcon: 'assets/images/image.svg',
                                    onpressed: () {
                                      profileController
                                          .selectcertificateImage();
                                    },
                                  )
                                : Container(),
                            ProfileHeading(
                              title: 'Language',
                              onPressed: () {
                                setState(() {
                                  showCreate = !showCreate;
                                  print(showCreate);
                                });
                              },
                            ),
                            showCreate == true
                                ? DropdownField(
                                    items: Languages(),
                                    text: 'Add Language',
                                    selectedvalue:
                                        authController.selectedLanguage,
                                    icon: ImageIcon(AssetImage(
                                        'assets/images/drop_arrow.png')),
                                    onChange: switchfromlang)
                                //  InputFields(
                                //     hint: 'Add language',
                                //     showSuffix: true,
                                //     controller:
                                //         profileController.languageController,
                                //     suffix: 'ADD',
                                //     onpressed: () {
                                //       profileController.addLanguage((success) {
                                //         if (success) {
                                //           setState(() {
                                //             showCreate = !showCreate;
                                //             print(showCreate);
                                //           });
                                //         }
                                //       });
                                //     },
                                //   )
                                : Container(),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 8),
                              width: double.infinity,
                              child: Wrap(
                                direction: Axis.horizontal,
                                runAlignment: WrapAlignment.start,
                                children: [
                                  for (var i = 0;
                                      i <
                                          profileController
                                              .vendor!.language!.length;
                                      i++)
                                    TextBox(
                                        title: profileController
                                            .vendor!.language![i]),
                                ],
                              ),
                            ),
                            ChangePassword(
                              title: 'Change Password',
                              onPressed: () {
                                ChangePasswords(context);
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: LargeButton(
                                title: "Update",
                                onPressed: () {
                                  profileController.editprofile();
                                },
                                textcolor: White,
                              ),
                            )
                          ],
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ChangePasswords(context) {
    Alert(context: context, content: EditModel(), buttons: [
      DialogButton(
          height: 0, color: White, onPressed: () async {}, child: Text(''))
    ]).show();
  }
}
