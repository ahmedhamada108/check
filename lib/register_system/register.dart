import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/constants/constants.dart';
import 'package:untitled1/dio/dio.dart';
import 'package:untitled1/register_system/login.dart';

import '../layout.dart';

var username = TextEditingController();
var email = TextEditingController();
var password = TextEditingController();
var confirmPassword = TextEditingController();

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  bool isPassword = true;
  @override
  void initState() {
    super.initState();
    checkTokenAndNavigate();
  }

  Future<void> checkTokenAndNavigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      // Token exists, navigate to another screen (e.g., HomeScreen)
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const LayoutPage()),
      );
    }
  }
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
                Image.asset(
                  "assets/images/logo.jpeg",
                  width: 300,
                  height: 220,
                  fit: BoxFit.cover,
                ),
                // const Spacer(
                //   flex: 1,
                // ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: username,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
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
                      padding: const EdgeInsets.all(20.0),
                      child: FaIcon(
                        FontAwesomeIcons.userCheck,
                        size: 20,
                        color: labelTextColor,
                      ),
                    ),
                    label: Text(
                      'Username',
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
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
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
                  controller: password,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value != confirmPassword.text) {
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
                  controller: confirmPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please re-enter your password';
                    } else if (value != password.text) {
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
                        signUp(context);
                        // showDialog(context: context, builder: (context) => AlertDialog(content: Text(),));
                        setState(() {
                          loginEmail.text = "";
                          loginPassword.text = "";
                        });
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
                          'Sign Up',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account ?',
                        style: TextStyle(
                          fontSize: 18,
                        )),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: labelTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                // const Spacer(
                //   flex: 2,
                // ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
