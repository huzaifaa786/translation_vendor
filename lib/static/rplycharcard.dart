import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:full_screen_image/full_screen_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:translation_vendor/values/colors.dart';
import 'package:translation_vendor/values/string.dart';

class ReplyMessageCard extends StatefulWidget {
  const ReplyMessageCard({
    Key? key,
    required this.msg,
    this.Time,
    this.sender = true,
    this.fileExist = false,
    this.fileName = '',
    this.fileTitle = '',
    this.fileType = '',
  }) : super(key: key);

  final String msg;
  final sender;
  final Time;
  final fileName;
  final fileTitle;
  final fileType;
  final fileExist;
  @override
  State<ReplyMessageCard> createState() => _ReplyMessageCardState();
}

class _ReplyMessageCardState extends State<ReplyMessageCard> {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: widget.sender == true
            ? Alignment.centerLeft
            : Alignment.centerRight,
        child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 65,
            ),
            child: widget.fileName == '' || widget.fileName == null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(8),
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8))),
                        color: widget.sender == true ? Colors.white : mainColor,
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10, bottom: 10),
                          child: Text(
                            widget.msg,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: widget.sender == true
                                    ? Colors.black
                                    : White),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          widget.Time.toString(),
                          style: TextStyle(
                              color: hintText,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  )
                : Column(children: [
                    widget.fileType == 'image'
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(8),
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                )),
                                color: widget.sender == true
                                    ? Colors.white
                                    : mainColor,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 150,
                                      width: 150,
                                      child: FullScreenWidget(
                                        backgroundColor: White,
                                        disposeLevel: DisposeLevel.High,
                                        child: Hero(
                                          transitionOnUserGestures: true,
                                          tag: widget.fileName,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: PhotoView(
                                                imageProvider:
                                                    CachedNetworkImageProvider(
                                                        Msg_Storage_Url +
                                                            widget.fileName,
                                                        maxHeight: 10000,
                                                        maxWidth: 10000,
                                                        scale: 1),
                                              )),
                                        ),
                                      ),
                                    ),
                                    widget.msg != ''
                                        ? Container(
                                            width: 151,
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text(
                                              widget.msg,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: widget.sender == true
                                                      ? Colors.black
                                                      : White),
                                            ),
                                          )
                                        : SizedBox()
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  widget.Time.toString(),
                                  style: TextStyle(
                                      color: hintText,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                color: widget.sender == true
                                    ? Colors.white
                                    : mainColor,
                                child: ListTile(
                                  title: Text(
                                    widget.fileTitle,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: widget.sender == true
                                            ? Colors.black
                                            : White),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(
                                      widget.fileExist
                                          ? Icons.download_done
                                          : Icons.download,
                                      color: widget.sender == true
                                          ? Colors.black
                                          : White,
                                    ),
                                    onPressed: () async {
                                      FileDownloader.downloadFile(
                                          url:
                                              Msg_Storage_Url + widget.fileName,
                                          name: widget.fileTitle,
                                          onProgress: (fileName, progress) {
                                            Get.snackbar(
                                                'Downloading ' + fileName!,
                                                'Downloaded ' +
                                                    progress.toString() +
                                                    '%',
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                backgroundColor: Colors.green,
                                                colorText: Colors.white);
                                          },
                                          onDownloadCompleted: (path) async {});
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  widget.Time.toString(),
                                  style: TextStyle(
                                      color: hintText,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                  ])));
  }
}
