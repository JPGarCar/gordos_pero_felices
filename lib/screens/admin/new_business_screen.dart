import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gordos_pero_felizes/constants.dart';
import 'package:gordos_pero_felizes/firebase_constants.dart';
import 'package:gordos_pero_felizes/services/admin_services.dart';
import 'package:gordos_pero_felizes/services/image_getter.dart';
import 'package:gordos_pero_felizes/widgets/business_editor.dart';
import 'package:gordos_pero_felizes/widgets/dialogs/confirm_dialog.dart';
import 'package:gordos_pero_felizes/widgets/dialogs/yes_no_dialog.dart';
import 'package:gordos_pero_felizes/widgets/loading_gif.dart';
import 'package:gordos_pero_felizes/widgets/parent_widget.dart';
import 'package:gordos_pero_felizes/widgets/title_widget.dart';
import 'dart:io';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:gordos_pero_felizes/models/business.dart';

class NewBusinessScreen extends StatefulWidget {
  static final screenId = 'newBusinessScreen';

  @override
  _NewBusinessScreenState createState() => _NewBusinessScreenState();
}

class _NewBusinessScreenState extends State<NewBusinessScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  /// image paths and list
  File _mainImage;
  List<Asset> images = List<Asset>();

  /// Drop down value, list, and chosen list
  List<String> categoriesIDs = List<String>();

  /// Business object
  Business business = new Business.empty();

  /// Deals with creating the Business object and uploading files to storage
  Future addBusiness() async {
    // path to use for image upload -> name of business
    String initalPath = business.businessName.replaceAll(" ", "");

    // Upload all images and hold image paths
    String mainImagePath = await ImageGetter.uploadImage(
        image: _mainImage,
        imagePath: 'businesses/$initalPath/${initalPath}_main');
    List<String> paths = await AdminServices.uploadImages(
      images: images,
      businessName: business.businessName.replaceAll(" ", ""),
    );

    // Update business information
    business.mainImageAsset = mainImagePath;
    business.imageAssetList = paths;

    // Send business to db
    await business.addBusinessToDB(firebaseFirestore);

    // Update all necessary categories that were chosen to have this business
    categoriesIDs.forEach((element) async {
      await business.addToCategory(element, firebaseFirestore);
    });
  }

  /// We need to fill the categoryDropDown list prior to the page loading, we use
  /// a DropDownItemsGetter function
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ParentWidget(
      bodyChild: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Title Widget with app padding
          Padding(
            // we need to add app padding only to titleWidget, businessEditor
            // already has app padding
            padding: k_appPadding,
            child: TitleWidget(
              isImage: false,
              leftIcon: Icons.arrow_back,
              onPressedLeftIcon: () => Navigator.pop(context),
              mainText: 'Agregar un Negocio Nuevo',
              textStyle: k_16wStyle,
            ),
          ),

          /// Business Editor widget
          Flexible(
            child: BusinessEditor(
              business: business,
              finalOnTapFunction: () {
                showDialog(
                  child: YesNoDialog(
                    dialogText: 'Seguro que queires agregar este negocio?',
                    onNoFunction: () => Navigator.pop(context),
                    onYesFunction: () async {
                      Navigator.pop(context);
                      showDialog(context: context, child: LoadingGif());
                      addBusiness().whenComplete(
                        () {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            child: ConfirmDialog(
                              text: 'El negocio se ha agregado correctamente!',
                              onTapFunction: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                  context: context,
                );
              },

              /// The following vars and callbacks have been kept here
              /// because these are things that will be updated only if
              /// the user confirms the request
              /// TODO change confirmation and data upload to the backend
              categoryIDs: categoriesIDs,
              finalButtonString: 'Agregar Negocio',
              multiImageOnTapFunction: () async {
                images = await ImageGetter.loadAssets();
                return GridView.count(
                  crossAxisCount: 3,
                  children: List.generate(
                    images.length,
                    (index) {
                      Asset asset = images[index];
                      return AssetThumb(
                        asset: asset,
                        width: 250,
                        height: 250,
                      );
                    },
                  ),
                );
              },
              mainImageOnTapFunction: () async {
                _mainImage = await ImageGetter.getImage().then(
                  (value) {
                    setState(() {});
                    return value;
                  },
                );
              },
              mainImagePath: _mainImage?.path,
            ),
          ),
        ],
      ),
    );
  }
}
