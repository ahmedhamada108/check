import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/Home/home_page.dart';
import 'package:untitled1/blocs/switch_bloc.bloc/switch_bloc.dart';
import 'package:untitled1/blocs/switch_bloc.bloc/switch_state.dart';
import 'package:untitled1/get_location.dart';
import 'package:untitled1/onboarding/onboarding.dart';
import 'package:untitled1/register_system/register.dart';
import 'package:untitled1/screens/Home.dart';
import 'package:untitled1/screens/History.dart';
import 'package:untitled1/screens/Account.dart';
import 'package:untitled1/screens/upload_image_screens.dart';
import 'package:untitled1/services/app_theme.dart';
import 'package:untitled1/splash.dart';
import 'package:firebase_core/firebase_core.dart';


int? isViewed;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt('OnBoarding');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => SwitchBloc())],
      // child:
      // MaterialApp(
      //   title: 'Check Up App',
      //   theme: ThemeData(
      //     //to modify font
      //    textTheme: ThemeData.light().textTheme.copyWith(
      //      titleLarge: TextStyle(
      //        color: Colors.white,
      //        fontSize: 30,
      //      //  fontWeight: FontWeight.bold,
      //      ),
      //      titleSmall: TextStyle(
      //        color: Colors.blue,
      //        fontSize: 20,
      //        fontWeight: FontWeight.bold,
      //      )
      //    )
      //    // primarySwatch: Colors.deepOrange,
      //   ),
      //   // home: isViewed != 0 ? const Splash() : HomePage(),
      //   debugShowCheckedModeBanner: false,
      //   initialRoute: '/',
      //   routes: {
      //     //Splash
      //     '/':(ctx)=> Splash(),
      //     uploadImageScreen.screenRoute:(ctx)=>uploadImageScreen(),
      //   }
      // ),
      child:  BlocBuilder<SwitchBloc,SwitchState>(
        builder: (context,state) {
          return MaterialApp(

              title: 'Check Up App',
              theme:  state.switchValue?
              AppThemes.appThemeData[AppTheme.darkTheme]:
              AppThemes.appThemeData[AppTheme.lightTheme],

              //home: const MyHomePage(),



              //supported languages


              //locale resolution




              debugShowCheckedModeBanner: false,
              initialRoute: '/',
              routes: {
                '/': (ctx) => Splash(),


                uploadImageScreen.screenRoute: (ctx) => uploadImageScreen(),
              }
          );

        },
      ),
    );
  }
}
