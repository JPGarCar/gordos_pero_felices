import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class CustomCard extends StatelessWidget {
  final Function onTapFunction;
  final String imageAssetPath;
  final String name;
  final Widget overlay;
  final double height;
  final bool isColorFilter;
  final bool isOffline;

  CustomCard(
      {this.onTapFunction,
      @required this.imageAssetPath,
      this.name,
      this.overlay,
      this.height = k_cardHeight,
      this.isColorFilter = true,
      @required this.isOffline});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunction,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        child: isOffline
            ? CardImageWidget(
                imageProvider: Image.asset(imageAssetPath).image,
                height: height,
                isColorFilter: isColorFilter,
                overlay: overlay,
                name: name)
            : CachedNetworkImage(
                imageUrl: imageAssetPath,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                imageBuilder: (context, ImageProvider image) {
                  return CardImageWidget(
                      imageProvider: image,
                      height: height,
                      isColorFilter: isColorFilter,
                      overlay: overlay,
                      name: name);
                },
              ),
      ),
    );
  }
}

class CardImageWidget extends StatelessWidget {
  const CardImageWidget({
    Key key,
    @required this.height,
    @required this.isColorFilter,
    @required this.overlay,
    @required this.name,
    @required this.imageProvider,
  }) : super(key: key);

  final ImageProvider imageProvider;
  final double height;
  final bool isColorFilter;
  final Widget overlay;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(k_circularBorderRadius),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.fill,
          colorFilter: isColorFilter
              ? ColorFilter.mode(Colors.black54, BlendMode.darken)
              : null,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          overlay ?? SizedBox(),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Text(
                  name ?? '',
                  style: TextStyle(
                    color: k_whiteColor,
                    fontSize: 26,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
