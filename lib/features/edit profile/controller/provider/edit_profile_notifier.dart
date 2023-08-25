import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/features/edit%20profile/controller/services/edit_profile_services.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../../error_screens.dart';
import '../../../../repository/profile_repository.dart';
import '../../../../resources/common/my_snake_bar.dart';
import '../../../../provider/notifiers/auth_notifier.dart';

class EditProfileNotifier extends ChangeNotifier {
  EditProfileRepository editProfileRepository = EditProfileRepository();
  // variables
  bool _loading = false;
  XFile _image = XFile("");

  // getters
  XFile get image => _image;
  bool get loading => _loading;

  // setters
  void setLoadingState(bool state, bool notify) {
    _loading = state;
    if (notify) notifyListeners();
  }

  void setProfileImg(XFile image) {
    _image = image;
    notifyListeners();
  }

  // edit profile
  Future editProfile({
    required BuildContext context,
    required String firstName,
    required String lastName,
  }) async {
    final user = context.read<AuthNotifier>().user;
    if (user.firstname == firstName &&
        user.lastname == lastName &&
        image.path.isEmpty) {
      showSnakeBar(context, "No Changes Made To Update");
    } else {
      setLoadingState(true, true);
      await EditProfileServices().editProfile(
        context: context,
        img: image,
        firstName: firstName,
        lastName: lastName,
      );
      setLoadingState(false, true);
    }
  }

// edit password
  Future<void> editPassword({
    required BuildContext context,
    required MapSS body,
  }) async {
    setLoadingState(true, true);
    editProfileRepository.editPassword(body).then((value) {
      setLoadingState(false, true);
      showSnakeBar(context, "Password Updated ✅");
      ("Password Updated ✅").log();

      Navigator.pop(context);
    }).onError((error, stackTrace) {
      setLoadingState(false, true);
      showSnakeBar(context, error.toString());
      ("${error} $stackTrace").log("Change Password notifier");
      Navigator.of(context).pushScreen(ShowError(error: error.toString()));
    });
  }
}
