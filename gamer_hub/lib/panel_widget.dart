import 'dart:convert';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gamer_hub/home_page.dart';
import 'package:gamer_hub/models/user_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:http/http.dart' as http;

class PanelWidget extends StatefulWidget {
  final ScrollController controller;
  final PanelController panelController;
  const PanelWidget(
      {Key? key, required this.controller, required this.panelController})
      : super(key: key);

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

bool isLoading = false;
///////////////////////////////
String _email = "";
String _password = "";
///////////////////////////////
final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
bool isPasswordVisible = false;
bool isPressed1 = false;
bool isPressed2 = false;

class _PanelWidgetState extends State<PanelWidget> {
  @override
  Widget build(BuildContext context) {
    Offset distance = isPressed1 ? const Offset(4, 4) : const Offset(17, 17);
    double blur = isPressed1 ? 5.0 : 30.0;
    Offset distance2 = isPressed2 ? const Offset(4, 4) : const Offset(17, 17);
    double blur2 = isPressed2 ? 5.0 : 30.0;
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Container(
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              height: 450,
              width: 370,
              color: Colors.grey[300],
              child: Form(
                key: _formkey,
                child: ListView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  controller: widget.controller,
                  children: <Widget>[
                    buildDragHande(),
                    const SizedBox(height: 23),
                    SizedBox(
                      child: Image.asset("assets/images/signin.png"),
                      height: 100,
                      width: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: GoogleFonts.montserrat(),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email Cannot Be Left Blank.";
                          } else if (!EmailValidator.validate(value)) {
                            return "Please Enter A Valid Email.";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _email = value!;
                        },
                        onChanged: (value) {
                          _email = value;
                        },
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.done, //tik
                        decoration: InputDecoration(
                            //errorStyle: TextStyle(color: Colors.deepOrange),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade800)),
                            prefixIcon: Image.asset("assets/images/person1.png",
                                height: 20, width: 10),
                            labelText: "E-MAIL",
                            labelStyle: const TextStyle(
                                fontSize: 17, color: Colors.black)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 5),
                      child: TextFormField(
                        style: GoogleFonts.montserrat(
                            color: !isPasswordVisible
                                ? Colors.grey.shade900
                                : Colors.black),
                        obscureText: !isPasswordVisible,
                        onChanged: (value) {
                          _password = value;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == "") {
                            return "Password Cannot Be Left Blank.";
                          } else {
                            return null;
                          }
                        },
                        textInputAction: TextInputAction.go, //ok
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade800)),
                            prefixIcon: const Icon(
                              Icons.password_rounded,
                              color: Colors.black,
                            ),
                            suffixIcon: IconButton(
                                color: Colors.black,
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                                icon: isPasswordVisible
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off)),
                            labelText: "PASSWORD",
                            labelStyle: const TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Listener(
                            onPointerUp: (_) => setState(() {
                              isPressed1 = false;
                              Navigator.pushNamed(context, '/SignupPage');
                            }),
                            onPointerDown: (_) => setState(() {
                              isPressed1 = true;
                            }),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 100),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey[300],
                                  boxShadow: [
                                    BoxShadow(
                                        offset: -distance,
                                        color: Colors.white,
                                        blurRadius: blur,
                                        inset: isPressed1),
                                    BoxShadow(
                                        offset: distance,
                                        color: const Color(0xFFA7A9AF),
                                        blurRadius: blur,
                                        inset: isPressed1)
                                  ]),
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: Center(
                                  child: SizedBox(
                                    child:
                                        Image.asset("assets/images/joinb.png"),
                                    height: isPressed1 ? 68 : 70,
                                    width: isPressed1 ? 68 : 70,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Listener(
                            onPointerUp: (_) {
                              setState(() {
                                isPressed2 = false;
                                isLoading = true;
                                if (_formkey.currentState!.validate()) {
                                setState(() {
                                  login(_email, _password);
                                  isLoading = false;
                                });
                              }else{
                                setState(() {
                                  isLoading = false;
                                });
                              }
                                });
                              // if (_formkey.currentState!.validate()) {
                              //   login(_email, _password);
                              // }
                              // setState(() {
                              //   isLoading = false;
                            }
                            ,
                            onPointerDown: (_) => setState(() {
                              isPressed2 = true;
                            }),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 100),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey[300],
                                  boxShadow: [
                                    BoxShadow(
                                        offset: -distance2,
                                        color: Colors.white,
                                        blurRadius: blur2,
                                        inset: isPressed2),
                                    BoxShadow(
                                        offset: distance2,
                                        color: const Color(0xFFA7A9AF),
                                        blurRadius: blur2,
                                        inset: isPressed2)
                                  ]),
                              child: SizedBox(
                                height: 100,
                                width: 100,
                                child: Center(
                                  child: SizedBox(
                                    child: isLoading ? Image.asset("assets/gifs/loading.gif") : Image.asset("assets/images/signb.png"),
                                    height: isPressed2 ? 98 : 100,
                                    width: isPressed2 ? 98 : 100,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDragHande() {
    return GestureDetector(
      child: Center(
        child: Container(
          width: 50,
          height: 7,
          decoration: const BoxDecoration(
              color: Colors.white, //Colors.grey[400],
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      ),
      onTap: () {
        if (widget.panelController.isPanelOpen) {
          widget.panelController.close();
        } else {
          widget.panelController.open();
        }
      },
    );
  }

  Future login(String email, String password) async {
    try{
      showAlertDialogAwait(context);
    var body = {
      "Email": email,
      "Password": password,
    };
    var response = await http.post(
        Uri.https("1ce6-46-196-74-101.eu.ngrok.io", "Api/Users/Login"),
        headers: {
          "content-type": "application/json",
          "accept": "application/json",
        },
        body: jsonEncode(body));
    var data = response.body;
    if (response.statusCode == 200) {
      debugPrint(data);
      UserModel user = UserModel.fromMap(jsonDecode(data));  
      debugPrint(user.token);
      debugPrint(user.id.toString());
      debugPrint(user.name);   
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePage(user : user)), (route) => false);
    } else if(response.statusCode==400) {
      showAlertDialogError(context, data);
    } else {
      showAlertDialogNetwork(context, "assets/gifs/internet.gif");
    }
    }on SocketException {
      showAlertDialogNetwork(context, "assets/gifs/internet.gif");
    }
  }

  showAlertDialogError(BuildContext context, var data) {
    // set up the button
    Widget okButton = OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        primary: Colors.grey.shade800
        ),
      child: Text("Got it!", style: GoogleFonts.montserrat(fontSize: 18)),
      onPressed: () {
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
    );
    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(

          backgroundColor: Colors.grey.shade900,
          elevation: 20,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                const SizedBox(
                  width: 100,
                  height: 100,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/gifs/error.gif"),
                  ),
                ),
                const SizedBox(height: 15),
                Text(data, style: GoogleFonts.montserrat(color: Colors.white, fontSize: 15)),
                const SizedBox(height: 15),
                okButton
              ],
            ),
          ),
        );
      },
    );
  }
  dynamic showAlertDialogNetwork(BuildContext context, String assetGif) {
  // set up the button
  Widget okButton = OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        primary: Colors.grey.shade800
        ),
      child: Text("Try Again!", style: GoogleFonts.montserrat(fontSize: 15)),
      onPressed: () {
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
    );
  // show the dialog
  showDialog(
    barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.grey.shade900,
          elevation: 20,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 18),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(assetGif),
                  ),
                ),
                const SizedBox(height: 18),
                Text("Please Make Sure You Are Online.", style: GoogleFonts.montserrat(color: Colors.white,
                fontSize: 15
                )
                ),
                const SizedBox(height: 18),
                okButton
              ],
            ),
          ),
        );
      },
    );
}
dynamic showAlertDialogAwait(BuildContext context) {
  showDialog(
    barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.grey.shade900,
          elevation: 20,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 18),
                const SpinKitWave(
                color: Colors.white,
              ),
                const SizedBox(height: 18),
                Text("Please Wait...", style: GoogleFonts.montserrat(color: Colors.white,
                fontSize: 15
                )
                ),
                const SizedBox(height: 18),
              ],
            ),
          ),
        );
      },
    );
}

}
