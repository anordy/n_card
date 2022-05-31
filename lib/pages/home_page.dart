
import 'package:flutter/material.dart';
import 'package:n_card/pages/authenticate_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Biometrics'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               const Text(
                  "Welcome  Congrats You're In",
                  style: TextStyle(fontSize: 20,),
                ),
              const  SizedBox(height: 48),
                buildLogoutButton(context)
              ],
            ),
          ),
        ),
      );

  Widget buildLogoutButton(BuildContext context) =>   MaterialButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(60.0)),
        color: Colors.lightBlue,
        height: 50,
        minWidth: 250,
        onPressed: () =>  Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AuthenticatePage())),
        child: const Text(
          'Logout',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      );
 
}
