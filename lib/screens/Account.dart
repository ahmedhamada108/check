import 'package:flutter/material.dart';

class Account extends StatelessWidget{
  const Account({Key? key}) :super(key: key);
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children:const [
          Text( 'Account page' , style: TextStyle(fontSize: 40, color:Colors.white, fontWeight: FontWeight.bold),),
          SizedBox(height: 100,),
          CircleAvatar(
            radius: 70,
            child: Icon(Icons.person , size: 120,),
          ),
          SizedBox(height: 100,),
          Text( 'Account page Content' , style: TextStyle(fontSize: 30, color:Colors.white),),
        ],
      ),
    );

  }


}
