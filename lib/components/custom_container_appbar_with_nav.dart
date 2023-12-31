import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:line_icons/line_icons.dart";
import "package:responsive_sizer/responsive_sizer.dart";

class CustomContainerAppBarWithNav extends StatelessWidget {
  const CustomContainerAppBarWithNav({ super.key, required this.title, required this.height,
  required this.onTapNav });

  final String title;
  final double height;
  final Function onTapNav;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 100.w,
      height: height,
      padding: const EdgeInsets.all(18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  onTapNav();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xffE3E9ED)),
                  ),
                  child: const Icon(LineIcons.angleLeft, color: Colors.white),
                ),
              ),
              SizedBox(
                width: 18.w,
              ),
              Flexible(
                child: Text(title, style: GoogleFonts.openSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
                ),),
              )
            ],
          ),
        ],
      ),
    );
  }
}