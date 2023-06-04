import 'package:untitled1/Home/home_page.dart';
import 'package:untitled1/constants/constants.dart';
import 'package:untitled1/dio/dio.dart';
import 'package:untitled1/layout.dart';
import 'package:untitled1/register_system/forget_password.dart';
import 'package:untitled1/register_system/register.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled1/screens/Home.dart';
import 'package:untitled1/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';


var loginEmail = TextEditingController();
var loginPassword = TextEditingController();

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100,),
                Image.asset(
                  "assets/images/logo.jpeg",
                  width: 300,
                  height: 220,
                  fit: BoxFit.cover,
                ),
                // const Spacer(
                //   flex: 2,
                // ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: loginEmail,
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
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: loginPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    // else if (value != confirmPassword.text) {
                    //   return 'wrong';
                    // }
                    return null;
                  },
                  obscureText: isPassword,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(),
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
                  height: 50,
                ),
                Center(
                  child: Column(
                    children: [
                      MaterialButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await login(context);
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
                              'Login',
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
                      const SizedBox(height: 20,),
                      // MaterialButton(
                      //   onPressed: () async {
                      //     logout();
                      //   },
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(44),
                      //   ),
                      //   color: backgroundButtonColorTwo,
                      //   child: const SizedBox(
                      //     width: 150,
                      //     height: 60,
                      //     child: Center(
                      //       child: Text(
                      //         'Logout',
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           fontFamily: 'Franklin Gothic',
                      //           fontWeight: FontWeight.normal,
                      //           fontSize: 30,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                 Center(
                  child: TextButton(
                    child: Text('Forget Password ?',
                        style: TextStyle(
                          fontSize: 18,
                          color: labelTextColor,
                          fontWeight: FontWeight.bold,
                        )),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPassword()));

                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account ?',
                        style: TextStyle(
                          fontSize: 18,
                        )),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => Register()));
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: labelTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                // const Spacer(),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
