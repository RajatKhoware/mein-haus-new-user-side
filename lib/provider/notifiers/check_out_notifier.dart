import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_user_side/repository/check_out_repo.dart';
import 'package:new_user_side/utils/utils.dart';
import '../../features/home/screens/home_screen.dart';
import '../../payment_services.dart';

class CheckOutNotifier extends ChangeNotifier {
  CheckOutRepository repository = CheckOutRepository();
  int _index = 0;
  bool _loading = false;

  bool get loading => _loading;
  int get index => _index;

  void setLoadingState(
    bool state,
  ) {
    _loading = state;
    notifyListeners();
  }

  void selectCard(int currentIndex) {
    _index = currentIndex;
    notifyListeners();
  }

  Future checkOut({
    required BuildContext context,
    required String bookingId,
  }) async {
    Map<String, String> data = {"booking_id": bookingId};
    print("Work started");
    final res = await MakePayment().makePayment(
      context: context,
      bookingId: bookingId,
    );
    print(res);
    if (res == true) {
      setLoadingState(true);
      await repository.checkOut(data).then((response) {
        print(response);
        Get.to(() => HomeScreen());
        Utils.snackBar("CheckOut Done ..!", response['response_message']);
        setLoadingState(false);
      }).onError((error, stackTrace) {
        print("Error in Check out notifier :: $error\n $stackTrace");
        setLoadingState(false);
      });
    }
  }
}
