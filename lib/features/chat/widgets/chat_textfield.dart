// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_user_side/provider/notifiers/chat_notifier.dart';
import 'package:new_user_side/resources/common/camera_view_page.dart';
import 'package:new_user_side/resources/common/my_text.dart';
import 'package:new_user_side/utils/constants/app_colors.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:new_user_side/utils/extensions/get_images.dart';
import 'package:provider/provider.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  GetImages getImage = GetImages();

  // Send Img to Camera View
  Future selectImg(BuildContext context) async {
    final notifier = context.read<ChatNotifier>();
    await getImage.pickImage<ChatNotifier>(context: context);
    Navigator.pop(context);
    final imgPath = await notifier.image.path;
    Navigator.of(context).pushScreen(
      CameraViewPage(
        onTap: sendImgMessage,
        imgPath: imgPath,
      ),
    );
  }

  // Send Img as Message
  Future sendImgMessage() async {
    final notifier = context.read<ChatNotifier>();
    await notifier.sendMessage(context: context);
    Navigator.pop(context);
  }

  // Pick Files function
  Future pickPdf(BuildContext context) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null && result.files.isNotEmpty) {
      String filePath = result.files.first.path!;
      print("filepath $filePath");
      return filePath;
    } else {
      return '';
    }
  }

  // Send Pdf as Message
  Future uploadPdf() async {
    Navigator.pop(context);
    final notifier = context.read<ChatNotifier>();
    String filePath = await pickPdf(context);
    final multipartFile = await MultipartFile.fromFile(filePath);
    if (filePath.isNotEmpty) {
      await notifier.sendPdf(
        context: context,
        file: multipartFile,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<ChatNotifier>();
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      width: double.infinity,
      height: height / 9,
      color: AppColors.white,
      child: Column(
        children: [
          Divider(thickness: 1.0, height: height / 90),
          SizedBox(height: height / 60),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 40),
              child: TextFormField(
                controller: notifier.messageController,
                onFieldSubmitted: (value) {},
                style: GoogleFonts.poppins(
                  fontSize: width / 25,
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width / 12),
                    borderSide: BorderSide(
                      color: AppColors.black.withOpacity(0.2),
                      width: width / 240,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width / 20),
                    borderSide: BorderSide(
                      color: AppColors.black.withOpacity(0.15),
                      width: width / 240,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: width / 20,
                    vertical: height / 400,
                  ),

                  hintText: "write a Meassage ",
                  hintStyle: TextStyle(
                    fontSize: width / 28,
                    color: AppColors.black.withOpacity(0.4),
                  ),
                  // show attachment options
                  prefixIcon: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return _bottomSheet(
                            onTapDoc: () => uploadPdf(),
                            onTapGallery: () => selectImg(context),
                            onTapCamera: () {},
                          );
                        },
                      );
                    },
                    child: Icon(
                      Icons.attach_file,
                      size: width / 20,
                      color: AppColors.black,
                    ),
                  ),
                  // send message
                  suffixIcon: InkWell(
                    onTap: () => notifier.sendMessage(context: context),
                    child: Icon(
                      Icons.send_sharp,
                      color: AppColors.buttonBlue,
                      size: width / 20,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _bottomSheet extends StatelessWidget {
  final VoidCallback onTapDoc;
  final VoidCallback onTapCamera;
  final VoidCallback onTapGallery;

  const _bottomSheet({
    Key? key,
    required this.onTapDoc,
    required this.onTapCamera,
    required this.onTapGallery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      height: height / 7.6,
      width: double.infinity,
      margin:
          EdgeInsets.symmetric(horizontal: width / 30, vertical: height / 90),
      padding: EdgeInsets.only(top: height / 50),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(width / 30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildWorkers(
            context: context,
            backgroundColor: AppColors.buttonBlue,
            icon: Icons.insert_drive_file,
            title: "Document",
            onTap: onTapDoc,
          ),
          _buildWorkers(
            context: context,
            backgroundColor: Colors.red,
            icon: Icons.camera_alt,
            title: "Camera",
            onTap: onTapCamera,
          ),
          _buildWorkers(
            context: context,
            backgroundColor: Colors.purple,
            icon: Icons.insert_photo,
            title: "Gallary",
            onTap: onTapGallery,
          ),
        ],
      ),
    );
  }

  Widget _buildWorkers({
    required BuildContext context,
    required Color backgroundColor,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final height = context.screenHeight;
    final width = context.screenWidth;
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: width / 14,
            backgroundColor: backgroundColor,
            child: Icon(
              icon,
              size: width / 14,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: height / 160),
          MyTextPoppines(
            text: title,
            fontSize: width / 34,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
