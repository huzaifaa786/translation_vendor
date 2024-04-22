import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:translation_vendor/values/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    this.image,
    this.title,
    this.day,
    this.price,
    this.ontap,
    this.name,
    this.scheduletype,
  });
  final name;
  final price;
  final image;
  final title;
  final day;
  final ontap;
  final scheduletype;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        shadowColor: Colors.grey,
        elevation: 1,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(6, 10, 6, 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: image == ''
                            ? Image(
                                image: AssetImage(
                                    'assets/images/Male User (1).png'),
                                height: 65,
                                width: 65,
                              )
                            : CachedNetworkImage(
                                imageUrl: image,
                                height: 65,
                                width: 65,
                              ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 12),
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    name,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: notiNameCOlor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  // price != ''
                                  //     ? Padding(
                                  //         padding:
                                  //             const EdgeInsets.only(top: 4),
                                  //         child: Text(
                                  //           'AED ' + price,
                                  //           style: TextStyle(
                                  //               fontSize: 13,
                                  //               color: mainColor,
                                  //               fontWeight: FontWeight.w500),
                                  //         ),
                                  //       )
                                  //     : Container(),
                                ],
                              ),

                              Text(scheduletype,style: TextStyle(),),
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: greenish,
                                ),
                                maxLines: 2,
                              ),
                              SizedBox(height: 3),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        "assets/images/calendar.svg"),
                                    Text(
                                      day,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: hintColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
