import 'package:flutter/material.dart';
import 'package:untitled1/dio/dio.dart';
import 'package:untitled1/screens/setting_drawer.dart';
import '../app_data.dart';
import '../widgets/category_item.dart';

class Home extends StatefulWidget{
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // const Home({Key? key}) :super(key: key);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewInfoAccount(context);
    // getPatientHistory(context);
  }
   @override
   Widget build(BuildContext context){

      return Scaffold(
         appBar: AppBar(
            title:Builder(
                builder: (context) {
                   return GestureDetector(
                      onTap: (){
                         Scaffold.of(context).openDrawer();
                      },
                      child: Image.asset("assets/images/logo.jpeg"
                         ,height: 160.0,width: 160.0,),
                   );
                }
            ),

            elevation: 15,
            // backgroundColor: Colors.white60,
            automaticallyImplyLeading: false,
            actions: [
               Builder(
                   builder: (context) {
                      return IconButton(
                          onPressed:(){
                             Scaffold.of(context).openDrawer();
                          },
                          icon:const Icon(Icons.menu,color:Colors.blue,));
                   }
               ),
            ],
         ),
         drawer: SettingDrawer(),




         body:
         GridView(

            padding: EdgeInsets.all( 10),

            gridDelegate:SliverGridDelegateWithMaxCrossAxisExtent(
               maxCrossAxisExtent: 400,
               childAspectRatio: 8/8,
               mainAxisSpacing: 10,
               crossAxisSpacing: 10,
            ),
            children:Categories_data.map((categoryData)=>CategoryItem(categoryData.title, categoryData.imageUrl,categoryData.id)).toList(),

         ),








      );
   }
}

