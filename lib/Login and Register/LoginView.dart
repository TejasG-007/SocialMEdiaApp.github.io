import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:socialmedia/FirbaseServices/Authentication/Authentication.dart';
import 'package:socialmedia/Login%20and%20Register/ForgotPassword.dart';
import 'package:socialmedia/Login%20and%20Register/RegisterView.dart';
import 'package:socialmedia/Screens/Home/Home.dart';
import 'package:socialmedia/Widgets/BusyButton.dart';
import 'package:socialmedia/Widgets/BusyButtonModel.dart';
import 'package:socialmedia/Widgets/PageBuilderTransition.dart';
import '../locator.dart';
import 'LoginModel.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _loginkey = GlobalKey<FormState>();
  Key key = UniqueKey();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final Auth = locator<Authentication>();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  _getBottomRoutes(double Right) {
    double right = Right;
    return Column(
      children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: RegisterView()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: right),
                    child: Text(
                      "Create New Account   ",
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize: 18,
                          color: Colors.purple,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            )
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context, SlideRightRoute(widget: ForgotView()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: right),
                    child: Text(
                      "Forgotten Password ? ",
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontSize: 18,
                          color: Colors.purple,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldkey,
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (builder, size) {
            //Responsive Sizes for Devices
            double small = 700;
            double medium = 700;
            double large = 1399;
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                  height: size.maxHeight,
                  width: size.maxWidth,
                  child: Scrollbar(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        ClipPath(
                          clipper: DiagonalPathClipperOne(),
                          child: Container(
                            alignment: Alignment.center,
                            height: size.maxWidth < small ? 100 : 100,
                            width: size.maxWidth,
                            color: Colors.teal,
                          ),
                        ),
                        size.maxWidth < small
                            ? Container()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    Image.asset(
                                      "assets/Images/logo.jpeg",
                                      height: 80,
                                    )
                                  ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            size.maxWidth >= small
                                ? Expanded(
                                    flex: 1,
                                    child: Container(
                                      margin: EdgeInsets.all(20),
                                      child: Lottie.asset(
                                          "assets/Lottie/social-media-network.json",
                                          height: size.maxWidth > medium
                                              ? 600
                                              : 200),
                                    ),
                                  )
                                : Container(),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    child: Column(
                                  children: [
                                    size.maxWidth < small
                                        ? Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Lottie.asset(
                                                "assets/Lottie/social-media-network.json",
                                                height: 250,
                                                width: 250),
                                          )
                                        : Container(),
                                    size.maxWidth > small
                                        ? SizedBox(
                                            height: 100,
                                          )
                                        : SizedBox(
                                            height: 20,
                                          ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Get Inside ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1),
                                        FaIcon(
                                          FontAwesomeIcons.doorOpen,
                                          color: Colors.purple,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Consumer<Handler>(
                                      builder: (context, handler, child) =>
                                          Form(
                                              key: _loginkey,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                      padding: size.maxWidth <=
                                                              small
                                                          ? EdgeInsets.only(
                                                              left: 60,
                                                              right: 60)
                                                          : size.maxWidth >=
                                                                      medium &&
                                                                  size.maxWidth <=
                                                                      large
                                                              ? EdgeInsets.only(
                                                                  left: 80,
                                                                  right: 80)
                                                              : EdgeInsets.only(
                                                                  left: 200,
                                                                  right: 200),
                                                      child: TextFormField(
                                                        controller: email,
                                                        validator: (inp) {
                                                          if (inp
                                                              .contains("@")) {
                                                            return "Please Enter Valid Email";
                                                          } else if (inp
                                                              .isEmpty) {
                                                            return "Email Should not be Empty";
                                                          }
                                                          return null;
                                                        },
                                                        cursorColor:
                                                            Colors.purple,
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                .onUserInteraction,
                                                        cursorHeight: 25,
                                                        decoration: InputDecoration(
                                                            prefixIcon: Icon(Icons
                                                                .alternate_email),
                                                            labelText:
                                                                "Enter Email",
                                                            suffixText:
                                                                "@mgmcen.ac.in",
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        10),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .purple)),
                                                            disabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .purple)),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width: 2),
                                                                borderRadius: BorderRadius.circular(10))),
                                                      )),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Padding(
                                                      padding: size.maxWidth <=
                                                              small
                                                          ? EdgeInsets.only(
                                                              left: 60,
                                                              right: 60)
                                                          : size.maxWidth >=
                                                                      medium &&
                                                                  size.maxWidth <=
                                                                      large
                                                              ? EdgeInsets.only(
                                                                  left: 80,
                                                                  right: 80)
                                                              : EdgeInsets.only(
                                                                  left: 200,
                                                                  right: 200),
                                                      child: TextFormField(
                                                        controller: pass,
                                                        validator: (inp) {
                                                          if (inp.isEmpty) {
                                                            return "Password Should not be Empty";
                                                          } else if (inp
                                                                  .length <
                                                              6) {
                                                            return "Password must be at least 6 digits long";
                                                          } else if (!inp
                                                              .contains(RegExp(
                                                                  r'(?=.*?[#?!@$%^&*-])'))) {
                                                            return "Passwords must have at least one special character";
                                                          }
                                                          return null;
                                                        },
                                                        cursorColor:
                                                            Colors.purple,
                                                        obscureText:
                                                            handler.visibility,
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                .onUserInteraction,
                                                        cursorHeight: 25,
                                                        decoration:
                                                            InputDecoration(
                                                                prefixIcon:
                                                                    Icon(Icons
                                                                        .lock_outline),
                                                                labelText:
                                                                    "Password",
                                                                suffixIcon:
                                                                    MouseRegion(
                                                                  cursor:
                                                                      SystemMouseCursors
                                                                          .click,
                                                                  child:
                                                                      GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            handler.Hidepassword();
                                                                          },
                                                                          child: Container(
                                                                              margin: EdgeInsets.only(top: 10),
                                                                              child: handler.visibility ? FaIcon(FontAwesomeIcons.eyeSlash) : FaIcon(FontAwesomeIcons.eye))),
                                                                ),
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    borderSide: BorderSide(
                                                                        color: Colors
                                                                            .purple)),
                                                                disabledBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Colors
                                                                            .purple)),
                                                                enabledBorder: OutlineInputBorder(
                                                                    borderSide: BorderSide(
                                                                        color: Colors
                                                                            .black,
                                                                        width:
                                                                            2),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10))),
                                                      )),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  MouseRegion(
                                                    cursor: SystemMouseCursors.click,
                                                    // margin:const EdgeInsets.symmetric(horizontal: 300,vertical: 5),
                                                    child: Consumer<BusyButtonModel>(
                                                      builder: (context,model,child)=>BusyButton(
                                                        busy:model.getBusy,
                                                        title: "Let Me In",
                                                        onPressed: () async {

                                                          if (_loginkey
                                                              .currentState
                                                              .validate()) {
                                                            model.setBusy=true;
                                                            var result = await Auth
                                                                .loginUser(
                                                                    email.text,
                                                                    pass.text);
                                                            model.setBusy=false;
                                                            if (result is bool) {
                                                              if (result) {
                                                                return Navigator
                                                                    .pushReplacement(
                                                                        context,
                                                                        SlideRightRoute(
                                                                            widget:
                                                                                HomeView()));
                                                              }
                                                            } else if (result ==
                                                                "Email is not Verified" ) {
                                                              return showDialog(
                                                                  context:
                                                                      _scaffoldkey
                                                                          .currentContext,
                                                                  builder:
                                                                      (context) =>
                                                                          AlertDialog(
                                                                            actions: [
                                                                              TextButton(
                                                                                  onPressed: () async {
                                                                                    await FirebaseAuth.instance.currentUser.sendEmailVerification();
                                                                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                                                        content: Text(
                                                                                      "Link send Succefully Please Verify.",
                                                                                      style: TextStyle(color: Colors.teal),
                                                                                    )));
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: Text(
                                                                                    "Resend Verification Link",
                                                                                    style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
                                                                                  ))
                                                                            ],
                                                                            title: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Lottie.asset("assets/Lottie/Gloading.json", height: 80),
                                                                                  Text(
                                                                                    "Login Failed",
                                                                                    style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 25),
                                                                                  ),
                                                                                  Text(
                                                                                    "${result}",
                                                                                    style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.teal),
                                                                                  ),
                                                                                ]),
                                                                          ));
                                                            }else {
                                                              return showDialog(
                                                                  context:
                                                                  _scaffoldkey
                                                                      .currentContext,
                                                                  builder:
                                                                      (context) =>
                                                                      AlertDialog(
                                                                        actions: [
                                                                          TextButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Text(
                                                                                "CLOSE",
                                                                                style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
                                                                              ))
                                                                        ],
                                                                        title:
                                                                        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                                                          Lottie.asset("assets/Lottie/Gloading.json", height: 80),
                                                                          Text(
                                                                            "Login Failed",
                                                                            style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 25),
                                                                          ),
                                                                          Text(
                                                                            "${result}",
                                                                            style: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.teal),
                                                                          )
                                                                        ]),
                                                                      ));
                                                            }
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  size.maxWidth > small
                                                      ? _getBottomRoutes(80)
                                                      : Container()
                                                ],
                                              )),
                                    )
                                  ],
                                )))
                          ],
                        ),
                        size.maxWidth < small
                            ? _getBottomRoutes(15)
                            : Container(),
                      ],
                    ),
                  )),
            );
          },
        ));
  }
}
