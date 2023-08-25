// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:open_file/open_file.dart';

import 'check_permisson.dart';
import 'directory_path.dart';

class DownloadFile extends StatefulWidget {
  final String fileNmae;
  const DownloadFile({
    Key? key,
    required this.fileNmae,
  }) : super(key: key);

  @override
  State<DownloadFile> createState() => _DownloadFileState();
}

class _DownloadFileState extends State<DownloadFile> {
  bool isDisposed = false;
  bool isPermission = false;
  final checkAllPermissions = CheckPermission();
  bool dowloading = false;
  bool fileExists = false;
  double progress = 0;
  String fileName = "";
  late String filePath;
  late CancelToken cancelToken;
  var getPathFile = DirectoryPath();

  @override
  void dispose() {
    isDisposed = true;
    // Cancel any active timers or animations here
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      fileName = widget.fileNmae.split("/").last;
    });
    checkFileExit();
  }

  // checking for permission
  checkPermission() async {
    var permission = await checkAllPermissions.isStoragePermission();
    if (permission) {
      setState(() {
        isPermission = true;
      });
    }
  }

// check if file is exits work according to it
  checkFileExit() async {
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    bool fileExistCheck = await File(filePath).exists();
    if (!isDisposed) {
      setState(() {
        fileExists = fileExistCheck;
      });
    }
  }

// start dowloading using dio and setting the states
  startDownload() async {
    cancelToken = CancelToken();
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    setState(() {
      dowloading = true;
      progress = 0;
    });

    try {
      await Dio().download(
        widget.fileNmae,
        filePath,
        onReceiveProgress: (count, total) {
          setState(() {
            progress = (count / total);
          });
        },
        cancelToken: cancelToken,
      );
      setState(() {
        dowloading = false;
        fileExists = true;
      });
    } catch (e) {
      print(e);
      setState(() {
        dowloading = false;
      });
    }
  }

// cancel dowloading
  cancelDownload() {
    cancelToken.cancel();
    setState(() {
      dowloading = false;
    });
  }

// open file
  openfile() {
    OpenFile.open(filePath);
    print("File oped $filePath");
  }

  @override
  Widget build(BuildContext context) {
    final w = context.screenWidth;
    return SizedBox(
      width: w / 1.9,
      child: Container(
        margin: EdgeInsets.all(w / 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(w / 40),
        ),
        child: Row(
          children: [
            // pdf icon
            Icon(
              Icons.picture_as_pdf,
              size: w / 20,
              color: Colors.red.shade600,
            ),
            SizedBox(width: w / 60),
            // showing the file name
            SizedBox(
              width: w / 3.5,
              child: MyTextPoppines(
                text: widget.fileNmae.split("/").last,
                fontSize: w / 38,
                fontWeight: FontWeight.w500,
                color: AppColors.golden,
                height: 1.4,
                maxLines: 5,
              ),
            ),
            SizedBox(width: w / 20),
            InkWell(
              onTap: () {
                // checking the permissions
                if (isPermission) {
                  fileExists && dowloading == false
                      ? openfile()
                      : startDownload();
                } else {
                  checkPermission();
                }
              },
              child: fileExists
                  // open file icon
                  ? CircleAvatar(
                      radius: w / 20,
                      backgroundColor: Colors.green.shade100,
                      child: Icon(
                        Icons.save,
                        size: w / 17,
                        color: Colors.green.shade700,
                      ),
                    )
                  : dowloading
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            // progess of downloading
                            CircularProgressIndicator(
                              value: progress,
                              backgroundColor: Colors.grey,
                              color: AppColors.buttonBlue,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.blue),
                            ),
                            // cancel button
                            InkWell(
                              onTap: () {
                                if (fileExists && dowloading) cancelDownload();
                              },
                              child: Icon(
                                Icons.close_sharp,
                                size: w / 17,
                                color: AppColors.grey,
                              ),
                            ),
                          ],
                        )
                      // download button
                      : CircleAvatar(
                          radius: w / 20,
                          backgroundColor: Colors.blue.shade100,
                          child: Icon(
                            Icons.download,
                            size: w / 17,
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
