import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled1/constants/constants.dart';

import '../dio/dio.dart';

var forgetPasswordEmail = TextEditingController();

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  final _formKey = GlobalKey<FormState>();

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
              const SizedBox(height: 20,),
               Center(child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text("Don't worry it occurs Please enter the email address linked to your account",style: TextStyle(
                    color: labelTextColor,
                    fontSize: 20,
                    fontFamily: 'Constantia Font',

                  ),textAlign: TextAlign.center,))),
              const SizedBox(height: 40,),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: forgetPasswordEmail,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(20),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(22.0),
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
                ),
              ),
              const SizedBox(height: 100),
              MaterialButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await forgetPassword(context);
                    // print(forgetPasswordEmail.text);
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
                      'Send Code',
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
            ],
          ),
        ),
      ),
    );
  }
}
