import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_user_side/data/models/saved_notes_model.dart';
import 'package:new_user_side/repository/saved_notes_repository.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import '../../error_screens.dart';
import '../../resources/common/my_snake_bar.dart';
import '../../utils/extensions/get_images.dart';

class SavedNotesNotifier extends ChangeNotifier {
  SavedNotesRepo savedNotesRepo = SavedNotesRepo();
  GetImages getImages = GetImages();

  //variables
  bool _loading = false;
  bool _loadingForMe = false;
  bool _loadingForMeAndPro = false;
  List<XFile> _images = [];
  SavedNotesModel _savedNotes = SavedNotesModel();

  //getters
  bool get loading => _loading;
  bool get loadingForMe => _loadingForMe;
  bool get loadingForMeAndPro => _loadingForMeAndPro;
  List<XFile> get images => _images;
  SavedNotesModel get savedNotes => _savedNotes;

  //function
  void setLoadingState(bool state, bool notify) {
    _loading = state;
    if (notify) notifyListeners();
  }

  void setLoadingForMe(bool state, bool notify) {
    _loadingForMe = state;
    if (notify) notifyListeners();
  }

  void setLoadingForMeAndPro(bool state, bool notify) {
    _loadingForMeAndPro = state;
    if (notify) notifyListeners();
  }

  void setImagesInList(List<XFile> images) {
    _images = images;
    notifyListeners();
  }

  void setSavedNotes(SavedNotesModel notes) {
    _savedNotes = notes;
    notifyListeners();
  }

  void removeImageFromList(XFile pickedFile) {
    _images.remove(pickedFile);
    notifyListeners();
  }

  Future getImagess(BuildContext context) async {
    await getImages.pickImages<SavedNotesNotifier>(context: context);
  }

  void onErrorHandler(
    BuildContext context,
    Object? error,
    StackTrace stackTrace,
  ) {
    showSnakeBarr(context, "$error", SnackBarState.Error);
    ("$error $stackTrace").log("Saved Notes notifier");
    Navigator.of(context).pushScreen(ShowError(error: error.toString()));
  }

  // Save note for me
  Future savedNoteForMe({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    setLoadingForMe(true, true);
    savedNotesRepo.savedNoteForMe(body).then((response) {
      setLoadingForMe(false, true);
      setImagesInList([]);
      ('Saved Notes For me ✅').log();
      Navigator.pop(context);
      showSnakeBar(context, "Saved Notes For me ✅");
    }).onError((error, stackTrace) {
      setLoadingForMe(false, true);
      onErrorHandler(context, error, stackTrace);
    });
  }

  // Save note for me and pro
  Future savedNoteForMeAndPro({
    required BuildContext context,
    required Map<String, dynamic> body,
  }) async {
    setLoadingForMeAndPro(true, true);
    savedNotesRepo.savedNoteForMeAndPro(body).then((response) {
      setLoadingForMeAndPro(false, true);
      setImagesInList([]);
      ('Saved Notes For me and pro ✅').log();
      Navigator.pop(context);
      showSnakeBar(context, "Saved Notes For me and pro ✅");
    }).onError((error, stackTrace) {
      setLoadingForMeAndPro(false, true);
      onErrorHandler(context, error, stackTrace);
    });
  }

  // Get saved notes
  Future getSavedNotes({
    required BuildContext context,
    required String id,
  }) async {
    setLoadingState(true, true);
    savedNotesRepo.getSavedNotes(id).then((response) {
      var data = SavedNotesModel.fromJson(response);
      setSavedNotes(data);
      setLoadingState(false, true);
      ('Get Saved Notes ✅').log();
    }).onError((error, stackTrace) {
      setLoadingState(false, true);
      onErrorHandler(context, error, stackTrace);
    });
  }
}
