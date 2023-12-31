import 'package:flutter/material.dart';
import 'package:fud/presentation/onboarding_screens/WelcomeScreen02.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen01 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 100),
              child: Image.asset(
                'assets/images/cook-book.png',
                width: 200,
                height: 200,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Dive into the culinary symphony of flavorful discoveries",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  WelcomeScreen02()),
          );
        },
        child: Icon(Icons.arrow_circle_right_outlined),
        backgroundColor: Colors.orangeAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
