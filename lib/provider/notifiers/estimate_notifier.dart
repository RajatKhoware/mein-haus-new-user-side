import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_user_side/data/models/ongoing_project_model.dart';
import 'package:new_user_side/data/models/pro_model.dart';
import 'package:new_user_side/data/models/progress_invoice_model.dart';
import 'package:new_user_side/data/models/project_model.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/error_screens.dart';
import 'package:new_user_side/provider/notifiers/support_notifier.dart';
import 'package:new_user_side/repository/estimate_repository.dart';
import 'package:new_user_side/resources/common/my_snake_bar.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../data/models/generated_estimate_model.dart';
import '../../features/home/screens/home_screen.dart';
import '../../utils/extensions/get_images.dart';

class EstimateNotifier extends ChangeNotifier {
  EstimateRepository estimateRepository = EstimateRepository();
  GetImages getImages = GetImages();
  // variables
  List<XFile> _images = [];
  bool _loading = false;
  bool _toggleLoading = false;
  bool _reviewLoading = false;
  OngoingProjectsModel _ongoingProjects = OngoingProjectsModel();
  OngoingProjectsModel _projectsHistory = OngoingProjectsModel();
  GeneratedEstimateModel _estimateModel = GeneratedEstimateModel();
  ProjectDetailsModel _detailsModel = ProjectDetailsModel();
  ProModel _proModel = ProModel();
  ProgressInvoiceModel _progressInvoiceModel = ProgressInvoiceModel();

  // getters
  bool get loading => _loading;
  bool get toggleLoading => _toggleLoading;
  bool get reviewLoading => _reviewLoading;
  List<XFile> get images => _images;
  OngoingProjectsModel get ongoingProjects => _ongoingProjects;
  OngoingProjectsModel get projectsHistory => _projectsHistory;
  GeneratedEstimateModel get estimated => _estimateModel;
  ProjectDetailsModel get projectDetails => _detailsModel;
  ProModel get proDetails => _proModel;
  ProgressInvoiceModel get progressInvoiceModel => _progressInvoiceModel;

  void setImagesInList(List<XFile> images) {
    _images.addAll(images);
    notifyListeners();
  }

  void removeImageFromList() {
    _images.clear();
    notifyListeners();
  }

  void setLoadingState(bool state, bool notify) {
    _loading = state;
    if (notify) notifyListeners();
  }

  void setToggleLoadingState(bool state, bool notify) {
    _toggleLoading = state;
    if (notify) notifyListeners();
  }

  void setReviewLoadingState(bool state, bool notify) {
    _reviewLoading = state;
    if (notify) notifyListeners();
  }

  void setOngoingProjects(OngoingProjectsModel ongoingProjects) {
    _ongoingProjects = ongoingProjects;
    notifyListeners();
  }

  void setProjectsHistory(OngoingProjectsModel projectHisory) {
    _projectsHistory = projectHisory;
    notifyListeners();
  }

  void setEstimate(GeneratedEstimateModel estimateModel) {
    _estimateModel = estimateModel;
    notifyListeners();
  }

  void setProjectDetails(ProjectDetailsModel projectDetails) {
    _detailsModel = projectDetails;
    notifyListeners();
  }

  void setProDetails(ProModel proDetails) {
    _proModel = proDetails;
    notifyListeners();
  }

  void setProgressInvoice(ProgressInvoiceModel invoiceModel) {
    _progressInvoiceModel = invoiceModel;
    notifyListeners();
  }

  Future getImagess(BuildContext context) async {
    await getImages.pickImages<EstimateNotifier>(context: context);
  }

  void onErrorHandler(
    BuildContext context,
    Object? error,
    StackTrace stackTrace,
  ) {
    showSnakeBarr(context, "$error", SnackBarState.Error);
    ("$error $stackTrace").log("Estimate notifier");
    Navigator.of(context).pushScreen(ShowError(error: error.toString()));
  }

  // CREATE STARTING ESTIMATE
  Future createStartingEstimate({
    required BuildContext context,
    required Map<String, Object?> data,
  }) async {
    setLoadingState(true, true);
    estimateRepository.createStartingEstimate(data).then((response) {
      setLoadingState(false, true);
      ('Estimate Succesfully Created ✅').log("Estimate Creation");
      removeImageFromList();
      Navigator.of(context).pushScreen(HomeScreen());
      showSnakeBarr(
        context,
        "Your estimate has been created successfully. We will contact you shortly",
        SnackBarState.Success,
      );
    }).onError((error, stackTrace) {
      setImagesInList([]);
      setLoadingState(false, true);
      onErrorHandler(context, error, stackTrace);
    });
  }

// CREATE ESTIMATE
  Future createEstimate({
    required BuildContext context,
    required Map<String, Object?> data,
  }) async {
    setLoadingState(true, true);
    estimateRepository.createEstimate(data).then((response) {
      setLoadingState(false, true);
      ('Estimate Succesfully Created ✅').log("Estimate Creation");
      removeImageFromList();
      //Get.to(() => HomeScreen());
      Navigator.of(context).pushScreen(HomeScreen());
      showSnakeBarr(
          context,
          "Your estimate has been created successfully. we will contact you shortly",
          SnackBarState.Success);
    }).onError((error, stackTrace) {
      setLoadingState(false, true);
      onErrorHandler(context, error, stackTrace);
    });
  }

// GET ESTIMATED WORK
  Future getEstimateWork(BuildContext context) async {
    estimateRepository.getEstimates().then((response) {
      var data = GeneratedEstimateModel.fromJson(response);
      setEstimate(data);
    }).onError((error, stackTrace) {
      showSnakeBarr(context, "$error", SnackBarState.Error);
      ("$error $stackTrace").log("Estimate notifier");
    });
  }

// GET ONGOING PROJECTS
  Future getOngoingProjects(BuildContext context) async {
    estimateRepository.getOngoingProjects().then((response) {
      var data = OngoingProjectsModel.fromJson(response);
      setOngoingProjects(data);
    }).onError((error, stackTrace) {
      showSnakeBarr(context, "$error", SnackBarState.Error);
      ("$error $stackTrace").log("Estimate notifier");
    });
  }

  // GET PROJECTS HISTORY
  Future getProjectsHistory(BuildContext context) async {
    // setLoadingState(true, true);
    estimateRepository.getProjectsHistory().then((response) {
      //setLoadingState(false, true);
      var data = OngoingProjectsModel.fromJson(response);
      setProjectsHistory(data);
    }).onError((error, stackTrace) {
      // setLoadingState(false, true);
      onErrorHandler(context, error, stackTrace);
    });
  }

// GET PROJECT DETAILS
  Future getProjectDetails({
    required BuildContext context,
    required String id,
    required String proId,
  }) async {
    setLoadingState(true, true);
    // getting project details
    await estimateRepository.getProjectDetails(id).then((response) {
      var data = ProjectDetailsModel.fromJson(response);
      setProjectDetails(data);
      // checking the support query status
      var query = data.services!.query;
      supportStatusChecker(query, context);
    }).onError((error, stackTrace) {
      //  Navigator.of(context).pushScreen(ShowError(error: error.toString()));
      setLoadingState(false, true);
      onErrorHandler(context, error, stackTrace);
    });
    // getting pro details
    await getProDetails(proId, context);
    setLoadingState(false, true);
  }

  // Check Support status helper function
  supportStatusChecker(Query? query, BuildContext context) {
    // Setting the inital values
    final supportNotifier = context.read<SupportNotifier>();
    supportNotifier.setSupportStatus(0);
    supportNotifier.setShowClosingDialog(false);
    supportNotifier.setIsQuerySoved(false);
    supportNotifier.setIsQueryFlagged(false);
    // Support is not null && active and query is not solved yet.
    if (query != null) {
      if (query.status == 1) {
        supportNotifier.setSupportStatus(1);
        supportNotifier.setTicketId(query.ticket!);
        if (query.flagged == 1) {
          supportNotifier.setIsQueryFlagged(true);
        } else if (query.resolved == 0 && query.endStatus == 1) {
          supportNotifier.setShowClosingDialog(true);
        } else if (query.resolved == 1 && query.endStatus == 3) {
          supportNotifier.setSupportStatus(0);
        }
      } else {
        supportNotifier.setSupportStatus(0);
      }
    }
  }

// GET PRO DETAILS
  Future getProDetails(String proId, BuildContext context) async {
    await estimateRepository.getProDetails(proId).then((response) {
      var data = ProModel.fromJson(response);
      setProDetails(data);
    }).onError((error, stackTrace) {
      setLoadingState(false, true);
      onErrorHandler(context, error, stackTrace);
    });
  }

  // PROGESS INVOICE
  Future progressInvoice({
    required BuildContext context,
    required String bookingId,
  }) async {
    setLoadingState(true, true);
    estimateRepository.progressInvoice(bookingId).then((response) {
      setLoadingState(false, true);
      // Navigator.of(context).pushScreen(ProgressInvoiceScreen());
      //Get.to(() => ProgressInvoiceScreen());
      var data = ProgressInvoiceModel.fromJson(response);
      setProgressInvoice(data);
    }).onError((error, stackTrace) {
      setLoadingState(false, true);
      onErrorHandler(context, error, stackTrace);
    });
  }

  // REMOVE OR ADD SERVICES
  Future toggleService({
    required BuildContext context,
    required MapSS body,
  }) async {
    setToggleLoadingState(true, true);
    await estimateRepository.toggleServices(body).then((_) {
      getEstimateWork(context);
      setToggleLoadingState(false, true);
    }).onError((error, stackTrace) {
      setToggleLoadingState(true, true);
      onErrorHandler(context, error, stackTrace);
    });
  }

  // WRITE A REVIEW
  Future writeReview({
    required BuildContext context,
    required MapSS body,
  }) async {
    setReviewLoadingState(true, true);
    await estimateRepository.writeReview(body).then((response) {
      showSnakeBarr(
        context,
        response["response_message"],
        SnackBarState.Success,
      );
      getProjectsHistory(context);
      Navigator.pop(context);
      setReviewLoadingState(false, true);
    }).onError((error, stackTrace) {
      setReviewLoadingState(false, true);
      onErrorHandler(context, error, stackTrace);
    });
  }
}
