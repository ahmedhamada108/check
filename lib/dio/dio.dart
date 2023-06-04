import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/constants/constants.dart';
import 'package:untitled1/models/doctor.dart';
import 'package:untitled1/models/mr.dart';
import 'package:untitled1/models/patient_history.dart';
import 'package:untitled1/register_system/create_new_password.dart';
import 'package:untitled1/register_system/forget_password.dart';
import 'package:untitled1/register_system/login.dart';
import 'package:untitled1/register_system/otp_verification.dart';
import 'package:untitled1/screens/edit_my_account.dart';
import 'package:untitled1/screens/result_of_check.dart';
import 'package:untitled1/test_history.dart';
import 'package:untitled1/widgets/doctor_card.dart';

import '../history/history.dart';
import '../layout.dart';
import '../register_system/register.dart';



final dio = Dio();
final Future<SharedPreferences> sharedPrefs = SharedPreferences.getInstance();

Future signUp(BuildContext context) async {
  Response response;
  //https://evara.projects-app.xyz/api/register_user
  //String base_url = 'https://project.projects-app.xyz';
  response = await dio.post(
    'https://project.projects-app.xyz/api/register_patient',
    data: {
      'name': username.text,
      'email': email.text,
      'password': password.text,
      'password_confirmation': confirmPassword.text,
    },
    options: Options(headers: {
      "Accept": "application/json",
      "Accept-Language": "en",
    }),
  );
  print(response.data);
  // AlertDialog(title: const Text("Result"),content: Text(response.data),);
  if (response.data["status"] != true) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0))),
            actions: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: 60,
                  // padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(44),
                    color: backgroundButtonColorTwo,
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("ok",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'Franklin Gothic',
                          fontWeight: FontWeight.normal,
                        )),
                  ),
                ),
              ),
            ],
            content: Text(response.data["errors"]["email"].toString(),
                style: TextStyle(color: textButtonColorOne, fontSize: 20)),
            backgroundColor: Colors.white,
            contentPadding: EdgeInsets.only(
              left: 30.0,
              right: 30.0,
              top: 30,
            ),
            icon: Center(
              child: FaIcon(
                FontAwesomeIcons.circleXmark,
                size: 90,
                color: Colors.red,
              ),
            )));
  } else {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0))),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: 120,
                      // padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(44),
                        color: backgroundButtonColorTwo,
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          await resendVerifyMail(context);
                        },
                        child: Text("resend",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: 'Franklin Gothic',
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: 60,
                      // padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(44),
                        color: backgroundButtonColorTwo,
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("ok",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: 'Franklin Gothic',
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            content: Text(response.data["msg"].toString(),
                style: TextStyle(color: textButtonColorOne, fontSize: 20)),
            backgroundColor: Colors.white,
            contentPadding: EdgeInsets.only(
              left: 30.0,
              right: 30.0,
              top: 30,
            ),
            icon: Center(
              child: FaIcon(
                FontAwesomeIcons.circleCheck,
                size: 90,
                color: backgroundButtonColorTwo,
              ),
            )));
  }
}

Future resendVerifyMail(BuildContext context) async {
  Response response;
  response = await dio.post(
    'https://project.projects-app.xyz/api/ResendVerifyMail',
    data: {
      'email': email.text,
    },
    options: Options(headers: {
      "Accept": "application/json",
      "Accept-Language": "en",
    }),
  );
  print(response.data['msg']);
  // if (response.data['status'] == true) {
  //
  //   return response.data;
  // }else{
  //   return  response.data;
  // }
  Fluttertoast.showToast(
    msg: response.data['msg'],
    toastLength: Toast.LENGTH_LONG,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundButtonColorTwo,
    textColor: Colors.white,
    fontSize: 16.0,
  );
  return response.data['msg'];
}

Future<void> login(BuildContext context) async {
  Response response;
  SharedPreferences prefs = await sharedPrefs;
  response = await dio.post(
    'https://project.projects-app.xyz/api/login_patient',
    data: {
      'email': loginEmail.text,
      'password': loginPassword.text,
    },
    options: Options(headers: {
      "Accept": "application/json",
      "Accept-Language": "en",
    }),
  );

  if (response.data['status'] == true) {
    print(response.data);
    print(response.data['errNum']);
    print('login successfully');
    prefs.setString('token', response.data['Patient']['token']);
    prefs.getString('token');
    // print(prefs.getString('token'));
    // print(response.data['User']['Token']);

    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0))),
            actions: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: 60,
                  // padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(44),
                    color: backgroundButtonColorTwo,
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LayoutPage()),
                      );
                    },
                    child: Text("ok",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'Franklin Gothic',
                          fontWeight: FontWeight.normal,
                        )),
                  ),
                ),
              )
            ],
            content: Text(response.data["msg"].toString(),
                style: TextStyle(
                  color: textButtonColorOne,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center),
            backgroundColor: Colors.white,
            contentPadding: EdgeInsets.only(
              left: 30.0,
              right: 30.0,
              top: 30,
            ),
            icon: Center(
              child: FaIcon(
                FontAwesomeIcons.circleCheck,
                size: 90,
                color: backgroundButtonColorTwo,
              ),
            )));
  } else {
    print('login failed');
    print(response.data['status']);
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0))),
            actions: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: 60,
                  // padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(44),
                    color: backgroundButtonColorTwo,
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("ok",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'Franklin Gothic',
                          fontWeight: FontWeight.normal,
                        )),
                  ),
                ),
              )
            ],
            content: Text(response.data["msg"].toString(),
                style: TextStyle(color: textButtonColorOne, fontSize: 20),
                textAlign: TextAlign.center),
            backgroundColor: Colors.white,
            contentPadding: EdgeInsets.only(
              left: 30.0,
              right: 30.0,
              top: 30,
            ),
            alignment: Alignment.center,
            icon: Center(
              //backgroundButtonColorTwo
              child: FaIcon(
                FontAwesomeIcons.circleXmark,
                size: 90,
                color: Colors.red,
              ),
            )));
  }
}

Future forgetPassword(BuildContext context) async {
  Response response;
  response = await dio.post(
    'https://project.projects-app.xyz/api/SendOTPForgetPassword',
    data: {
      'email': forgetPasswordEmail.text,
    },
    options: Options(headers: {
      "Accept": "application/json",
      "Accept-Language": "en",
    }),
  );
  print(response.data);
  if (response.data['status'] == true) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0))),
            actions: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(44),
                    color: backgroundButtonColorTwo,
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OTPVerification()));
                    },
                    child: Text("ok",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'Franklin Gothic',
                          fontWeight: FontWeight.normal,
                        )),
                  ),
                ),
              )
            ],
            content: Text(response.data["msg"].toString(),
                style: TextStyle(
                  color: textButtonColorOne,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center),
            backgroundColor: Colors.white,
            contentPadding: EdgeInsets.only(
              left: 30.0,
              right: 30.0,
              top: 30,
            ),
            icon: Center(
              child: FaIcon(
                FontAwesomeIcons.circleCheck,
                size: 90,
                color: backgroundButtonColorTwo,
              ),
            )));
  } else {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0))),
            actions: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: 60,
                  // padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(44),
                    color: backgroundButtonColorTwo,
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("ok",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'Franklin Gothic',
                          fontWeight: FontWeight.normal,
                        )),
                  ),
                ),
              )
            ],
            content: Text(response.data["msg"].toString(),
                style: TextStyle(color: textButtonColorOne, fontSize: 20),
                textAlign: TextAlign.center),
            backgroundColor: Colors.white,
            contentPadding: EdgeInsets.only(
              left: 30.0,
              right: 30.0,
              top: 30,
            ),
            alignment: Alignment.center,
            icon: Center(
              //backgroundButtonColorTwo
              child: FaIcon(
                FontAwesomeIcons.circleXmark,
                size: 90,
                color: Colors.red,
              ),
            )));
  }
}

Future verifyCode(BuildContext context) async {
  Response response;
  response = await dio.post(
    'https://project.projects-app.xyz/api/CheckOTP',
    data: {'email': forgetPasswordEmail.text, 'OTP': verificationCode},
    options: Options(headers: {
      "Accept": "application/json",
      "Accept-Language": "en",
    }),
  );
  print(response.data);
  if (response.data['status'] == true) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0))),
            actions: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(44),
                    color: backgroundButtonColorTwo,
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateNewPassword()));
                    },
                    child: Text("ok",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'Franklin Gothic',
                          fontWeight: FontWeight.normal,
                        )),
                  ),
                ),
              )
            ],
            content: Text(response.data["msg"].toString(),
                style: TextStyle(
                  color: textButtonColorOne,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center),
            backgroundColor: Colors.white,
            contentPadding: EdgeInsets.only(
              left: 30.0,
              right: 30.0,
              top: 30,
            ),
            icon: Center(
              child: FaIcon(
                FontAwesomeIcons.circleCheck,
                size: 90,
                color: backgroundButtonColorTwo,
              ),
            )));
  } else {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0))),
            actions: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: 60,
                  // padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(44),
                    color: backgroundButtonColorTwo,
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("ok",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontFamily: 'Franklin Gothic',
                          fontWeight: FontWeight.normal,
                        )),
                  ),
                ),
              )
            ],
            content: Text(response.data["msg"].toString(),
                style: TextStyle(color: textButtonColorOne, fontSize: 20),
                textAlign: TextAlign.center),
            backgroundColor: Colors.white,
            contentPadding: EdgeInsets.only(
              left: 30.0,
              right: 30.0,
              top: 30,
            ),
            alignment: Alignment.center,
            icon: Center(
              //backgroundButtonColorTwo
              child: FaIcon(
                FontAwesomeIcons.circleXmark,
                size: 90,
                color: Colors.red,
              ),
            )));
  }
}

Future createNewPassword(BuildContext context) async {
  Response response;
  //https://evara.projects-app.xyz/api/register_user
  //String base_url = 'https://project.projects-app.xyz';
  response = await dio.post(
    'https://project.projects-app.xyz/api/ForgetPassword',
    data: {
      'email': emailForNewPassword.text,
      'password': newPassword.text,
      'password_confirmation': confirmNewPassword.text,
    },
    options: Options(headers: {
      "Accept": "application/json",
      "Accept-Language": "en",
    }),
  );
  print(response.data);
  Fluttertoast.showToast(
    msg: response.data['msg'],
    toastLength: Toast.LENGTH_LONG,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundButtonColorTwo,
    textColor: Colors.white,
    fontSize: 16.0,
  );
  // Navigate to the login screen by class name
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => Login()));
}

Future<void> viewInfoAccount(BuildContext context) async {
  Response response;
  SharedPreferences prefs = await sharedPrefs;
  dio.options.headers["Authorization"] = "Bearer ${prefs.getString('token')}";
  response =
      await dio.get('https://project.projects-app.xyz/api/ViewInfoAccount');
  if (response.data['status'] == true) {
    prefs.setString("User Name", response.data["Account Info"]["name"]);
    prefs.setString("User Email", response.data["Account Info"]["email"]);
    prefs.setString("User Image", response.data["Account Info"]["image"]);
    print(response.data["Account Info"]["name"]);
    print(response.data["Account Info"]["email"]);
    print(response.data["Account Info"]["image"]);
  }
}

Future updateAccount(BuildContext context, File userImage) async {
  Response response;
  SharedPreferences prefs = await sharedPrefs;
  //https://evara.projects-app.xyz/api/register_user
  //String base_url = 'https://project.projects-app.xyz';
  String fileName = userImage.path.split('/').last;
  FormData data = FormData.fromMap({
    'name': updateUsername.text,
    'email': updateEmail.text,
    'password': updatePassword.text,
    'password_confirmation': updateConfirmPassword.text,
    'image': await MultipartFile.fromFile(
      userImage.path,
      filename: fileName,
    ),
  });
  response = await dio.post(
    'https://project.projects-app.xyz/api/UpdateAccount',
    data: data,
    options: Options(headers: {
      "Accept": "application/json",
      "Accept-Language": "en",
    }),
  );

  if (response.data["status"] = true){
    print(response.data);
   viewInfoAccount(context);
    Fluttertoast.showToast(
      msg: response.data['msg'],
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundButtonColorTwo,
      textColor: Colors.white,
      fontSize: 16.0,
    );

  }
}

void logout(BuildContext context) async {
  Response response;
  SharedPreferences prefs = await sharedPrefs;
  dio.options.headers["Authorization"] = "Bearer ${prefs.getString('token')}";
  response =
      await dio.post('https://project.projects-app.xyz/api/logout_patient');
  if (response.data['status'] == true) {
    print(response.data['msg']);
  }
  // Clear the token from SharedPreferences after successful logout
  await prefs.remove('token');

  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => Login()));
}


void chestResult(
    File file, String long, String lat, BuildContext context) async {
  String fileName = file.path.split('/').last;
  SharedPreferences prefs = await sharedPrefs;
  dio.options.headers["Authorization"] = "Bearer ${prefs.getString('token')}";
  FormData data = FormData.fromMap({
    "image": await MultipartFile.fromFile(
      file.path,
      filename: fileName,
    ),
    "long": long,
    "lat": lat,
  });

  dio
      .post("https://project.projects-app.xyz/api/Chest_XRay",
          data: data,
          options: Options(headers: {
            "Accept-Language": "en",
          }))
      .then((response) {
    prefs.setString(
        "disease name", response.data["Result Check"]["sub_disease"]);
    prefs.setString(
        "disease description", response.data["Result Check"]["description"]);

    response.data["Vezzeta Doctors"];

    List<VezzetaDoctors> doctors = (response.data["Vezzeta Doctors"] as List).map((e) => VezzetaDoctors.fromJson(e)).toList();
    for(var doctor in doctors){
      print(doctor.doctorName);
    }

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ResultOfCheck(doctors: doctors,)));

  }).catchError((error) => print(error));
}

void brainStrokeResult(File file, String long, String lat, BuildContext context) async {
  String fileName = file.path.split('/').last;
  SharedPreferences prefs = await sharedPrefs;
  dio.options.headers["Authorization"] = "Bearer ${prefs.getString('token')}";
  FormData data = FormData.fromMap({
    "image": await MultipartFile.fromFile(
      file.path,
      filename: fileName,
    ),
    "long": long,
    "lat": lat,
  });

  dio
      .post("https://project.projects-app.xyz/api/BrainStroke",
          data: data,
          options: Options(headers: {
            "Accept-Language": "en",
          }))
      .then((response) {
    prefs.setString(
        "disease name", response.data["Result Check"]["sub_disease"]);
    prefs.setString(
        "disease description", response.data["Result Check"]["description"]);
    List<VezzetaDoctors> doctors = (response.data["Vezzeta Doctors"] as List).map((e) => VezzetaDoctors.fromJson(e)).toList();
    for(var doctor in doctors){
      print(doctor.doctorName);
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ResultOfCheck(doctors: doctors,)));
    print(response.data["Result Checks"]["sub_disease"]);
    print(response.data["Result Checks"]["description"]);
  }).catchError((error) => print(error));
}

void octResult(File file, String long, String lat, BuildContext context) async {
  String fileName = file.path.split('/').last;
  SharedPreferences prefs = await sharedPrefs;
  dio.options.headers["Authorization"] = "Bearer ${prefs.getString('token')}";
  FormData data = FormData.fromMap({
    "image": await MultipartFile.fromFile(
      file.path,
      filename: fileName,
    ),
    "long": long,
    "lat": lat,
  });

  dio
      .post("https://project.projects-app.xyz/api/OCT",
          data: data,
          options: Options(headers: {
            "Accept-Language": "en",
          }))
      .then((response) {
    prefs.setString(
        "disease name", response.data["Result Check"]["sub_disease"]);
    prefs.setString(
        "disease description", response.data["Result Check"]["description"]);
    List<VezzetaDoctors> doctors = (response.data["Vezzeta Doctors"] as List).map((e) => VezzetaDoctors.fromJson(e)).toList();
    for(var doctor in doctors){
      print(doctor.doctorName);
    }

    print(doctors);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ResultOfCheck(doctors: doctors,)));
    print(response.data);
    print(response.data["Result Check"]["sub_disease"]);
    print(response.data["Result Check"]["description"]);
  }).catchError((error) => print(error));
}

void alzheimerResult(File file, String long, String lat, BuildContext context) async {
  String fileName = file.path.split('/').last;
  SharedPreferences prefs = await sharedPrefs;
  dio.options.headers["Authorization"] = "Bearer ${prefs.getString('token')}";
  FormData data = FormData.fromMap({
    "image": await MultipartFile.fromFile(
      file.path,
      filename: fileName,
    ),
    "long": long,
    "lat": lat,
  });

  dio
      .post("https://project.projects-app.xyz/api/alzahimar",
          data: data,
          options: Options(headers: {
            "Accept-Language": "en",
          }))
      .then((response) {
    prefs.setString(
        "disease name", response.data["Result Check"]["sub_disease"]);
    prefs.setString(
        "disease description", response.data["Result Check"]["description"]);

    List<VezzetaDoctors> doctors = (response.data["Vezzeta Doctors"] as List).map((e) => VezzetaDoctors.fromJson(e)).toList();
    for(var doctor in doctors){
      print(doctor.doctorName);
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ResultOfCheck(doctors: doctors,)));
  }).catchError((error) => print(error));
}

// Future<List<PatientHistory>> getPatientHistory() async {
//   Response response;
//   SharedPreferences prefs = await sharedPrefs;
//   dio.options.headers["Authorization"] = "Bearer ${prefs.getString('token')}";
//   response = await dio.get(
//     'https://project.projects-app.xyz/api/PatientHistory',
//     options: Options(headers: {
//       "Accept": "application/json",
//       "Accept-Language": "en",
//     }),
//   );
//   if (response.data['status'] == true) {
//     print(response.data["Patient History"]);
//     List<PatientHistory> records = (response.data["Patient History"] as List).map((e) => PatientHistory.fromJson(e)).toList();
//     for(var record in records){
//       print(record.diseaseName);
//     }
//     return records; // Assign retrieved records to the 'records' variable
//   }
//   return []; // Return an empty list in case of an error or no records
// }


