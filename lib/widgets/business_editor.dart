import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_button.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_dropdown.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_switch.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_text_field.dart';
import 'card/custom_card.dart';

class BusinessEditor extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController reviewController;
  final TextEditingController phoneController;
  final TextEditingController favoriteDishesController;
  final TextEditingController gordoTipController;
  final TextEditingController igLinkController;
  final TextEditingController rappiLinkController;
  final TextEditingController uberEatsController;

  final bool isActive;
  final int happyRating;
  final int houseRating;
  final int moneyRating;
  final String mainImagePath;

  final Function finalOnTapFunction;
  final String finalButtonString;

  final Function isActiveFunction;
  final Function multiImageOnTapFunction;
  final Function mainImageOnTapFunction;
  final Function categoryOnChangeFunction;

  final String categoryDropDownValue;
  final List<DropdownMenuItem> categoryDropDownItems;

  final Function moneyOnTapFunction;
  final Function houseOnTapFunction;
  final Function happyRatingOnTapFunction;

  final bool isOnlineMainImage;

  /// We will disable categories for edit business screen for the time being
  final bool isCategories;

  BusinessEditor(
      {this.isOnlineMainImage = false,
      this.isCategories = true,
      @required this.happyRatingOnTapFunction,
      @required this.houseOnTapFunction,
      @required this.moneyOnTapFunction,
      this.categoryDropDownValue,
      this.categoryDropDownItems,
      this.categoryOnChangeFunction,
      @required this.mainImageOnTapFunction,
      @required this.multiImageOnTapFunction,
      @required this.isActiveFunction,
      @required this.finalButtonString,
      @required this.finalOnTapFunction,
      @required this.nameController,
      @required this.reviewController,
      @required this.phoneController,
      @required this.favoriteDishesController,
      @required this.gordoTipController,
      @required this.igLinkController,
      @required this.rappiLinkController,
      @required this.uberEatsController,
      @required this.isActive,
      @required this.happyRating,
      @required this.houseRating,
      @required this.moneyRating,
      @required this.mainImagePath});

  /// Returns a list of DropDownItems with values 1 to 5
  List<DropdownMenuItem> getOneToFive() {
    List<DropdownMenuItem> list = [];
    for (int i = 1; i <= 5; i++) {
      list.add(
        DropdownMenuItem(
          child: Text('$i'),
          value: i,
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          RedRoundedTextField(
            hint: 'Nombre de Negocio',
            textEditingController: nameController,
          ),
          RedRoundedTextField(
            isMultiLine: true,
            hint: 'Review de negocio...',
            textEditingController: reviewController,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RedRoundedDropDown(
                iconData: Icons.tag_faces,
                hint: happyRating != null ? happyRating.toString() : '?',
                value: happyRating,
                onChangeFunction: happyRatingOnTapFunction,
                dropDownItems: getOneToFive(),
              ),
              RedRoundedDropDown(
                iconData: Icons.home,
                hint: houseRating != null ? houseRating.toString() : '?',
                value: houseRating,
                onChangeFunction: houseOnTapFunction,
                dropDownItems: getOneToFive(),
              ),
              RedRoundedDropDown(
                iconData: Icons.attach_money,
                hint: moneyRating != null ? moneyRating.toString() : '?',
                value: moneyRating,
                onChangeFunction: moneyOnTapFunction,
                dropDownItems: getOneToFive(),
              ),
            ],
          ),
          isCategories
              ? RedRoundedDropDown(
                  dropDownItems: categoryDropDownItems,
                  value: categoryDropDownValue,
                  onChangeFunction: categoryOnChangeFunction,
                  hint: 'Categoría',
                )
              : SizedBox(),
          RedRoundedButton(
            buttonText: 'Escojer Imagen Principal',
            onTapFunction: mainImageOnTapFunction,
          ),
          mainImagePath != null
              ? Column(
                  children: [
                    Text('Preview...'),
                    CustomCard(
                      imageAssetPath: mainImagePath,
                      name: nameController.text,
                      isOffline: !isOnlineMainImage,
                    ),
                  ],
                )
              : SizedBox(),
          RedRoundedButton(
            buttonText: 'Escojer imagenes secundarias',
            onTapFunction: multiImageOnTapFunction,
          ),
          RedRoundedTextField(
            isNumber: true,
            hint: 'Telefono',
            textEditingController: phoneController,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Text('Cada renglon, separado por un . es un platillo.'),
                RedRoundedTextField(
                  isMultiLine: true,
                  hint: 'Platillos favoritos...',
                  textEditingController: favoriteDishesController,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Text('Cada renglon, separado por un . es un tip.'),
                RedRoundedTextField(
                  isMultiLine: true,
                  hint: 'Gordo Tips...',
                  textEditingController: gordoTipController,
                ),
              ],
            ),
          ),
          RedRoundedTextField(
            hint: 'Instagram Link',
            textEditingController: igLinkController,
          ),
          RedRoundedTextField(
            hint: 'Rappi Link',
            textEditingController: rappiLinkController,
          ),
          RedRoundedTextField(
            hint: 'Uber Eats Link',
            textEditingController: uberEatsController,
            isTextInputDone: true,
          ),
          RedRoundedSwitch(
            text: 'Activo?',
            value: isActive,
            onChangeFunction: isActiveFunction,
          ),
          RedRoundedButton(
            buttonText: finalButtonString,
            onTapFunction: finalOnTapFunction,
          )
        ],
      ),
    );
  }
}
