import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';

class GetLocation extends StatefulWidget {
  const GetLocation({Key? key}) : super(key: key);

  @override
  State<GetLocation> createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  var locationMessage = "";
  getCurrentLocation() async{
    // var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // var lastPosition = await Geolocator.getLastKnownPosition();
    // print(lastPosition);
    // setState(() {
    //   locationMessage = "latitude: ${position.latitude}  + longitude: ${position.longitude} ";
    //   print(locationMessage);
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: ()async{
            // LocationPermission permission;
            // permission = await Geolocator.requestPermission();
            // await getCurrentLocation();
          },
          child: const Text(
            "get location"
          ),
        ),
      ),
    );
  }
}
