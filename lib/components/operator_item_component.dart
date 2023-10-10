import "package:adamulti_mobile_clone_new/components/ribbon_clipper.dart";
import "package:adamulti_mobile_clone_new/constant/constant.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class OperatorItemComponent extends StatelessWidget {

  const OperatorItemComponent({ super.key, required this.operatorName, required this.operatorColor,
  required this.imageUrl, required this.title, required this.onTap });

  final String operatorName;
  final Color operatorColor;
  final String imageUrl;
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Card(
        elevation: 2,
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: SizedBox(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipPath(
                    clipper: ArcClipper(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      width: size.width * 0.5,
                      decoration: BoxDecoration(
                        color: operatorColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2, bottom: 2, left: 2, right: 10),
                        child: AutoSizeText(
                          operatorName,
                          maxFontSize: 14,
                          maxLines: 1,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    child: ClipPath(
                      clipper: TriangleClipper(),
                      child: Container(
                        width: 10.0,
                        height: 10.0,
                        color: operatorColor.withAlpha(700),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: kLightBackgroundColor
                      ),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        width: 42,
                        height: 42,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 18,),
                    Flexible(
                      child: Text(title, style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}