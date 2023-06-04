import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled1/app_data.dart';
import 'package:untitled1/screens/upload_image_screens.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedItem = 0;
  Color backgroundBottomNavBar = HexColor('2AAAE2');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
      //   actions: [
      //     IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
      //     const SizedBox(
      //       width: 10,
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose a disease :',
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> uploadImageScreen()));
              },
              child: Container(
                // padding: const EdgeInsets.all(20.0),
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.blue,
                  image: DecorationImage(
                      image: AssetImage(Categories_data[0].imageUrl),
                      opacity: 0.6,
                      fit: BoxFit.fill),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image(
                    //     image: AssetImage(Categories_data[0].imageUrl),
                    //     height: 80.0,
                    //     width: 80.0),
                    // const SizedBox(
                    //   width: 20.0,
                    // ),
                    Text(
                      Categories_data[0].title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              // padding: const EdgeInsets.all(20.0),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.blue,
                image: DecorationImage(
                    image: AssetImage(Categories_data[1].imageUrl),
                    opacity: 0.6,
                    fit: BoxFit.fill),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image(
                  //     image: AssetImage('assets/images/medical_image.jfif'),
                  //     height: 80.0,
                  //     width: 80.0),
                  // const SizedBox(
                  //   width: 20.0,
                  // ),
                  Text(
                    Categories_data[1].title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              // padding: const EdgeInsets.all(20.0),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.blue,
                image: DecorationImage(
                    image: AssetImage(Categories_data[2].imageUrl),
                    opacity: 0.6,
                    fit: BoxFit.fill),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image(
                  //     image: AssetImage('assets/images/medical_image.jfif'),
                  //     height: 80.0,
                  //     width: 80.0),
                  // const SizedBox(
                  //   width: 20.0,
                  // ),
                  Text(
                    Categories_data[2].title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              // padding: const EdgeInsets.all(20.0),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.blue,
                image: DecorationImage(
                    image: AssetImage(Categories_data[3].imageUrl),
                    opacity: 0.6,
                    fit: BoxFit.fill),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image(
                  //     image: AssetImage('assets/images/medical_image.jfif'),
                  //     height: 80.0,
                  //     width: 80.0),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    Categories_data[3].title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: selectedItem,
      //     onTap: (value) {
      //       print(value);
      //       setState(() {
      //         selectedItem = value;
      //       });
      //     },
      //     iconSize: 40,
      //   items: const [
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.home),label: 'Home'),
      //     BottomNavigationBarItem(
      //         icon:Icon(Icons.history), label: 'History'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.account_circle), label: 'Account')
      //   ],
      // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: selectedItem,
      //   onTap: (value) {
      //     print(value);
      //     setState(() {
      //       selectedItem = value;
      //     });
      //   },
      //   //backgroundBottomNavBar
      //   // backgroundColor: ,
      //   selectedItemColor: Colors.white,
      //   iconSize: 40,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.account_circle), label: 'Account'),
      //   ],
      // ),
    );
  }
}