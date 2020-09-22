import 'package:flutter/material.dart';

import '../../constants.dart';

class RedRoundedButton extends StatefulWidget {
  final Function onTapFunction;
  final String buttonText;
  final IconData iconData;
  final double height;
  final double padding;
  final String imageAsset;
  final double imageHeight;

  RedRoundedButton(
      {@required this.onTapFunction,
      this.buttonText = '',
      this.iconData,
      this.height = 35.0,
      this.padding = 10.0,
      this.imageAsset,
      this.imageHeight});

  @override
  _RedRoundedButtonState createState() => _RedRoundedButtonState();
}

class _RedRoundedButtonState extends State<RedRoundedButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    // used to make sure there is padding to cover the animated portion
    double animationHeight = widget.height * 0.22;

    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          isSelected = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          isSelected = false;
        });
      },
      onTap: () {
        setState(() {
          isSelected = true;
        });
        widget.onTapFunction();
      },
      child: Padding(
        // We are adding animationHeight to protect the animated part of the
        // container from any other widgets if the padding is 0
        padding: EdgeInsets.only(
            top: widget.padding,
            bottom: widget.padding + animationHeight,
            left: widget.padding,
            right: widget.padding + animationHeight),
        child: AnimatedContainer(
          onEnd: () {
            setState(() {
              isSelected = false;
            });
          },
          duration: Duration(milliseconds: 350),
          height: widget.height,
          padding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
          decoration: BoxDecoration(
            color: k_redColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: k_redColorLight,
                offset:
                    Offset.fromDirection(.8, isSelected ? 0 : animationHeight),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.iconData != null
                  ? Padding(
                      padding: EdgeInsets.only(right: k_iconPadding),
                      child: Icon(widget.iconData),
                    )
                  : SizedBox(),
              widget.imageAsset != null
                  ? Padding(
                      padding: EdgeInsets.only(right: k_iconPadding),
                      child: Image.asset(
                        widget.imageAsset,
                        height: widget.imageHeight,
                      ),
                    )
                  : SizedBox(),
              Text(
                widget.buttonText,
                style: TextStyle(
                  color: k_whiteColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
