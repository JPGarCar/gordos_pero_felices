import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/models/business.dart';
import 'package:gordos_pero_felizes/services/admin_services.dart';
import 'package:gordos_pero_felizes/services/dropdown_items_getter.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_button.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_dropdown.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_switch.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_text_field.dart';
import '../constants.dart';
import 'card/custom_card.dart';

/// Contains its own k_appPading, no need to add extra
class BusinessEditor extends StatefulWidget {
  /// callback to open multi image picker and set images in parent
  final Function multiImageOnTapFunction;

  /// Image path
  final String mainImagePath;

  /// callback to open single image picker,
  /// also used to set the file selected to variable on parent
  final Function mainImageOnTapFunction;

  /// Used to let card know if image will be in local device or web,
  /// local is used for new business, web for editing a business
  final bool isOnlineMainImage;

  /// Submit button text and callback,
  /// callback used to upload or update the business at db
  final Function finalOnTapFunction;
  final String finalButtonString;

  /// list of category ids that have been selected to be shown in list
  final List<String> categoryIDs;

  /// Business object we are adding or editing
  final Business business;

  BusinessEditor({
    // isOnlineMain Image
    this.isOnlineMainImage = false,
    // Business object
    this.business,
    // chosen category list and callback for list items
    @required this.categoryIDs,
    // image callbacks and var
    @required this.mainImageOnTapFunction,
    @required this.multiImageOnTapFunction,
    @required this.mainImagePath,
    // submit text and callback
    @required this.finalButtonString,
    @required this.finalOnTapFunction,
  });

  @override
  _BusinessEditorState createState() => _BusinessEditorState();
}

class _BusinessEditorState extends State<BusinessEditor> {
  /// temp variables for long strings to be cut down into sentences later
  var tips;
  var dishes;

  /// Drop down value var -> not used
  var dropDownValue;

  /// for easier access
  Business business;

  /// category drop down item list
  List<DropdownMenuItem> categoryDropDownItems;

  /// Returns a list of DropDownItems with values 1 to 5, used for
  /// rating dropdownMenu list creation
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

  /// We have to grab the parent widget business object and put it in a more
  /// convenient variable, also populate dropDown list
  /// We also update temp vars with data
  @override
  void initState() {
    super.initState();
    business = widget.business;
    tips = AdminServices.listToString(business.tipList);
    dishes = AdminServices.listToString(business.bestPlateList);

    // grab all the categories available for the drop down chooser
    DropDownItemsGetter.getCategories().then((value) => setState(() {
          categoryDropDownItems = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Padding is added inside Scroll so that the padding can be used to scroll
      child: Padding(
        padding: k_appPadding,
        child: Column(
          children: [
            RedRoundedTextField(
              isEnabled: false,
              hint: 'Nombre de Negocio',
              onChangedFunction: (value) => business.businessName = value,
              initialValue: business.businessName,
            ),
            RedRoundedTextField(
              isMultiLine: true,
              hint: 'Review de negocio...',
              onChangedFunction: (value) => business.textReview = value,
              initialValue: business.textReview,
            ),

            /// Row with all three rating dropdowns, start with '?'
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RedRoundedDropDown(
                  iconData: Icons.tag_faces,
                  hint: business.happyRating != null
                      ? business.happyRating.toString()
                      : '?',
                  value: business.happyRating,
                  onChangeFunction: (value) => setState(() {
                    business.happyRating = value;
                  }),
                  dropDownItems: getOneToFive(),
                ),
                RedRoundedDropDown(
                  iconData: Icons.home,
                  hint: business.houseRating != null
                      ? business.houseRating.toString()
                      : '?',
                  value: business.houseRating,
                  onChangeFunction: (value) => setState(() {
                    business.houseRating = value;
                  }),
                  dropDownItems: getOneToFive(),
                ),
                RedRoundedDropDown(
                  iconData: Icons.attach_money,
                  hint: business.moneyRating != null
                      ? business.moneyRating.toString()
                      : '?',
                  value: business.moneyRating,
                  onChangeFunction: (value) => setState(() {
                    business.moneyRating = value;
                  }),
                  dropDownItems: getOneToFive(),
                ),
              ],
            ),

            /// Column containing category dropDown chooser and chosen
            /// category list
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RedRoundedDropDown(
                  dropDownItems: categoryDropDownItems,
                  value: dropDownValue,
                  onChangeFunction: (value) => setState(() {
                    // add category to chosen list
                    widget.categoryIDs.add(value);
                    // remove the category from the drop down so the same
                    // category can't be chosen more than once
                    categoryDropDownItems
                        .removeWhere((element) => element.value == value);
                  }),
                  hint: 'Agregar Categoría',
                ),
                Flexible(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return BusinessListItem(
                        businessID: widget.categoryIDs[index],

                        // Was giving called setState on build so needed to wrap
                        // the businessListItemFunction() inside its own
                        // new function
                        onTapFunction: () => setState(() {
                          categoryDropDownItems.add(DropdownMenuItem(
                            value: widget.categoryIDs[index],
                            child: Text(widget.categoryIDs[index]),
                          ));
                          widget.categoryIDs.remove(widget.categoryIDs[index]);
                        }),
                      );
                    },
                    shrinkWrap: true,
                    itemCount: widget.categoryIDs.length,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                ),
              ],
            ),

            /// Main image picker and preview!
            RedRoundedButton(
              buttonText: 'Escojer Imagen Principal',
              onTapFunction: widget.mainImageOnTapFunction,
            ),
            // check if the main image path have been chosen, we don't want
            // to show this part without it!
            widget.mainImagePath != null
                ? Column(
                    children: [
                      Text('Preview...'),
                      CustomCard(
                        imageAssetPath: widget.mainImagePath,
                        name: business.businessName ?? '',
                        isOffline: !widget.isOnlineMainImage,
                      ),
                    ],
                  )
                : SizedBox(),

            /// Secondary image picker
            RedRoundedButton(
              buttonText: 'Escojer imagenes secundarias',
              onTapFunction: widget.multiImageOnTapFunction,
            ),
            RedRoundedTextField(
              isNumber: true,
              hint: 'Telefono',
              onChangedFunction: (value) => business.phoneNumber,
              initialValue: business.phoneNumber,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Text('Cada renglon, separado por un . es un platillo.'),
                  RedRoundedTextField(
                    isMultiLine: true,
                    hint: 'Platillos favoritos...',
                    onChangedFunction: (value) => dishes = value,
                    initialValue: dishes,
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
                    onChangedFunction: (value) => tips = value,
                    initialValue: tips,
                  ),
                ],
              ),
            ),
            RedRoundedTextField(
              hint: 'Instagram Link',
              onChangedFunction: (value) => business.igLink,
              initialValue: business.igLink,
            ),
            RedRoundedTextField(
              hint: 'Rappi Link',
              onChangedFunction: (value) => business.rappiLink,
              initialValue: business.rappiLink,
            ),
            RedRoundedTextField(
              hint: 'Uber Eats Link',
              onChangedFunction: (value) => business.uberEatsLink,
              initialValue: business.uberEatsLink,
              isTextInputDone: true,
            ),
            RedRoundedSwitch(
              text: 'Activo?',
              value: business.isActive ?? false,
              onChangeFunction: (value) => setState(() {
                business.isActive = value;
              }),
            ),

            /// Submit button
            RedRoundedButton(
              buttonText: widget.finalButtonString,
              onTapFunction: () {
                // We update business lists from our temp variables
                business.tipList = AdminServices.getStringListByDot(tips);
                business.bestPlateList =
                    AdminServices.getStringListByDot(dishes);
                // callback function from parent
                widget.finalOnTapFunction();
              },
            )
          ],
        ),
      ),
    );
  }
}

/// TODO Will delete and refactor or change
class BusinessListItem extends StatelessWidget {
  final String businessID;
  final Function onTapFunction;

  BusinessListItem({this.businessID, this.onTapFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            businessID,
            style: k_16wStyle,
          ),
          GestureDetector(
            child: Icon(Icons.remove_circle),
            onTap: onTapFunction,
          ),
        ],
      ),
    );
  }
}
