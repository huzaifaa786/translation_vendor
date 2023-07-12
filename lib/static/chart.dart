import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChartCards extends StatelessWidget {
  const ChartCards( {Key? key,
      required this.msg,
      required this.name,
      required this.imgicon,
      this.onPressed,
      })
      : super(key: key);
  final  msg;
  final  name;
  final  imgicon;
  final onPressed;
  

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
              width: 70,
              height: 70,
              margin: EdgeInsets.only(left: 15),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Color(0xFF34607B)),
                borderRadius: BorderRadius.circular(70),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: SvgPicture.asset(
                 imgicon,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
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
                        Text(
                          '23 min',
                          style: TextStyle(
                            color: Colors.black45,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
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
