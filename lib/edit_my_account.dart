import 'dart:io';

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'dio/dio.dart';

var updateUsername = TextEditingController();
var updateEmail = TextEditingController();
var updatePassword = TextEditingController();
var updateConfirmPassword = TextEditingController();
var imagePath;

class EditMyAccount extends StatefulWidget {
  EditMyAccount({Key? key}) : super(key: key);

  @override
  State<EditMyAccount> createState() => _EditMyAccountState();
}

class _EditMyAccountState extends State<EditMyAccount> {
  File? imageFile;
  bool isObscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  var _pickedFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Account',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        // backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Stack(
                  children: [
                    if (imageFile != null)
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image(
                            image: FileImage(imageFile!),
                            filterQuality: FilterQuality.high,
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    else
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: const Image(
                            image: AssetImage('assets/images/upload.jpg'),
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                          ),
                        ),
                      ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.lightBlue,
                        ),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: ((builder) => bottomSheet()));
                          },
                          child: const Icon(
                            LineAwesomeIcons.pen,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Column(
                  children: [
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
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide:
                                const BorderSide(width: 2, color: Colors.blue)),
                        label: const Text(
                          'Name',
                        ),
                        prefixIcon: const Icon(Icons.person_outline_rounded,
                            color: Colors.blue),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide:
                                const BorderSide(width: 2, color: Colors.blue)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide:
                                const BorderSide(width: 2, color: Colors.blue)),
                        label: const Text(
                          'Email',
                        ),
                        prefixIcon: const Icon(Icons.email_outlined,
                            color: Colors.blue),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: isObscurePassword,
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
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide:
                                const BorderSide(width: 2, color: Colors.blue)),
                        label: const Text(
                          'Password',
                        ),
                        prefixIcon: IconButton(
                          icon: const Icon(
                            Icons.remove_red_eye_outlined,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            setState(() {
                              isObscurePassword = !isObscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: isObscurePassword,
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
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide:
                                const BorderSide(width: 2, color: Colors.blue)),
                        label: const Text(
                          'Password Confirmation',
                        ),
                        prefixIcon: IconButton(
                          icon: const Icon(
                            Icons.remove_red_eye_outlined,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            setState(() {
                              isObscurePassword = !isObscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(14),
                          backgroundColor: Colors.blue,
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                        ),
                        onPressed: () async{
                          if (_formKey.currentState!.validate()){
                            await updateAccount(context,imageFile!);
                          }
                          print(imageFile);
                        },
                        child: const Text('Update Profile',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);
    if (file?.path != null) {
      setState(() {
        imageFile = File(file!.path);
      });
    }
    print(file!.path);
    print(file);


  }


  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            'Choose Profile Photo',
            style: TextStyle(
                fontSize: 20, color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(14),
                  backgroundColor: Colors.blue,
                  side: BorderSide.none,
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  getImage(source: ImageSource.camera);
                },
                icon: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.brown[100],
                ),
                label: const Text(
                  "Camera",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                width: 90,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(14),
                  backgroundColor: Colors.blue,
                  side: BorderSide.none,
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  getImage(source: ImageSource.gallery);
                },
                icon: Icon(
                  Icons.image,
                  color: Colors.brown[100],
                ),
                label: const Text(
                  "Gallery",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
