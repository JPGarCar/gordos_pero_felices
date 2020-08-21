import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';
import 'package:gordos_pero_felizes/models/sex_enum.dart';

class RedRoundedDropDown extends StatelessWidget {
  final String hint;
  final Function onChangeFunction;
  final value;
  final List<DropdownMenuItem> dropDownItems;
  final IconData iconData;

  RedRoundedDropDown({
    this.iconData,
    @required this.dropDownItems,
    @required this.value,
    @required this.onChangeFunction,
    @required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        height: 35,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: k_redColor,
          borderRadius: BorderRadius.circular(k_circularBorderRadius),
          boxShadow: [
            BoxShadow(
              color: k_redColorLight,
              offset: Offset.fromDirection(.8, 8),
            ),
          ],
        ),
        child: Center(
          widthFactor: 1.2,
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: iconData != null ? Icon(iconData) : null,
              iconEnabledColor: k_whiteColor,
              isDense: true,
              dropdownColor: k_redColorLight,
              elevation: 20,
              style: TextStyle(
                color: k_whiteColor,
                fontSize: 14,
              ),
              hint: Text(
                hint,
                style: TextStyle(
                  fontSize: 14,
                  color: k_whiteColor,
                ),
              ),
              items: dropDownItems,
              value: value,
              onChanged: onChangeFunction,
            ),
          ),
        ),
      ),
    );
  }
}
