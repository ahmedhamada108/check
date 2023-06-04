import 'package:flutter/material.dart';

import '../screens/upload_image_screens.dart';
class CategoryItem extends StatelessWidget{
  final String id;
  final String title;
  final String imageUrl;

   CategoryItem( this.title,this.imageUrl,this.id);
   //ctx as there is a similar name of context
  //c as there is a similar name of context
   void selectCategory(BuildContext ctx){
     Navigator.of(ctx).pushNamed(
        uploadImageScreen.screenRoute,
       arguments: {
          'id':id,
         'title':title,
       }
     );
   }

  @override
  Widget build(BuildContext context){
    return  InkWell(
      onTap:()=> selectCategory(context) ,
      splashColor: Theme.of(context).splashColor,
      borderRadius: BorderRadius.circular(15),
      child: Stack(
        children: [
         ClipRRect(
           borderRadius: BorderRadius.circular(15),
            child: Image(image:
            AssetImage(imageUrl),
              height: 400,
              fit:BoxFit.cover,
              width: 400,

            ),
         ),

          Container(
            padding: EdgeInsets.all( 10),
            alignment: Alignment.center,
            child: Text(title,
             style: TextStyle(color: Colors.white, fontSize: 30,),
            ),

            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(15),
            ),
          )
        ],
      ),
    );
  }
}