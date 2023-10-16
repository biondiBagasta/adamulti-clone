import 'package:adamulti_mobile_clone_new/function/custom_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TopupTextFieldComponent extends StatelessWidget {

  const TopupTextFieldComponent({ Key? key, required this.label, required this.hint, required this.controller,
  required this.validationMessage, required this.prefixIcon, required this.isObsecure }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final String hint;
  final String validationMessage;
  final IconData prefixIcon;
  final bool isObsecure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.black
        ),),
        const SizedBox(height: 6,),
        Container(
          padding: const EdgeInsets.fromLTRB(10,2,10,2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey),
              color: Colors.white
          ),
          child: TextFormField(
            keyboardType: TextInputType.number,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9Rp.-]'))
            ],
            obscureText: isObsecure,
            controller: controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              prefixIcon: Icon(prefixIcon),
              border: InputBorder.none,
              hintText: hint,
              hintStyle: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              errorStyle: const TextStyle(
                fontSize: 14,
              ),
            ),
            onChanged: (value) {
              if(value.isNotEmpty) {
                controller.text = FormatCurrency.convertToIdr(int.parse(value.replaceAll(RegExp(r"\D"), "")), 0);
              }
            },
            validator: (value) {
              if(value!.isEmpty) {
                return validationMessage;
              } else {
                return null;
              }
            },
          ),
        ),
      ],
    );
  }
}