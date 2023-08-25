import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'constants/app_colors.dart';

class Utils {
  final dio = Dio();
  Utils._();

  // function to change the focus from the current textfield to another with keyboard
  static void fieldFocusChange(
    BuildContext context,
    FocusNode current,
    FocusNode nextFocus,
  ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

// This Function collect List of all the images selected by user and convert them into multipart files
  static Future<List<MultipartFile>> collectImages(List<XFile>? images) async {
    List<MultipartFile> imageFiles = [];
    for (int i = 0; i < images!.length; i++) {
      final fileBytes = await images[i].readAsBytes();
      final fileName = images[i].name;
      final imageFile = await MultipartFile.fromBytes(
        fileBytes,
        filename: fileName,
      );
      imageFiles.add(imageFile);
    }
    return await imageFiles;
  }

// This Function collect the single image selected by user and convert it into multipart file
  static Future<MultipartFile?> convertToMultipartFile(XFile? image) async {
    if (image!.path.isNotEmpty) {
      final fileBytes = await image.readAsBytes();
      final fileName = image.name;
      final imageFile = await MultipartFile.fromBytes(
        fileBytes,
        filename: fileName,
      );
      return await imageFile;
    } else {
      return null;
    }
  }

// Getting the lat and long form address
  static Future<List<Location>> getCordinates(String address) async {
    return await locationFromAddress(address);
  }

// Convert random time into railway timing
  static String convertToRailwayTime(String time) {
    final dateTime = DateTime.parse(time).toLocal();
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }


// This function matches the current time to given time and give results just like this 
// [ 2sec, 1 hours, 1 week, 1 year] ago
  static String getTimeAgo(String timestamp) {
    final DateTime now = DateTime.now();
    final DateTime time = DateTime.parse(timestamp);

    final int seconds = now.difference(time).inSeconds;
    final int minutes = now.difference(time).inMinutes;
    final int hours = now.difference(time).inHours;
    final int days = now.difference(time).inDays;
    final int weeks = (days / 7).floor();
    final int months = (days / 30).floor();
    final int years = (days / 365).floor();

    if (seconds < 60) {
      return 'just now';
    } else if (minutes < 60) {
      return '${minutes} mins ago';
    } else if (hours < 24) {
      return '${hours} hours ago';
    } else if (days < 7) {
      return '${days} days ago';
    } else if (weeks < 4) {
      return '${weeks} weeks ago';
    } else if (months < 12) {
      return '${months} months ago';
    } else {
      return '${years} years ago';
    }
  }
}
