import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:newsapp/IndividualView.dart';
import 'package:newsapp/drawermenu.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class myIssuesscreen extends StatefulWidget {
  const myIssuesscreen({Key? key}) : super(key: key);

  @override
  State<myIssuesscreen> createState() => _myIssuesscreenState();
}

class _myIssuesscreenState extends State<myIssuesscreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: drawermenu(),
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        title: Text('My Issues',
            style: TextStyle(
                color: Colors.white, fontFamily: "Trajan Pro", fontSize: 25)),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/download.jpg"), fit: BoxFit.fill)),
        padding: EdgeInsets.all(15),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 14),
              height: 270,
              width: size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey.withOpacity(.6),
                  )),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, left: 8, right: 8, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 30,
                          width: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.blue.withOpacity(.4),
                          ),
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.blue,
                  ),
                  Text('Issue name',
                      style: TextStyle(
                          color: Colors.blue[900],
                          fontFamily: "lobster",
                          fontWeight: FontWeight.bold,
                          fontSize: 17)),
                  Text('this is issue name',
                      style: TextStyle(
                          color: Colors.blue[900], fontSize: 12)),
                  Text('Location Description',
                      style: TextStyle(
                          color: Colors.blue[900],
                          fontFamily: "lobster",
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                  Text(
                      '......................................................................................................................................................',
                      style: TextStyle(
                          color: Colors.blue[900],
                          fontFamily: "lobster",
                          fontSize: 12)),
                  Text('Date',
                      style: TextStyle(
                          color: Colors.blue[900],
                          fontFamily: "lobster",
                          fontWeight: FontWeight.bold,
                          fontSize: 17)),
                  Text('(##/##/####)',
                      style: TextStyle(
                          color: Colors.blue[900],
                          fontFamily: "lobster",
                          fontSize: 12)),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (() {
                            
                          }),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            height: 29,
                            width: 90,
                            decoration: BoxDecoration(
                              color: Colors.blue[900],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                "issue addressed",
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
