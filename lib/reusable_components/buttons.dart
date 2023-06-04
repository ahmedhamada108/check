import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({Key? key, required this.text, required this.backgroundColor, required this.textColor, required this.width, required this.onPressed}) : super(key: key);
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double width;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {

    return MaterialButton(
      onPressed: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(44),
      ),
      color: backgroundColor,
      child: SizedBox(
        width: 100,
        height: 60,
        child: Center(
          child: Text(
              text,
            style: TextStyle(
              color: textColor,
              fontFamily: 'Franklin Gothic',
              fontWeight:  FontWeight.normal,
              fontSize: 30,
            ),
          ),
        ),
      ),

    );
  }
}
