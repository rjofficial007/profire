import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PassAuth extends StatefulWidget {
  const PassAuth({Key? key}) : super(key: key);

  @override
  State<PassAuth> createState() => _PassAuthState();
}

class _PassAuthState extends State<PassAuth> {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          
          height: 500,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 100, 50, 70),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 10, left: 30, right: 30),
                    child: TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        hintText: "email",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.amber, width: 3.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.amber,
                            width: 3.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(bottom: 15, left: 30, right: 30),
                    child: TextFormField(
                      controller: password,
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.amber, width: 3.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.amber,
                            width: 3.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FlatButton.icon(
                      minWidth: 150,
                      height: 50,
                      color: Colors.amber,
                      onPressed: () async {
                        try {
                          final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: email.text,
                            password: password.text,
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            print('The account already exists for that email.');
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        // side: BorderSide(color: Colors.black, width: 2)
                      ),
                      icon: Icon(Icons.login),
                      label: Text(
                        "REGISTER",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      )),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
