import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled1/Home/home_page.dart';
import 'package:untitled1/constants/constants.dart';
import 'package:untitled1/layout.dart';
import 'package:untitled1/models/onbording_data.dart';
import 'package:untitled1/register_system/register.dart';
import 'package:untitled1/reusable_components/buttons.dart';
import 'package:untitled1/splash.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

late PageController _pageController;
// Widget displayButtons() {
//   return Padding(
//     padding: const EdgeInsets.symmetric(
//       vertical: 40,
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         MaterialButton(
//           onPressed: () {
//             // Navigator.push(context,MaterialPageRoute(builder: (context)=> const Splash())
//             // );
//             // Navigator.push(
//             //   context,
//             //   MaterialPageRoute(builder: (context) => const SecondRoute()),
//             // );
//             StoreOnboardingInfo();
//             // how to pass context outside scaffold
//
//             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
//           },
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(44),
//           ),
//           color: backgroundButtonColorOne,
//           child: SizedBox(
//             width: 100,
//             height: 60,
//             child: Center(
//               child: Text(
//                 'Skip',
//                 style: TextStyle(
//                   color: textButtonColorOne,
//                   fontFamily: 'Franklin Gothic',
//                   fontWeight: FontWeight.normal,
//                   fontSize: 30,
//                 ),
//               ),
//             ),
//           ),
//         ),
//
//         // const SizedBox(
//         //   width: 10,
//         // ),
//         MaterialButton(
//           onPressed: () {
//             _pageController.nextPage(
//                 duration: const Duration(milliseconds: 300),
//                 curve: Curves.ease);
//           },
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(44),
//           ),
//           color: backgroundButtonColorTwo,
//           child: const SizedBox(
//             width: 100,
//             height: 60,
//             child: Center(
//               child: Text(
//                 'Next',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontFamily: 'Franklin Gothic',
//                   fontWeight: FontWeight.normal,
//                   fontSize: 30,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

StoreOnboardingInfo() async {
  int isViewed = 0;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('OnBoarding', isViewed);
}

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController(initialPage: 0);
    checkTokenAndNavigate();
    super.initState();
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
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     leading: IconButton(onPressed: (){},icon: const Icon(Icons.arrow_back_ios_new),),),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                // alignment: AlignmentDirectional.center,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/images/background.png',
                        ),
                        fit: BoxFit.fill)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: PageView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: _pageController,
                            itemCount: demo_data.length,
                            itemBuilder: (context, index) => OnboardinContent(
                                  image: demo_data[index].image,
                                  title: demo_data[index].title,
                                  description: demo_data[index].description,
                                )),
                      ),
                      // displayButtons(),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OnboardinContent extends StatelessWidget {
  const OnboardinContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  final String image, title, description;
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //   mainAxisAlignment: MainAxisAlignment.center ,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: image != demo_data[0].image
                ? IconButton(
                    onPressed: () {
                      _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: backgroundButtonColorTwo,
                      size: 40.0,
                    ),
                  )
                : null,
          ),
          Container(
            height: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Image(
                    height: 250,
                    image: AssetImage(image),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Constantia Font',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: textButtonColorOne,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Constantia Font',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: descriptionTextColorOnboarding,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // const Spacer(flex: 1),
          Center(
            child: SmoothPageIndicator(
              // controller: widget.controller,
              count: demo_data.length,
              effect: WormEffect(
                dotHeight: 16,
                dotWidth: 16,
                type: WormType.normal,
                // strokeWidth: 5,
                dotColor: backgroundButtonColorOne,
                activeDotColor: backgroundButtonColorTwo,
              ),
              controller: _pageController,
            ),
          ),
          const Spacer(flex: 1),
          image == demo_data[3].image
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(44),
                        ),
                        color: backgroundButtonColorTwo,
                        child: const SizedBox(
                          width: 200,
                          height: 60,
                          child: Center(
                            child: Text(
                              'Get Started',
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
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          // Navigator.push(context,MaterialPageRoute(builder: (context)=> const Splash())
                          // );
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => const SecondRoute()),
                          // );
                          StoreOnboardingInfo();
                          // how to pass context outside scaffold

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()));
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(44),
                        ),
                        color: backgroundButtonColorOne,
                        child: SizedBox(
                          width: 100,
                          height: 60,
                          child: Center(
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                color: textButtonColorOne,
                                fontFamily: 'Franklin Gothic',
                                fontWeight: FontWeight.normal,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // const SizedBox(
                      //   width: 10,
                      // ),
                      MaterialButton(
                        onPressed: () {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(44),
                        ),
                        color: backgroundButtonColorTwo,
                        child: const SizedBox(
                          width: 100,
                          height: 60,
                          child: Center(
                            child: Text(
                              'Next',
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
        ]);
  }
}
