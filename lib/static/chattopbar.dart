import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:translation_vendor/screen/chat/chats.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:translation_vendor/values/colors.dart';

class ChatTopBar extends StatelessWidget {
  const ChatTopBar({
    Key? key,
    this.name,
    this.image,
    this.color,
  }) : super(key: key);
  final name;
  final image;
  final color;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Get.height * 0.2 / 1.2,
        decoration: BoxDecoration(color: greenish),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Chats_screen()));
                      },
                      child: SvgPicture.asset(
                        "assets/images/back.svg",
                        height: 33,
                      )),
                ],
              ),
              Row(
                children: [
                  Gap(20),
                  Container(
                    width: 55,
                    height: 55,
                    margin: EdgeInsets.only(left: 12),
                    // padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      // border: Border.all(width: 2, color: Color(0xFF34607B)),
                      border: Border.all(width: 2, color: White),
                      borderRadius: BorderRadius.circular(70),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: image == 'https://translation.ezmoveportal.com/'
                          ? Image(
                              image: AssetImage('assets/images/Male User.png'),
                              height: 64,
                              width: 64,
                              color: White,
                            )
                          : CachedNetworkImage(
                              imageUrl: image,
                              height: 64,
                              width: 64,
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      name,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: White),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
