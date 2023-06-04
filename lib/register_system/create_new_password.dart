import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled1/constants/constants.dart';
import 'package:untitled1/dio/dio.dart';
import 'package:untitled1/register_system/login.dart';

var emailForNewPassword = TextEditingController();
var newPassword = TextEditingController();
var confirmNewPassword = TextEditingController();

class CreateNewPassword extends StatefulWidget {
  CreateNewPassword({Key? key}) : super(key: key);

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final _formKey = GlobalKey<FormState>();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          // appBar: AppBar(leading: Image.asset("assets/images/logo.jpeg",height: 250, width: 100,),backgroundColor: Colors.white),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 300),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailForNewPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: FaIcon(
                            FontAwesomeIcons.solidEnvelope,
                            size: 20,
                            color: labelTextColor,
                          ),
                        ),
                        label: Text(
                          'Email',
                          style: TextStyle(
                            color: labelTextColor,
                            fontSize: 20,
                            fontFamily: 'Constantia Font',
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: newPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value != confirmNewPassword.text) {
                          return 'password must match';
                        }
                        return null;
                      },
                      obscureText: isPassword,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: isPassword
                                ? FaIcon(
                              FontAwesomeIcons.solidEyeSlash,
                              size: 20,
                              color: labelTextColor,
                            )
                                : FaIcon(
                              FontAwesomeIcons.solidEye,
                              size: 20,
                              color: labelTextColor,
                            ),
                            onPressed: () {
                              setState(() {
                                isPassword = !isPassword;
                              });
                            },
                          ),
                        ),
                        label: Text(
                          'Password',
                          style: TextStyle(
                            color: labelTextColor,
                            fontSize: 20,
                            fontFamily: 'Constantia Font',
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: confirmNewPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please re-enter your password';
                        } else if (value != newPassword.text) {
                          return 'password must match';
                        }
                        return null;
                      },
                      obscureText: isPassword,
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        suffixIcon: isPassword
                            ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.solidEyeSlash,
                              size: 20,
                              color: labelTextColor,
                            ),
                            onPressed: () {
                              setState(() {
                                isPassword = !isPassword;
                              });
                            },
                          ),
                        )
                            : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.solidEye,
                              size: 20,
                              color: labelTextColor,
                            ),
                            onPressed: () {
                              setState(() {
                                isPassword = !isPassword;
                              });
                            },
                          ),
                        ),
                        label: Text(
                          'Confirm Password',
                          style: TextStyle(
                            color: labelTextColor,
                            fontSize: 20,
                            fontFamily: 'Constantia Font',
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // const Spacer(flex: 3),
                    const SizedBox(height: 50),
                    Center(
                      child: MaterialButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await createNewPassword(context);

                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(44),
                        ),
                        color: backgroundButtonColorTwo,
                        child: const SizedBox(
                          width: 150,
                          height: 60,
                          child: Center(
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Franklin Gothic',
                                fontWeight: FontWeight.normal,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
