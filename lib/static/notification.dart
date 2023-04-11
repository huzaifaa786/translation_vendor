import 'package:flutter/material.dart';
import 'package:translation_vendor/values/colors.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    this.image,
    this.title,
    this.day,
    this.ontap,
    this.name,
  });
  final name;
  final image;
  final title;
  final day;
  final ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        shadowColor: Colors.grey,
        elevation: 3,
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
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        child:
                            Image(image: AssetImage('assets/images/noti.png')),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 12),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Column(
                      
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins'),
                              maxLines: 2,
                            ),
                            SizedBox(height: 3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              
                              children: [
                                Text(
                                  name,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 182, 107, 102),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text('AED 56',style: TextStyle(
                                        fontSize: 13,
                                        color:mainColor,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins'),),
                                ),
                              ],
                            ),
                             Padding(
                               padding: const EdgeInsets.only(top: 4),
                               child: Text('Monday 12:00 PM 56',style: TextStyle(
                                        fontSize: 13,
                                        color:mainColor,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins'),),
                             ),
                          ],
                        ),
                      ),
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
