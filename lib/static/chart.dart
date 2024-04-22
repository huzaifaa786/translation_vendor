import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:translation_vendor/values/string.dart';

class ChartCards extends StatelessWidget {
  const ChartCards({
    Key? key,
    required this.msg,
    required this.name,
    required this.imgicon,
    this.onPressed,
    this.duration,
  }) : super(key: key);
  final msg;
  final name;
  final imgicon;
  final onPressed;
  final duration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: <Widget>[
            // ClipRRect(

            // borderRadius: BorderRadius.circular(40.0),
            // child: Image.network('http://10.0.2.2:8000/api/image',
            // height: 100,
            //   width:100,
            //    fit: BoxFit.cover,
            //       )),
            Container(
              width: 80,
              height: 80,
              margin: EdgeInsets.only(left: 15),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                // border: Border.all(width: 2, color: Color(0xFF34607),
                borderRadius: BorderRadius.circular(70),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(45),
                child: imgicon == ''
                    ? Image(
                        image: AssetImage('assets/images/Male User (1).png'),
                        // height: 200,
                        // width: 200,
                      )
                    : CachedNetworkImage(
                        imageUrl:
                            'https://translation.klickwash.net/' + imgicon,
                        height: 64,
                        width: 64,
                      ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          name,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14.0),
                        ),
                        // Text(
                        //   duration,
                        //   style: TextStyle(
                        //     color: Colors.black45,
                        //     fontSize: 12,
                        //     fontWeight: FontWeight.w700,
                        //   ),
                        // ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 9.0),
                      child: Text(
                        msg,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.black45,
                            fontSize: 14.0),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
