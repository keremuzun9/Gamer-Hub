import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:animated_background/animated_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamer_hub/models/api_acces.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

bool _isLoading = false;
bool _isPasswordVisible = false;
bool _isPasswordVisible1 = false;
bool _isClicked = false;
bool _isPasswordEight = false;
bool _isPasswordOneNumber = false;
final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
///////////////////////////////////////////
String _password = "",
    _confirmPassword = "",
    _name = "",
    _surname = "",
    _email = "";
DateTime _dateTime = DateTime.utc(2000, 11, 18);
String _gender = "Male";
///////////////////////////////////////////

//Color(0xFF2E3239)
class _SignupPageState extends State<SignupPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      bool _isPasswordEight = false;
      bool _isPasswordOneNumber = false;
      super.initState();
    }

    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[Color(0xFF2E3239), Colors.black])),
            child: AnimatedBackground(
              vsync: this,
              behaviour: RandomParticleBehaviour(
                  options: const ParticleOptions(
                      baseColor: Colors.white,
                      spawnMinSpeed: 6,
                      spawnMaxSpeed: 15,
                      spawnOpacity: 0.3,
                      particleCount: 30,
                      opacityChangeRate: 1,
                      maxOpacity: 0.6,
                      minOpacity: 0.3,
                      spawnMaxRadius: 10,
                      spawnMinRadius: 5)),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      height: 600,
                      width: 350,
                      decoration:
                          BoxDecoration(color: Colors.white.withOpacity(0.2)),
                      child: Form(
                        key: _formkey,
                        //autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: ListView(children: [
                          Row(children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Listener(
                              onPointerUp: (_) => setState(() {
                                _isClicked = false;
                              }),
                              onPointerDown: (_) => setState(() {
                                _isClicked = true;
                              }),
                              child: IconButton(
                                icon: Icon(Icons.arrow_back_ios,
                                    color: _isClicked
                                        ? Colors.white
                                        : Colors.black),
                                onPressed: () {
                                  Navigator.pop(context);
                                  if (_isPasswordEight ||
                                      _isPasswordOneNumber) {
                                    _isPasswordEight = false;
                                    _isPasswordOneNumber = false;
                                  }
                                },
                              ),
                            )
                          ]),
                          SizedBox(
                            child: Center(
                                child: Image.asset("assets/images/signup.png")),
                            height: 80,
                            width: 80,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 20, 40, 15),
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              style: GoogleFonts.montserrat(),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Name Cannot Be Left Blank.";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (String? name) {
                                _name = name!;
                              },

                              cursorColor: Colors.white,
                              textInputAction: TextInputAction.done, //tik
                              decoration: const InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                  labelText: "NAME",
                                  labelStyle: TextStyle(
                                      fontSize: 17, color: Colors.black)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 20, 40, 15),
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              style: GoogleFonts.montserrat(),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Surame Cannot Be Left Blank.";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (String? surname) {
                                _surname = surname!;
                              },

                              cursorColor: Colors.white,
                              textInputAction: TextInputAction.done, //tik
                              decoration: const InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                  labelText: "SURNAME",
                                  labelStyle: TextStyle(
                                      fontSize: 17, color: Colors.black)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 20, 40, 15),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              style: GoogleFonts.montserrat(),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email Cannot Be Left Blank.";
                                } else if (!EmailValidator.validate(value)) {
                                  return "Please Enter A Valid Email.";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (String? email) {
                                _email = email!;
                              },

                              cursorColor: Colors.white,
                              textInputAction: TextInputAction.done, //tik
                              decoration: const InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.black,
                                  ),
                                  labelText: "EMAIL",
                                  labelStyle: TextStyle(
                                      fontSize: 17, color: Colors.black)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 20, 40, 15),
                            child: TextFormField(
                              style: GoogleFonts.montserrat(
                                  color: !_isPasswordVisible
                                      ? Colors.white
                                      : Colors.black),
                              obscureText: !_isPasswordVisible,
                              onSaved: (String? password) {
                                _password = password!;
                              },
                              onChanged: (password) {
                                onPasswordChanged(password);
                                _password = password;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password Cannot Be Left Blank.";
                                } else if (!_isPasswordEight ||
                                    !_isPasswordOneNumber) {
                                  return "Insecure Password";
                                } else {
                                  return null;
                                }
                              },
                              textInputAction: TextInputAction.go, //ok
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  prefixIcon: const Icon(
                                    Icons.password_rounded,
                                    color: Colors.black,
                                  ),
                                  suffixIcon: IconButton(
                                      color: _isPasswordVisible
                                          ? Colors.white
                                          : Colors.black,
                                      onPressed: () {
                                        setState(() {
                                          _isPasswordVisible =
                                              !_isPasswordVisible;
                                        });
                                      },
                                      icon: _isPasswordVisible
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off)),
                                  labelText: "PASSWORD",
                                  labelStyle: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                  )),
                            ),
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 40),
                              AnimatedContainer(
                                duration: const Duration(microseconds: 500),
                                width: 20,
                                height: 20,
                                child: Center(
                                  child: Icon(
                                    Icons.check,
                                    color: _isPasswordEight
                                        ? Colors.black
                                        : Colors.transparent,
                                    size: 15,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: _isPasswordEight
                                        ? Colors.white
                                        : Colors.transparent,
                                    border: _isPasswordEight
                                        ? Border.all(color: Colors.transparent)
                                        : Border.all(
                                            color: Colors.grey.shade600),
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Contains at least 8 characters.",
                                style: GoogleFonts.montserrat(),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 40),
                              AnimatedContainer(
                                duration: const Duration(microseconds: 500),
                                width: 20,
                                height: 20,
                                child: Center(
                                  child: Icon(
                                    Icons.check,
                                    color: _isPasswordOneNumber
                                        ? Colors.black
                                        : Colors.transparent,
                                    size: 15,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: _isPasswordOneNumber
                                      ? Colors.white
                                      : Colors.transparent,
                                  border: _isPasswordOneNumber
                                      ? Border.all(color: Colors.transparent)
                                      : Border.all(color: Colors.grey.shade600),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Contains at least 1 number.",
                                style: GoogleFonts.montserrat(),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 20, 40, 15),
                            child: TextFormField(
                              style: GoogleFonts.montserrat(
                                  color: !_isPasswordVisible1
                                      ? Colors.white
                                      : Colors.black),
                              obscureText: !_isPasswordVisible1,
                              onChanged: (String confirmPassword) {
                                _confirmPassword = confirmPassword;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return " Verify Password Cannot Be Left Blank.";
                                } else if (_password != _confirmPassword) {
                                  return "Password Do Not Match";
                                } else {
                                  return null;
                                }
                              },
                              textInputAction: TextInputAction.go, //ok
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  prefixIcon: const Icon(
                                    Icons.password_rounded,
                                    color: Colors.black,
                                  ),
                                  suffixIcon: IconButton(
                                      color: _isPasswordVisible1
                                          ? Colors.white
                                          : Colors.black,
                                      onPressed: () {
                                        setState(() {
                                          _isPasswordVisible1 =
                                              !_isPasswordVisible1;
                                        });
                                      },
                                      icon: _isPasswordVisible1
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off)),
                                  labelText: "VERIFY PASSWORD",
                                  labelStyle: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                  )),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                              child: Text(
                                "BIRTHDATE",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(fontSize: 18),
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.25, color: Colors.white12),
                                        color: Colors.white.withOpacity(0.05),
                                      ),
                                      child: buildDatePicker()))),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                              child: Column(children: [
                                Text("GENDER",
                                    style:
                                        GoogleFonts.montserrat(fontSize: 18)),
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  child: Icon(
                                    _gender == "Male" ? Icons.man : Icons.woman,
                                    size: 60,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(children: [
                                      Radio(
                                        autofocus: true,
                                        activeColor: Colors.white,
                                        value: "Male",
                                        groupValue: _gender,
                                        onChanged: (String? value) {
                                          _gender = value!;
                                          setState(() {
                                            debugPrint(_gender);
                                          });
                                        },
                                      ),
                                      Text("MALE",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 13))
                                    ]),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(children: [
                                          Radio(
                                            activeColor: Colors.white,
                                            autofocus: false,
                                            value: "Female",
                                            groupValue: _gender,
                                            onChanged: (String? value) {
                                              _gender = value!;
                                              setState(() {
                                                debugPrint(_gender);
                                              });
                                            },
                                          ),
                                          Text("FEMALE",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 13))
                                        ]),
                                      ],
                                    )
                                  ],
                                )
                              ])),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
                            child: OutlinedButton(
                                onPressed: () async {
                                  if (_formkey.currentState!.validate()) {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    await register(
                                        _email,
                                        _name + " " + _surname,
                                        _gender,
                                        _password,
                                        _dateTime);
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                },
                                child: _isLoading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 15,
                                            width: 15,
                                            child: Image.asset(
                                                "assets/gifs/loading.gif"),
                                            // child: CircularProgressIndicator(
                                            //   color: Colors.white,
                                            // ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Text("Please Wait",
                                              style: GoogleFonts.montserrat())
                                        ],
                                      )
                                    : Text("Register",
                                        style: GoogleFonts.montserrat()),
                                style: OutlinedButton.styleFrom(
                                    primary: Colors.white,
                                    backgroundColor: Colors.grey.shade900)),
                          )
                        ]),
                      ),
                    ),
                  ),
                ),
              ),
            )));
  }

  void onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');
    setState(() {
      _isPasswordEight = false;
      if (password.length >= 8) {
        _isPasswordEight = true;
      }

      _isPasswordOneNumber = false;
      if (numericRegex.hasMatch(password)) {
        _isPasswordOneNumber = true;
      }
    });
  }

  Widget buildDatePicker() {
    DateTime date = DateTime.now();
    return SizedBox(
      height: 60,
      child: CupertinoDatePicker(
        dateOrder: DatePickerDateOrder.dmy,
        initialDateTime: _dateTime,
        maximumDate: date,
        mode: CupertinoDatePickerMode.date,
        onDateTimeChanged: (dateTime) {
          setState(() {
            _dateTime = dateTime;
            debugPrint(_dateTime.toString());
          });
        },
      ),
    );
  }

  Future register(String email, String fullname, String gender, String password,
      DateTime birthdate) async {
    try {
      var body = {
        "Name": fullname,
        "Email": email,
        "Gender": gender,
        "Password": password,
        "BirthDate": birthdate.toString()
      };
      var response =
          await http.post(Uri.https(ApiAcces.baseUrl, "Api/Users/Register"),
              headers: {
                "content-type": "application/json",
                "accept": "application/json",
              },
              body: jsonEncode(body));
      var data = response.body;
      debugPrint(data);
      if (response.statusCode == 200) {
        debugPrint(data);
        showAlertDialogSucces(context, "assets/gifs/signup.gif");
      } else if (response.statusCode == 400) {
        debugPrint(data);
        showAlertDialogError(context, data, "assets/gifs/error.gif");
      } else {
        showAlertDialogNetwork(context, "assets/gifs/internet.gif");
      }
    } on SocketException {
      showAlertDialogNetwork(context, "assets/gifs/internet.gif");
    }
  }

  dynamic showAlertDialogError(
      BuildContext context, var data, String assetGif) {
    // set up the button
    Widget okButton = OutlinedButton(
      style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white, primary: Colors.grey.shade800),
      child: Text("Got it!", style: GoogleFonts.montserrat(fontSize: 18)),
      onPressed: () {
        Navigator.pop(context);
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(assetGif),
                  ),
                ),
                const SizedBox(height: 15),
                Text(data,
                    style: GoogleFonts.montserrat(
                        color: Colors.white, fontSize: 15)),
                const SizedBox(height: 15),
                okButton
              ],
            ),
          ),
        );
      },
    );
  }

  dynamic showAlertDialogSucces(BuildContext context, String assetGif) {
    // set up the button
    Widget okButton = OutlinedButton(
      style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white, primary: Colors.grey.shade800),
      child: Text("Let's Start!", style: GoogleFonts.montserrat(fontSize: 18)),
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
                Text("Welcome Gamer!",
                    style: GoogleFonts.montserrat(
                        color: Colors.white, fontSize: 20)),
                const SizedBox(height: 18),
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
          backgroundColor: Colors.white, primary: Colors.grey.shade800),
      child: Text("Try Again!", style: GoogleFonts.montserrat(fontSize: 15)),
      onPressed: () {
        Navigator.pop(context);
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
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
                Text("Please Make Sure You Are Online.",
                    style: GoogleFonts.montserrat(
                        color: Colors.white, fontSize: 15)),
                const SizedBox(height: 18),
                okButton
              ],
            ),
          ),
        );
      },
    );
  }
}
