

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
List<Color> animatedtextcolors =[
  Colors.white,
  Colors.amber[200]!,
  Colors.amber[500]!,
  Colors.amber[800]!,
  Colors.amber[200]!,
  Colors.white,


];
Widget email_field(TextEditingController controller, hinttext, type){
  return  TextFormField(
                    // selectionWidthStyle: BoxWidthStyle.tight,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "must enter email here";
                      }
                    },
                    controller: controller,
                    //keyboardType: TextInputType.number,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                    decoration: InputDecoration(
                      hintText: hinttext,
                      hintStyle:TextStyle(
                      color: Colors.white,
                      fontFamily: "Trajan Pro",
                      fontSize: 22) ,
                      filled: true,
  
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5.7),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5.7),
                      ),
                    ),
                  );
}