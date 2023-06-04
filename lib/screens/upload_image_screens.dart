import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/dio/dio.dart';
import 'package:untitled1/screens/result_of_check.dart';

import '../models/doctor.dart';

class uploadImageScreen extends StatefulWidget {
  static const screenRoute = 'category-diseases';

  @override
  State<uploadImageScreen> createState() => _uploadImageScreenState();
}

class _uploadImageScreenState extends State<uploadImageScreen> {
  var locationMessage;
  var long;
  var lat;

  getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    print(lastPosition);
    setState(() {
      locationMessage =
          "latitude: ${position.latitude}  + longitude: ${position.longitude} ";
      print(locationMessage);
      long = position.longitude;
      lat = position.latitude;
    });

    print(position.longitude);
    print(position.latitude);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();

  }

  File? imageFile;

  Future getImage(categoryTitle) async {
    File _image;
    final picker = ImagePicker();

    var _pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 500, // <- reduce the image size
        maxWidth: 500);
    setState(() {
      imageFile = File(_pickedFile!.path);
      if (categoryTitle == "OCT") {
        octResult(imageFile!, long.toString(), lat.toString(), context);
      } else if (categoryTitle == "Chest") {
        chestResult(imageFile!, long.toString(), lat.toString(), context);
      } else if (categoryTitle == "Brain Stroke") {
        brainStrokeResult(imageFile!, long.toString(), lat.toString(), context);
      } else {
        alzheimerResult(imageFile!, long.toString(), lat.toString(), context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeArgument =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryId = routeArgument['id'];
    final categoryTitle = routeArgument['title'];

    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 25),
        foregroundColor: Colors.white,
        backgroundColor: Colors.tealAccent[300],
        minimumSize: const Size(88, 52),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle!,
          style: const TextStyle(
            color: Colors.blue,
          ),
        ),
        /*Image.asset("assets/images/logo.jpeg"
          ,height: 160.0,width: 160.0,
        ),
               */
        elevation: 15,
        backgroundColor: Colors.white30,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          imageFile != null
              ? Container(
                  child: Image.file(imageFile!),
                )
              : Container(
                  child: Icon(
                    Icons.camera_enhance_rounded,
                    color: Colors.blue,
                    size: MediaQuery.of(context).size.width * .6,
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: ElevatedButton(
              onPressed: () async {
                // _getFromGallery();
                //
                // await getCurrentLocation();
                getImage(categoryTitle);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
                textStyle:
                    MaterialStateProperty.all(const TextStyle(fontSize: 16)),
              ),
              child: const Text('Upload Your Image'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: ElevatedButton(
              onPressed: () async {
                // LocationPermission permission;
                // permission = await Geolocator.requestPermission();

                getCurrentLocation();
                // chestResult(imageFile!);
                // _upload();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
                textStyle:
                    MaterialStateProperty.all(const TextStyle(fontSize: 16)),
              ),
              child: const Text('Show Result'),
            ),
          ),
        ],
      ),
    );
  }
}
