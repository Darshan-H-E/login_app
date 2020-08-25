import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerticalText extends StatefulWidget {
  VerticalText(this.data);
  final String data;
  @override
  _VerticalTextState createState() => _VerticalTextState();
}

class _VerticalTextState extends State<VerticalText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 10),
      child: RotatedBox(
          quarterTurns: -1,
          child: Text(
           widget.data,
            style: GoogleFonts.lato(
              color: Colors.green[500],
              // color: Color(0xff141d26),
              fontSize: 50,
              letterSpacing: -3,
              fontWeight: FontWeight.w300,
            ),
          )),
    );
  }
}
