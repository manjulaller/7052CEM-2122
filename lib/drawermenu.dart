import 'package:newsapp/landingscreen.dart';
import 'package:newsapp/Myissues.dart';
import 'package:newsapp/mapsview.dart';
import 'package:newsapp/createissue.dart';
import 'package:flutter/material.dart';

class drawermenu extends StatefulWidget {
  const drawermenu({Key? key}) : super(key: key);

  @override
  _drawermenuState createState() => _drawermenuState();
}

class _drawermenuState extends State<drawermenu> {
  Widget drawerimage() {
    return Container(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 90,
              child: Text('Online \n Community',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "lobster",
                      fontSize: 35)),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromARGB(255, 2, 30, 185),
        child: ListView(
          shrinkWrap: true,
          children: [
            drawerimage(),
            Divider(
              height: 10,
              color: Colors.white.withOpacity(.7),
            ),
            ListTile(
              tileColor: Colors.blueGrey[900],
              title: Text('Create issue',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Trajan Pro",
                      fontSize: 22)),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Sellitems(),));
              },
            ), Divider(
              height: 10,
              color: Colors.white.withOpacity(.7),
            ),
            ListTile(
              tileColor: Colors.blueGrey[900],
              title: Text('My issues',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Trajan Pro",
                      fontSize: 22)),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => myIssuesscreen(),
                ));
              },
            ), Divider(
              height: 10,
              color: Colors.white.withOpacity(.7),
            ),
            ListTile(
              tileColor: Colors.blueGrey[900],
              title: Text('Maps View',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Trajan Pro",
                      fontSize: 22)),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => mapsview(),));
              },
            ), Divider(
              height: 10,
              color: Colors.white.withOpacity(.7),
            ),
            ListTile(
              tileColor: Colors.blueGrey[900],
              title: Text('logout out',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Trajan Pro",
                      fontSize: 22)),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
