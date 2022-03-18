import 'package:flutter/material.dart';

class individualview extends StatefulWidget {
  final tag;
  individualview({Key? key, required this.tag}) : super(key: key);

  @override
  State<individualview> createState() => _individualviewState();
}

class _individualviewState extends State<individualview> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
           decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/download.jpg"), fit: BoxFit.fill)
          ),
        height: size.height,
        width: size.width,
       // color: Colors.black,
        child: Stack(children: [
          ListView(
            children: [
              SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Issue Name',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "tarjan pro",
                          fontSize: 30)),
                ],
              ),
              Hero(
                tag: widget.tag,
                child: Container(
                  height: size.height / 1.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                          image: AssetImage("assets/auction.jpg"),fit: BoxFit.cover)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            'Description',style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "trajan Pro",
                                fontSize: 19)),
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Text(
                        '..............................................................................................................................................',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "lobster",
                            fontSize: 12)),
                             Text(
                        "mark down formating ........................................", style: TextStyle(
                            color: Colors.white,
                            fontFamily: "lobster",
                            fontSize: 12)),
                    SizedBox(
                      height: 5,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                                'Date',style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "trajan Pro",
                                    fontSize: 19)),
                      ],
                    ),
                     Divider(
                      color: Colors.white,
                    ),
                    Text('(##/##/####)',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "lobster",
                            fontSize: 15)),
                   
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                                'Rised by',style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "trajan Pro",
                                    fontSize: 19)),
                      ],
                    ),
                     Divider(
                      color: Colors.white,
                    ),
                    Text('ajmal khan',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "lobster",
                            fontSize: 15)),
                    SizedBox(
                      height: 44,
                    ),
                  ],
                ),
              ),
              
            ],
          ),
         Positioned(
              top: 30,
              left: 20,
              child: GestureDetector(
                onTap: (() {
                  Navigator.pop(context);
                }),
                child: Container(
                  height: 50,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.blue[900]!.withOpacity(.4),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              )),
        Positioned(
          bottom: 20,
          right: 0,
          child: 
        GestureDetector(
                onTap: (() {
                  
                }),
                child: Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  height: 39,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.blue[400]!.withOpacity(1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "Mark Addressed",
                      style: TextStyle(
                        fontFamily: "lobster",
                        fontSize: 14, color: Colors.white),
                    ),
                  ),
                ),
              )
        )
        ]),
      ),
    );
  }
}
