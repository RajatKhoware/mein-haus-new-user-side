import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_user_side/error_screens.dart';
import 'package:new_user_side/features/home/screens/home_screen.dart';
import 'package:new_user_side/repository/upload_img_repo.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../resources/common/my_snake_bar.dart';
import '../../utils/extensions/get_images.dart';

class UploadImgNotifier extends ChangeNotifier {
  UploadImgRepo uploadImgRepo = UploadImgRepo();
  GetImages getImages = GetImages();

  //variables
  bool _loading = false;
  List<XFile> _images = [];

  //getters
  bool get loading => _loading;
  List<XFile> get images => _images;

  //function
  void setLoadingState(bool state, bool notify) {
    _loading = state;
    if (notify) notifyListeners();
  }

  void setImagesInList(List<XFile> images) {
    _images = images;
    notifyListeners();
  }

  void removeImageFromList(XFile pickedFile) {
    _images.remove(pickedFile);
    notifyListeners();
  }

  Future getImagess(BuildContext context) async {
    await getImages.pickImages<UploadImgNotifier>(context: context);
  }

  // upload img
  Future uploadImg({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    setLoadingState(true, true);
    uploadImgRepo.uploadImg(body).then((response) {
      setLoadingState(false, true);
      setImagesInList([]);
      ('Img Uploaded Succesfully ✅').log();
      Navigator.of(context).pushScreen(HomeScreen());
      showSnakeBarr(
          context, "Images Uploaded Succesfully", SnackBarState.Success);
    }).onError((error, stackTrace) {
      setLoadingState(false, true);
      showSnakeBarr(context, "$error", SnackBarState.Error);
      ("${error} $stackTrace").log("Saved note notifier");
      Navigator.of(context).pushScreen(ShowError(error: error.toString()));
    });
  }
}
