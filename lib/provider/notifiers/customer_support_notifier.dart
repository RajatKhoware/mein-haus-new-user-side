import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_user_side/data/models/raised_query_model.dart';
import 'package:new_user_side/repository/customer_support_repo.dart';
import 'package:new_user_side/res/common/my_snake_bar.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';

import '../../utils/extensions/get_images.dart';

class CustomerSupportNotifier extends ChangeNotifier {
  CustomerSupportRepo supportRepo = CustomerSupportRepo();
  GetImages getImages = GetImages();
  //variables
  bool _loading = false;
  List<XFile> _images = [];
  RaisedQueryModel _queryModel = RaisedQueryModel();

  //getters
  bool get loading => _loading;
  List<XFile> get images => _images;
  RaisedQueryModel get queryModel => _queryModel;

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

  void setQueryModel(RaisedQueryModel query) {
    _queryModel = query;
    notifyListeners();
  }

  Future getImagess(BuildContext context) async {
    await getImages.pickImages<CustomerSupportNotifier>(context: context);
  }

  // Send Query to support
  Future sendQuery({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    setLoadingState(true, true);
    await supportRepo.sendQuery(body).then((response) {
      setLoadingState(false, true);
      setImagesInList([]);
      showSnakeBarr(
          context, response["response_message"], SnackBarState.Success);
      Navigator.pop(context);
    }).onError((error, stackTrace) {
      setLoadingState(false, true);
      ("${error} $stackTrace").log("Send Query notifier");
      showSnakeBarr(context, error.toString(), SnackBarState.Error);
    });
  }

  // Get Raised Query
  Future getRaisedQuery({
    required BuildContext context,
    required String id,
  }) async {
    supportRepo.getRaisedQuery(id).then((response) {
      print(response);
      var data = RaisedQueryModel.fromJson(response);
      setQueryModel(data);
      ('Get Raised Query ✅').log();
    }).onError((error, stackTrace) {
      ("${error} $stackTrace").log("Get Raised Query notifier");
      showSnakeBarr(context, error.toString(), SnackBarState.Error);
    });
  }
}
