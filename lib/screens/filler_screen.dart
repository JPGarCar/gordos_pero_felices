import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';
import 'package:gordos_pero_felizes/screens/home_screen.dart';
import 'package:gordos_pero_felizes/widgets/loading_gif.dart';

class FillerScreen extends StatefulWidget {
  static final screenId = 'fillerScreen';

  @override
  _FillerScreenState createState() => _FillerScreenState();
}

class _FillerScreenState extends State<FillerScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.screenId, (route) => false));
    return Container(
      color: k_whiteColor,
      height: 200,
      child: LoadingGif(),
    );
  }
}
