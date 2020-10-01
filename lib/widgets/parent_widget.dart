import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';

/// A parent widget encopases a Scaffold with the app's white background and a
/// safe area with the given child. This will facilitate having the same
/// scaffold -> safe area -> child structure
class ParentWidget extends StatelessWidget {
  final Widget bodyChild;

  ParentWidget({this.bodyChild});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: k_whiteColor,
      body: SafeArea(
        child: bodyChild,
      ),
    );
  }
}
