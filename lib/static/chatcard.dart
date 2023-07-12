import 'package:flutter/material.dart';
import 'package:translation_vendor/values/colors.dart';


class ChatMessageCard extends StatefulWidget {
  ChatMessageCard(
      {Key? key,
      required this.msg,
      required this.time,
      required this.id,
      this.color,
      required this.user_id})
      : super(key: key);
  final String msg;
  final String time;
  final color;
  final String id;
  final int user_id;

  @override
  State<ChatMessageCard> createState() => _ChatMessageCardState();
}

class _ChatMessageCardState extends State<ChatMessageCard> {
  bool pressAttention = false;
  bool pressIcon = false;
  
  // delmsgs() async {
  //   log(widget.id);
  //   await destroy.DelApi(widget.id);
  // }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 65,
          ),
          
          child: GestureDetector(
            onLongPress: () {
              setState(() {
                pressAttention = true;
                pressIcon = true;
              });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Card(
                  
                  elevation: 1,
                  

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8))),
                  color: pressAttention == true
                      ? Color.fromARGB(255, 220, 44, 44)
                      : mainColor,
                      
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Text(
                      widget.msg,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(widget.time,
                          style: TextStyle(fontSize: 13, color: hintText)),
                      SizedBox(
                        width: 5,
                      ),
                      pressIcon == true
                          ? GestureDetector(
                              child: Icon(
                                Icons.delete,
                                size: 19,
                              ),
                              onTap: () {
                                // delmsgs();
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => groupchat(id: widget.user_id, name: widget.name)),
                                // );
                              },
                            )
                          : Icon(
                              Icons.done_all,
                              size: 19,
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
