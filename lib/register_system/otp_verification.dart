import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled1/constants/constants.dart';
import 'package:untitled1/register_system/create_new_password.dart';

import '../dio/dio.dart';

// var forgetPasswordEmail = TextEditingController();

var firstNumberOfCode = TextEditingController();
var secondNumberOfCode = TextEditingController();
var thirdNumberOfCode = TextEditingController();
var fourthNumberOfCode = TextEditingController();
var fifthNumberOfCode = TextEditingController();
var verificationCode = firstNumberOfCode.text +
    secondNumberOfCode.text +
    thirdNumberOfCode.text +
    fourthNumberOfCode.text +
    fifthNumberOfCode.text;

class OTPVerification extends StatefulWidget {
  const OTPVerification({Key? key}) : super(key: key);

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {

  final _formKey = GlobalKey<FormState>();
  emptyFields(){
    firstNumberOfCode.text = "";
    secondNumberOfCode.text = "";
    thirdNumberOfCode.text = "";
    fourthNumberOfCode.text = "";
    fifthNumberOfCode.text = "";
  }
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Center(child: Image.asset("assets/images/forget_password.png",)),
              const SizedBox(height: 40,),
              Center(child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text("Enter the verification code that has been sent to your registered email",style: TextStyle(
                    color: labelTextColor,
                    fontSize: 20,
                    fontFamily: 'Constantia Font',

                  ),textAlign: TextAlign.center,))),
              const SizedBox(height: 40,),
              Container(
                alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 15),
                  child: Text("Code",style: TextStyle(
                    color: labelTextColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Constantia Font',
                    fontSize: 20,
                  ),)),
              const SizedBox(height: 20,),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: firstNumberOfCode,
                          style: TextStyle(
                            color: labelTextColor,
                            fontSize: 50,
                            // fontFamily: 'Constantia Font',
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,

                          validator: (value) {
                            // if (value == null || value.isEmpty) {
                            //   return 'Please enter your email';
                            // }
                            // return null;
                          },
                          decoration: InputDecoration(
                            // contentPadding: const EdgeInsets.all(20),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: secondNumberOfCode,
                          style: TextStyle(
                            color: labelTextColor,
                            fontSize: 50,
                            // fontFamily: 'Constantia Font',
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          validator: (value) {
                            // if (value == null || value.isEmpty) {
                            //   return 'Please enter your email';
                            // }
                            // return null;
                          },
                          decoration: InputDecoration(
                            // contentPadding: const EdgeInsets.all(20),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: thirdNumberOfCode,
                          style: TextStyle(
                            color: labelTextColor,
                            fontSize: 50,
                            // fontFamily: 'Constantia Font',
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          validator: (value) {
                            // if (value == null || value.isEmpty) {
                            //   return 'Please enter your email';
                            // }
                            // return null;
                          },
                          decoration: InputDecoration(
                            // contentPadding: const EdgeInsets.all(20),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: fourthNumberOfCode,
                          style: TextStyle(
                            color: labelTextColor,
                            fontSize: 50,
                            // fontFamily: 'Constantia Font',
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          validator: (value) {
                            // if (value == null || value.isEmpty) {
                            //   return 'Please enter your email';
                            // }
                            // return null;
                          },
                          decoration: InputDecoration(
                            // contentPadding: const EdgeInsets.all(20),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: fifthNumberOfCode,
                          style: TextStyle(
                            color: labelTextColor,
                            fontSize: 50,
                            // fontFamily: 'Constantia Font',
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          validator: (value) {
                            // if (value == null || value.isEmpty) {
                            //   return 'Please enter your email';
                            // }
                            // return null;
                          },
                          decoration: InputDecoration(
                            // contentPadding: const EdgeInsets.all(20),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 60),
              MaterialButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await verifyCode(context);
                    print(firstNumberOfCode.text);
                    print(secondNumberOfCode.text);
                    print(thirdNumberOfCode.text);
                    print(fourthNumberOfCode.text);
                    print(fifthNumberOfCode.text);
                    print(verificationCode);
                    emptyFields();
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
                      'Verify',
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Didn\'t receive a code ?',
                      style: TextStyle(
                        fontSize: 18,
                      )),
                  TextButton(
                    onPressed: () async{
                      await forgetPassword(context);
                    },
                    child: Text(
                      'Resend',
                      style: TextStyle(
                        color: labelTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
