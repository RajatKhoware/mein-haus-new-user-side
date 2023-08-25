import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:new_user_side/data/models/message_model.dart';
import 'package:new_user_side/local%20db/user_prefrences.dart';
import 'package:new_user_side/provider/notifiers/auth_notifier.dart';
import 'package:new_user_side/provider/notifiers/chat_notifier.dart';
import 'package:new_user_side/provider/notifiers/chat_with_pro_notifier.dart';
import 'package:new_user_side/provider/notifiers/support_notifier.dart';
import 'package:new_user_side/resources/common/api_url/api_urls.dart';
import 'package:new_user_side/utils/extensions/extensions.dart';
import 'package:provider/provider.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../static components/dialogs/customer_close_ticket_dialog.dart';

class PusherService {
  //*  Singleton Design Pattern
  static PusherService? _instance;

  // Privatised Constructor
  PusherService._internal();

  // Getter for instance -> PusherService instance = PusherService.instance;
  static PusherService get instance {
    _instance ??= PusherService._internal();
    return _instance!;
  }

  final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();
  final apiKey = dotenv.env['pusherApiKey']!;
  final cluster = "ap2";

  // List of all the channelsName
  List _channelName = [];
  List get channelName => _channelName;

  Future<void> setupPusherConnection(
    BuildContext context,
    List channelNames,
  ) async {
    try {
      await pusher.init(
        apiKey: apiKey,
        cluster: cluster,
        onConnectionStateChange: onConnectionStateChange,
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: (event) => onEvent(event, context),
        onSubscriptionError: onSubscriptionError,
        onSubscriptionCount: onSubscriptionCount,
        onAuthorizer: onAuthorizer,
      );
      await pusher.connect();
      for (final channelName in channelNames) {
        await pusher.subscribe(channelName: channelName);
      }
    } catch (e) {
      print("ERROR: $e");
    }
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    print("Connection: $currentState");
  }

  void onError(String message, int? code, dynamic e) {
    print("onError: $message code: $code exception: $e");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    print("onSubscriptionSucceeded: $channelName data: $data");
  }

  void onSubscriptionError(String message, dynamic e) {
    print("onSubscriptionError: $message Exception: $e");
  }

  void onSubscriptionCount(String channelName, int subscriptionCount) {
    print(
        "onSubscriptionCount: $channelName subscriptionCount: $subscriptionCount");
  }

  Future<dynamic> onAuthorizer(
    String channelName,
    String socketId,
    dynamic options,
  ) async {
    try {
      final token = await UserPrefrences().getToken();
      var result = await http.post(
        ApiUrls.broadcastAuth,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer $token',
        },
        body: 'socket_id=' + socketId + '&channel_name=' + channelName + '',
      );
      var json = jsonDecode(result.body);
      return {"auth": json['auth']};
    } catch (err) {
      (err).log("Pusher onAuth error");
    }
  }

  void onEvent(PusherEvent event, BuildContext context) async {
    try {
      final notifier = context.read<ChatNotifier>();
      final proChatNotifier = context.read<ChatWithProNotifier>();
      final supportNotifier = context.read<SupportNotifier>();
      final userNotifier = context.read<AuthNotifier>().user;

      // Handle "message-sent" event ask nessage received
      if (event.eventName == "message-sent") {
        final data = json.decode(event.data as String) as Map<String, dynamic>;
        final message = Messages.fromJson(data['message_data']);
        // Add the new message in mymessages list
        if (notifier.myMessaage.conversationId == data['conversation_id']) {
          notifier.updateOrAddNewMessage(message); // add or update a message
        }
        // updating conversation list
        proChatNotifier.allConversation(context);
        // Whenever we see the message we will mark it as read using this api
        final body = {
          "conversation_id": data["conversation_id"].toString(),
          "to_user_id": data["message_data"]["sender_id"].toString(),
          "message_id": data["message_data"]["id"].toString(),
        };
        notifier.readMessage(body);
      }

      // Handle "message-read" event
      // Update messages seen status
      else if (event.eventName == "message-read") {
        final messages = notifier.myMessaage.messages!;
        final updatedMessages = messages.map(
          (message) {
            if (message.senderId == userNotifier.userId) {
              return message.copyWith(isSeen: 2);
            }
            return message;
          },
        ).toList();
        notifier.setMessages(
          notifier.myMessaage.copyWith(messages: updatedMessages),
        );
      }

      // Handle "ticket-accepted" evetns
      else if (event.eventName == "ticket-accepted") {
        final data = json.decode(event.data as String) as Map<String, dynamic>;
        await supportNotifier.setSupportStatus(1);
        await supportNotifier.setTicketId(data['ticket_id']);
      }

      // Handle "ticket-close-request" evetns
      else if (event.eventName == "ticket-close-request") {
        supportNotifier.setShowClosingDialog(true);
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const CustosmerCloseTicketDialog();
          },
        );
      }

      // Handle "ticket-flagged" evetns
      else if (event.eventName == "ticket-flagged") {
        supportNotifier.setIsQueryFlagged(true);
      }
    } catch (e) {
      (e).log("OnEvent Error");
    }
    ("Event: $event").log("onEvent");
  }
}
