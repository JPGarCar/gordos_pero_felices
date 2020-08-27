import 'package:flutter/material.dart';

class LoadingGif extends StatelessWidget {
  const LoadingGif({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/logo_gif.gif',
      height: 200,
    );
  }
}
