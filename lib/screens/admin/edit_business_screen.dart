import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_button.dart';
import 'package:gordos_pero_felizes/widgets/red_rounded/red_rounded_dropdown.dart';
import 'package:gordos_pero_felizes/widgets/title_widget.dart';

class EditBusinessScreen extends StatefulWidget {
  static final String screenId = 'editBusinessScreen';

  @override
  _EditBusinessScreenState createState() => _EditBusinessScreenState();
}

class _EditBusinessScreenState extends State<EditBusinessScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String documentSnapshot;

  List<DropdownMenuItem> dropDownItemsList;

  /// Deals with grabbing all the businesses
  void getDropDownBusinesses() async {
    List<DropdownMenuItem> dropDownItems = List<DropdownMenuItem>();

    await firebaseFirestore
        .collection('businesses')
        .get()
        .then((QuerySnapshot value) {
      value.docs.forEach((QueryDocumentSnapshot element) {
        dropDownItems.add(
          DropdownMenuItem(
            value: element.id,
            child: Text(element.id),
          ),
        );
      });
      dropDownItemsList = dropDownItems;
      setState(() {});
    });
  }

  @override
  void initState() {
    getDropDownBusinesses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: k_appPadding,
          child: Column(
            children: [
              TitleWidget(
                isImage: false,
                leftIcon: Icons.arrow_back,
                onPressedLeftIcon: () => Navigator.pop(context),
                mainText: 'Editar Negocio',
                textStyle: k_16wStyle,
              ),
              Text('Porfavor selecione un negocio a editar.'),
              dropDownItemsList != null
                  ? RedRoundedDropDown(
                      hint: 'Negocio',
                      value: documentSnapshot,
                      onChangeFunction: (value) {
                        setState(() {
                          documentSnapshot = value;
                        });
                      },
                      dropDownItems: dropDownItemsList,
                    )
                  : SizedBox(), // TODO change to load asset
              documentSnapshot != null
                  ? RedRoundedButton(
                      buttonText: 'Editar Negocio',
                      onTapFunction: () {} // TODO,
                      )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
