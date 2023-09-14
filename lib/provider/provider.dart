import 'package:new_user_side/features/chat/widgets/customer_bottom_sheet.dart';
import 'package:new_user_side/features/edit%20profile/controller/provider/edit_profile_notifier.dart';
import 'package:new_user_side/provider/notifiers/additional_work_notifier.dart';
import 'package:new_user_side/provider/notifiers/address_notifier.dart';
import 'package:new_user_side/provider/notifiers/auth_notifier.dart';
import 'package:new_user_side/provider/notifiers/chat_notifier.dart';
import 'package:new_user_side/provider/notifiers/chat_with_pro_notifier.dart';
import 'package:new_user_side/provider/notifiers/customer_support_notifier.dart';
import 'package:new_user_side/provider/notifiers/notification_notifier.dart';
import 'package:new_user_side/provider/notifiers/our_services_notifier.dart';
import 'package:new_user_side/provider/notifiers/saved_notes_notifier.dart';
import 'package:new_user_side/provider/notifiers/support_notifier.dart';
import 'package:new_user_side/provider/notifiers/upload_image_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'notifiers/check_out_notifier.dart';
import 'notifiers/estimate_notifier.dart';

List<SingleChildWidget> provider = [
  ChangeNotifierProvider(create: (context) => CheckOutNotifier()),
  ChangeNotifierProvider(create: (context) => SupportUserMessagesProvider()),
  ChangeNotifierProvider(create: (context) => EditProfileNotifier()),
  ChangeNotifierProvider(create: (context) => AuthNotifier()),
  ChangeNotifierProvider(create: (context) => AddressNotifier()),
  ChangeNotifierProvider(create: (context) => EstimateNotifier()),
  ChangeNotifierProvider(create: (context) => AdditionalWorkNotifier()),
  ChangeNotifierProvider(create: (context) => SavedNotesNotifier()),
  ChangeNotifierProvider(create: (context) => OurServicesNotifier()),
  ChangeNotifierProvider(create: (context) => CustomerSupportNotifier()),
  ChangeNotifierProvider(create: (context) => UploadImgNotifier()),
  ChangeNotifierProvider(create: (context) => ChatNotifier()),
  ChangeNotifierProvider(create: (context) => ChatWithProNotifier()),
  ChangeNotifierProvider(create: (context) => SupportNotifier()),
  ChangeNotifierProvider(create: (context) => NotificationNotifier()),

];
