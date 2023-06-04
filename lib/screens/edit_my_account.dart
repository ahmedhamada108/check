import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled1/constants/constants.dart';

import '../dio/dio.dart';

var updateUsername = TextEditingController();
var updateEmail = TextEditingController();
var updatePassword = TextEditingController();
var updateConfirmPassword = TextEditingController();
// var imagePath ;

class EditMyAccount extends StatefulWidget {
  const EditMyAccount({Key? key}) : super(key: key);

  @override
  State<EditMyAccount> createState() => _EditMyAccountState();
}

class _EditMyAccountState extends State<EditMyAccount> {
  final _formKey = GlobalKey<FormState>();

  bool isPassword = true;
  File? imageFile;
  var _pickedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  controller: updateUsername,
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
                  controller: updateEmail,
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
                  controller: updatePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value != updateConfirmPassword.text) {
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
                  controller: updateConfirmPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please re-enter your password';
                    } else if (value != updatePassword.text) {
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
                const SizedBox(
                  height: 20,
                ),
                // TextFormField(
                //   controller: imagePath,
                //
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please upload your photo';
                //     }
                //     return null;
                //   },
                //   decoration: InputDecoration(
                //     contentPadding: const EdgeInsets.all(20),
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(30),
                //     ),
                //     suffixIcon: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: IconButton(
                //         icon: FaIcon(
                //           FontAwesomeIcons.camera,
                //           size: 20,
                //           color: labelTextColor,
                //         ),
                //         onPressed: () async {
                //           File _image;
                //           final picker = ImagePicker();
                //
                //           var _pickedFile = await picker.pickImage(
                //               source: ImageSource.gallery,
                //               maxHeight: 500, // <- reduce the image size
                //               maxWidth: 500);
                //
                //           setState(() {
                //              imagePath = _pickedFile!.path as TextEditingController;
                //           });
                //         },
                //         style: ButtonStyle(
                //           backgroundColor:
                //               MaterialStateProperty.all(Colors.blue),
                //           padding:
                //               MaterialStateProperty.all(EdgeInsets.all(12)),
                //           textStyle: MaterialStateProperty.all(
                //               TextStyle(fontSize: 16)),
                //         ),
                //       ),
                //     ),
                //     label: Text(
                //       'Upload Your Image',
                //       style: TextStyle(
                //         color: labelTextColor,
                //         fontSize: 20,
                //         fontFamily: 'Constantia Font',
                //         // fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(

                        padding: const EdgeInsets.all(20),
                        alignment: Alignment.center,
                        width: 200,
                        height: 200,
                        child: imageFile != null ?
                        Container(
                            width: 200,
                            height: 200,
                            child: Image.file(imageFile!,fit: BoxFit.cover)) :
                        const Text("press on the icon to upload your photo",style: TextStyle(
                          fontSize: 20,
                        )),

                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: FaIcon(
                            FontAwesomeIcons.camera,
                            size: 20,
                            color: labelTextColor,
                          ),
                          onPressed: () async {
                            File _image;
                            final picker = ImagePicker();

                            _pickedFile = await picker.pickImage(
                              source: ImageSource.gallery,
                              maxHeight: 500, // <- reduce the image size
                              maxWidth: 500,
                            );
                            setState(() {
                              imageFile = File(_pickedFile!.path);
                            });
                            print(_pickedFile!.path);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.blue),
                            padding:
                            MaterialStateProperty.all(const EdgeInsets.all(12)),
                            textStyle: MaterialStateProperty.all(
                                const TextStyle(fontSize: 16)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


                const SizedBox(height: 40),
                Center(
                  child: MaterialButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()){
                        await updateAccount(context,imageFile!);
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
                          'Update',
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
                const SizedBox(
                  height: 20,
                ),
                // const Spacer(
                //   flex: 2,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}