import 'dart:convert';
import 'dart:ui';

import 'package:e9pay_sl_service/service/fileService.dart';
import 'package:e9pay_sl_service/service/googleApiService.dart';
import 'package:e9pay_sl_service/service/uploadService.dart';
import 'package:e9pay_sl_service/widgets/kInputField.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class FormView extends StatefulWidget {
  @override
  _FormViewState createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  TextEditingController textEditingControllerName;
  TextEditingController textEditingControllerPhone;
  SheetService sheetService = SheetService();
  UploadService uploadService = UploadService();
  bool termsAndConditions = false;
  bool showDone = false;
  String userName = '';
  String userPhone = '';
  FilePickerResult videoFile;
  bool loading = false;

  @override
  void initState() { 
    super.initState();
    textEditingControllerName = TextEditingController();
    textEditingControllerPhone = TextEditingController();
  }

  @override
  void dispose() { 
    textEditingControllerName.dispose();
    textEditingControllerPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double devWidth = MediaQuery.of(context).size.width;
    double devHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              width: devWidth,
              height: devHeight,
              child: Image.asset(
                'assets/bgImage.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              width: devWidth,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 16,
                            sigmaY: 16,
                          ),
                          child: Container(
                            width: devWidth > 800 ? 800 : devWidth,
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                            decoration: BoxDecoration(
                              color: Colors.amberAccent.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 1,
                                color: Colors.white.withOpacity(0.4),
                              )
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'E9pay Voice Star',
                                  style: GoogleFonts.poppins(
                                    fontSize: devWidth > 800 ? 800 * 0.05 : devWidth * 0.05
                                  ),
                                ),
                                Text(
                                  'E9pay Sri Lanka   (1899-6943)',
                                  style: GoogleFonts.poppins(
                                    fontSize: devWidth > 800 ? 800 * 0.02 : devWidth * 0.02
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 16,
                            sigmaY: 16,
                          ),
                          child: Container(
                            width: devWidth > 800 ? 800 : devWidth,
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 1,
                                color: Colors.white.withOpacity(0.4),
                              )
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                KTextInput(
                                  text: 'Name',
                                  helperText: 'Enter Your Name',
                                  icon: Icon(Icons.person),
                                  textInputType: TextInputType.name,
                                  textEditingController: textEditingControllerName,
                                  onChanged: (value) {
                                    setState(() {
                                      userName = value;
                                    });
                                  },
                                ),
                                KTextInput(
                                  text: 'Phone Number',
                                  helperText: 'Enter Your E9pay Registerd Phone Number',
                                  icon: Icon(Icons.phone),
                                  textInputType: TextInputType.phone,
                                  textEditingController: textEditingControllerPhone,
                                  onChanged: (value) {
                                    setState(() {
                                      userPhone = value;
                                    });
                                  },
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    'Video File',
                                    style: GoogleFonts.poppins(
                                      fontSize: devWidth > 800 ? 800 * 0.03 : devWidth * 0.03
                                    ),
                                  )
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          videoFile = await FileService.getFile();
                                          setState(() {});
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                          child: Text(
                                            'Select Video',
                                            style: GoogleFonts.poppins(),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        videoFile != null ? videoFile.files.single.name : 'Please Select Your Video',
                                        style: GoogleFonts.poppins(
                                          color: Colors.black
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: termsAndConditions, 
                                        onChanged: (value) {
                                          setState(() {
                                            termsAndConditions = value;                              
                                          });
                                        }
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          style: GoogleFonts.poppins(),
                                          children: <TextSpan> [
                                            TextSpan(text: 'I agree to the'),
                                            TextSpan(
                                              text: ' terms and conditions',
                                              style: GoogleFonts.poppins(
                                                color: Colors.blueAccent
                                              ),
                                              recognizer: TapGestureRecognizer()..onTap = () {
                                                print('Show Terms');
                                              }
                                            )
                                          ]
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          if (userName != null && userName.isNotEmpty && userName.length > 1) {
                                            if (userPhone != null && userPhone.isNotEmpty && userPhone.length > 1) {
                                              if (termsAndConditions) {
                                                if (videoFile != null) {
                                                  setState(() {
                                                    loading = true;
                                                    showDone = false;
                                                  });
                                                  Map<String, dynamic> result = await uploadService.uploadData(videoFile, userName, userPhone);
                                                  if (result["result"]) {
                                                    await sheetService.addData(userName, userPhone, result["fileName"]);
                                                    setState(() {
                                                      showDone = true;
                                                    });
                                                  } else {
                                                    Fluttertoast.showToast(msg: result["msg"]);
                                                  }
                                                } else {
                                                  print("No Video Selected");
                                                  Fluttertoast.showToast(
                                                    msg: "No Video Selected",
                                                    gravity: ToastGravity.TOP,
                                                    backgroundColor: Colors.red,
                                                  );
                                                }
                                              } else {
                                                Fluttertoast.showToast(
                                                  msg: "Please Agree to Terms And Conditions",
                                                  gravity: ToastGravity.TOP,
                                                  backgroundColor: Colors.red,
                                                );
                                              }
                                            } else {
                                              Fluttertoast.showToast(
                                                msg: "Please Enter Phone Number",
                                                gravity: ToastGravity.TOP,
                                                backgroundColor: Colors.red,
                                              );
                                            }
                                          } else {
                                            Fluttertoast.showToast(
                                              msg: "Please Enter Name",
                                              gravity: ToastGravity.TOP,
                                              backgroundColor: Colors.red,
                                            );
                                          }
                                          setState(() {
                                            loading = false;
                                          });
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                          child: Text(
                                            'SUBMIT',
                                            style: GoogleFonts.poppins(),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      loading ? CircularProgressIndicator() : Container(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    showDone ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 16,
                            sigmaY: 16,
                          ),
                          child: Container(
                            width: devWidth > 800 ? 800 : devWidth,
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                            decoration: BoxDecoration(
                              color: Colors.greenAccent.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 1,
                                color: Colors.white.withOpacity(0.4),
                              )
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.done,
                                  size: devWidth > 800 ? 800 * 0.06 : devWidth * 0.06,
                                  color: Colors.blueAccent,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    "Upload Complete!",
                                    style: GoogleFonts.poppins(
                                      fontSize: devWidth > 800 ? 800 * 0.05 : devWidth * 0.05
                                    ),
                                  ),
                                )
                              ],
                            )
                          ),
                        ),
                      ),
                    ) : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

