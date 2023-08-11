// Urls
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

final String baseUrl = "https://meinhaus.ca/api";
final String googleAddresUrl =
    "https://maps.googleapis.com/maps/api/place/autocomplete/json";

// Google Map API Keys
final String kPLACES_API_KEY = "AIzaSyC3WLUbDPnruzxcS7eT8IQ5OVYJiSiLIlU";

// Card box shadow
final List<BoxShadow> boxShadow = [
  BoxShadow(
    color: const Color.fromARGB(20, 0, 0, 0),
    blurRadius: 10,
    spreadRadius: 2,
  ),
];

final List<BoxShadow> darkShadow = [
  BoxShadow(
    color: const Color.fromARGB(50, 0, 0, 0),
    blurRadius: 15,
    spreadRadius: 4,
  ),
];

final List<BoxShadow> buttonShadow = [
  BoxShadow(
    color: const Color.fromARGB(56, 0, 0, 0),
    offset: const Offset(0, 4),
    blurRadius: 10,
  ),
];

final cachedNetworkPlaceHolder = Center(
  child: LoadingAnimationWidget.inkDrop(
    color: Colors.blue,
    size: 10,
  ),
);

final cachedNetworkErrorWidget = Center(
  child: Icon(
    Icons.image_not_supported_sharp,
    color: Colors.red[900],
  ),
);
