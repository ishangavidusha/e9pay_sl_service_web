import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    double devWidth = MediaQuery.of(context).size.width;
    double devHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            width: devWidth,
            height: devHeight,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFFEC72E),
              ),
            ),
          ),
          Positioned(
            top: devHeight * 0.25,
            left: devWidth * 0.1,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'E9pay Remittance',
                    style: GoogleFonts.poppins(
                      fontSize: devWidth * 0.025,
                      color: Color(0xFF765534),
                    ),
                  ),
                  Text(
                    'Sri Lanka',
                    style: GoogleFonts.poppins(
                      fontSize: devWidth * 0.07,
                      color: Color(0xFF765534),
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {

                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF765534)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text(
                        'MORE',
                        style: GoogleFonts.poppins(
                          fontSize: devWidth * 0.015,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}