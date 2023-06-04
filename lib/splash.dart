import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/Home/home_page.dart';
import 'package:untitled1/layout.dart';
import 'package:untitled1/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/register_system/register.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}


class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateToHome();
  }

  navigateToHome() async {
    var secondRoute;
    int? isViewed;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isViewed = prefs.getInt('OnBoarding');
    if(isViewed != 0){
      setState(() {
        secondRoute = const Onboarding();
      });

    }else{
      setState(() {
        secondRoute = Register();
      });

    }
    await Future.delayed(const Duration(milliseconds: 2000)).then((value) =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => secondRoute)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/logo.jpeg",
          // width: 300,
          // height: 300,
        ),
      ),
    );
  }
}