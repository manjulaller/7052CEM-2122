import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:images_picker/images_picker.dart';
import 'package:newsapp/helpers/helpers.dart';
import 'package:flutter/material.dart';
class Sellitems extends StatefulWidget {
  const Sellitems({ Key? key }) : super(key: key);

  @override
  State<Sellitems> createState() => _SellitemsState();
}

class _SellitemsState extends State<Sellitems> {
  final issue_name_controller = TextEditingController();
  final description_of_location = TextEditingController();
  
  final markdown_formating = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  File? imageaddress;



cameradialog() {
    AwesomeDialog(
      customHeader: Container(
        decoration: BoxDecoration(
            color: Colors.amber,
            shape: BoxShape.circle,
           ),
           child: Icon(Icons.add_a_photo),
      ),
      context: context,
      dialogBackgroundColor: Colors.black,
      dialogType: DialogType.INFO_REVERSED,
      borderSide: BorderSide(color: Colors.blue[900]!, width: 2),
      width: 380,
      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
      headerAnimationLoop: false,
      animType: AnimType.BOTTOMSLIDE,
      body: Column(
        children: [
          Text('Issue name',
              style: TextStyle(
                  color: Colors.white, fontFamily: "Trajan Pro", fontSize: 25)),
          Text('Description of issue',
              style: TextStyle(
                  color: Colors.white, fontFamily: "Trajan Pro", fontSize: 25)),
        ],
      ),
      btnOkText: "camera",
      btnCancelText: "Gallery",
      showCloseIcon: true,
      btnCancelOnPress: () {
      ImagesPicker.pick(
          quality: 1,
          pickType: PickType.image,
          cropOpt: CropOption(aspectRatio: CropAspectRatio.wh4x3)
        ).then((value) {
             setState(() {
               imageaddress = File(value!.first.path);
             });
        });
      },
      btnOkOnPress: () {
        ImagesPicker.openCamera(
          quality: 1,
          pickType: PickType.image,
          cropOpt: CropOption(aspectRatio: CropAspectRatio.wh2x1)
        ).then((value) {
             setState(() {
               imageaddress = File(value!.first.path);
             });
        });
       },
    )..show();
  }














  @override
  Widget build(BuildContext context) {
      final size = MediaQuery.of(context).size;
      
    return Scaffold(
     appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text('Create issue',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Trajan Pro",
                    fontSize: 25)),
      ),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/download.jpg"), fit: BoxFit.fill)),
height: size.height,
width: size.width,
child: ListView(
  children: [
    SizedBox(height: 20,),
    Padding(
      padding: EdgeInsets.only(left: 18,right: 18),
      child: GestureDetector(
        onTap: () {
       
        cameradialog();
        },
        child: Container(
          height: size.height/4,
          width: size.width,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
            
      
          ),
          child: imageaddress==null? Center(
            child: Text("Add photo",style: TextStyle( color: Colors.white),)
          ) : Image.file(imageaddress!,fit: BoxFit.fill,)
        ),
      ),
    )
    ,SizedBox(
    height: 30,
    ),
    Form(
      key: _formkey,
      child: Column(
        children: [
          email_field(issue_name_controller, "enter issue title", "issue name"),
          SizedBox(
            height: 14,
          ),
          email_field(description_of_location, "enter location", "description_of_location"),
          SizedBox(
            height: 14,
          ),
          email_field(markdown_formating, "enter markdown description", "markdown_formating"),
          SizedBox(
            height: 34,
          ),
          GestureDetector(
                onTap: (() {
                }),
                child: Container(
                  height: 50,
                  width: size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  child: Center(
                    child: Text(
                      "rise issue",
                      style: TextStyle(
                        fontFamily: "trajan pro",
                        fontSize: 22,
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                ),
              ),
        ],
      ))
  
  
  ],
)
      ),
    );
  }
}