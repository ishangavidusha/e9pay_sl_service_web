import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KTextInput extends StatelessWidget {
  final String text;
  final String helperText;
  final Icon icon;
  final TextInputType textInputType;
  final Function onChanged;
  final TextEditingController textEditingController;

  const KTextInput({Key key, this.text, this.helperText, this.icon, this.textInputType, this.onChanged, this.textEditingController}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          icon: icon,
          labelText: text,
          labelStyle: GoogleFonts.poppins(),
          helperText: helperText,
          helperStyle: GoogleFonts.poppins(),
          hintText: '',
          hintStyle: GoogleFonts.poppins(),
          // errorText: 'Please Enter Your Name',
          // errorStyle: GoogleFonts.poppins(),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        style: GoogleFonts.poppins(),
        keyboardType: textInputType,
        onChanged: onChanged,
      ),
    );
  }
}