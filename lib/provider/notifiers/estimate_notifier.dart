import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_user_side/data/models/ongoing_project_model.dart';
import 'package:new_user_side/data/models/pro_model.dart';
import 'package:new_user_side/data/models/progress_invoice_model.dart';
import 'package:new_user_side/data/models/project_model.dart';
import 'package:new_user_side/data/network/network_api_servcies.dart';
import 'package:new_user_side/error_screens.dart';
import 'package:new_user_side/provider/notifiers/support_notifier.dart';
import 'package:new_user_side/repository/estimate_repository.dart';
import 'package:new_user_side/res/common/my_snake_bar.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';
import '../../data/models/generated_estimate_model.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/invoice/screens/progess_invoice_screen.dart';
import '../../utils/extensions/get_images.dart';

class EstimateNotifier extends ChangeNotifier {
  EstimateRepository estimateRepository = EstimateRepository();
  GetImages getImages = GetImages();
  // variables
  List<XFile> _images = [];
  bool _loading = false;
  bool _reviewLoading = false;
  OngoingProjectsModel _ongoingProjects = OngoingProjectsModel();
  OngoingProjectsModel _projectsHistory = OngoingProjectsModel();
  GeneratedEstimateModel _estimateModel = GeneratedEstimateModel();
  ProjectDetailsModel _detailsModel = ProjectDetailsModel();
  ProModel _proModel = ProModel();
  ProgressInvoiceModel _progressInvoiceModel = ProgressInvoiceModel();

  // getters
  bool get loading => _loading;
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

  void removeImageFromList(XFile pickedFile) {
    _images.remove(pickedFile);
    notifyListeners();
  }

  void setLoadingState(bool state, bool notify) {
    _loading = state;
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

  // CREATE STARTING ESTIMATE
  Future createStartingEstimate({
    required BuildContext context,
    required Map<String, Object?> data,
  }) async {
    setLoadingState(true, true);
    estimateRepository.createStartingEstimate(data).then((response) {
      setLoadingState(false, true);
      ('Estimate Succesfully Created ✅').log("Estimate Creation");
      setImagesInList([]);
      Navigator.of(context).pushScreen(HomeScreen());
      // Get.to(() => HomeScreen());
      showSnakeBarr(
        context,
        "Your estimate has been created successfully. We will contact you shortly",
        SnackBarState.Success,
      );
    }).onError((error, stackTrace) {
      setImagesInList([]);
      setLoadingState(false, true);
      showSnakeBarr(context, "$error", SnackBarState.Error);
      ("${error} $stackTrace").log("Create Estimate notifier");
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
      setImagesInList([]);
      Get.to(() => HomeScreen());
      showSnakeBarr(
          context,
          "Your estimate has been created successfully. we will contact you shortly",
          SnackBarState.Success);
    }).onError((error, stackTrace) {
      setLoadingState(false, true);
      showSnakeBarr(context, "$error", SnackBarState.Error);
      ("${error} $stackTrace").log("Create Estimate notifier");
    });
  }

// GET ESTIMATED WORK
  Future getEstimateWork() async {
    estimateRepository.getEstimates().then((response) {
      var data = GeneratedEstimateModel.fromJson(response);
      setEstimate(data);
    }).onError((error, stackTrace) {
      ("${error} $stackTrace").log("Get Estimate notifier");
    });
  }

// GET ONGOING PROJECTS
  Future getOngoingProjects() async {
    estimateRepository.getOngoingProjects().then((response) {
      var data = OngoingProjectsModel.fromJson(response);
      setOngoingProjects(data);
    }).onError((error, stackTrace) {
      ("${error} $stackTrace").log("Get Ongoing Estimate notifier");
    });
  }

  // GET PROJECTS HISTORY
  Future getProjectsHistory() async {
    estimateRepository.getProjectsHistory().then((response) {
      var data = OngoingProjectsModel.fromJson(response);
      setProjectsHistory(data);
    }).onError((error, stackTrace) {
      ("${error} $stackTrace").log("Get Ongoing Estimate notifier");
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
      showSnakeBarr(context, error.toString(), SnackBarState.Error);
      ("${error} $stackTrace").log("Get Project Details Estimate notifier");
    });
    // getting pro details
    await getProDetails(proId, context);
    setLoadingState(false, true);
  }

  // Check Support status helper function
  supportStatusChecker(Query? query, BuildContext context) {
    // Setting the inital values
    final supportNotifier = context.read<SupportNotifier>();
    supportNotifier.setShowClosingDialog(false);
    supportNotifier.setIsQuerySoved(false);
    supportNotifier.setIsQueryFlagged(false);
    // Support is not null && active and query is not solved yet.
    // Support has flaged your query
    if (query != null && query.flagged == "1") {
      supportNotifier.setIsQueryFlagged(true);
    }
    if (query != null && query.status == "1" && query.resolved == "0") {
      supportNotifier.setSupportStatus(1);
      supportNotifier.setTicketId(query.ticket!);
    }
    // Support request to close the query
    else if (query != null &&
        query.status == "1" &&
        query.endStatus == "1" &&
        query.resolved == "0") {
      supportNotifier.setShowClosingDialog(true);
    }
    // If no condition match we will set support status to inactive
    else {
      supportNotifier.setSupportStatus(0);
    }
  }

// GET PRO DETAILS
  Future getProDetails(String proId, BuildContext context) async {
    await estimateRepository.getProDetails(proId).then((response) {
      var data = ProModel.fromJson(response);
      setProDetails(data);
    }).onError((error, stackTrace) {
      setLoadingState(false, true);
      showSnakeBarr(context, error.toString(), SnackBarState.Error);
      ("${error} $stackTrace").log("Get Pro Details Estimate notifier");
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
      Get.to(() => ProgressInvoiceScreen());
      var data = ProgressInvoiceModel.fromJson(response);
      setProgressInvoice(data);
    }).onError((error, stackTrace) {
      setLoadingState(false, true);
      showSnakeBarr(context, "$error", SnackBarState.Error);
      ("${error} $stackTrace").log("Progress-Invocie Estimate notifier");
    });
  }

  // REMOVE OR ADD SERVICES
  Future toggleService({
    required BuildContext context,
    required MapSS body,
  }) async {
    await estimateRepository.toggleServices(body).then((response) {
      showSnakeBarr(
          context, response["response_message"], SnackBarState.Success);
      getEstimateWork();
    }).onError((error, stackTrace) {
      showSnakeBarr(context, "$error", SnackBarState.Error);
      ("${error} $stackTrace").log("Toggle Service Estimate notifier");
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
          context, response["response_message"], SnackBarState.Success);
      Navigator.pop(context);
      setReviewLoadingState(false, true);
    }).onError((error, stackTrace) {
      showSnakeBarr(context, "$error", SnackBarState.Error);
      ("${error} $stackTrace").log("Toggle Service Estimate notifier");
      setReviewLoadingState(false, true);
    });
  }
}
