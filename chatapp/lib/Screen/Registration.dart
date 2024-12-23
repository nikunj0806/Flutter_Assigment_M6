import 'package:chatapp/Screen/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _aState();
}

class _aState extends State<Registration> {
  String? profilePic = "https://in.pinterest.com/pin/tripti-dimri--594123375871629671/";
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> registerUser(
      String? username, String? email, String? password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);

      User? user = userCredential.user;

      FirebaseFirestore.instance.collection("Data").doc(user!.uid).set(
          {"email": email, "username": username, "profilePic": profilePic});

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Signin()));
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Please enter valid data"),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: const Color.fromARGB(255, 59, 55, 55),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 400,
            width: 300,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(25)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    "Registration",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    "WelCome To ChatApp",
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                        fontWeight: FontWeight.w100),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: 200,
                    child: TextField(
                      controller: _usernameController,
                      style: TextStyle(color: Colors.white54),
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent)),
                        floatingLabelStyle: TextStyle(color: Colors.redAccent),
                        hintText: "Enter Your Username",
                        label: Text("Username"),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.redAccent,
                        ),
                      ),
                    )),
                Container(
                    width: 200,
                    child: TextField(
                      controller: _emailController,
                      style: TextStyle(color: Colors.white54),
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent)),
                        floatingLabelStyle: TextStyle(color: Colors.redAccent),
                        hintText: "Enter Your Email",
                        label: Text("Email"),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.redAccent,
                        ),
                      ),
                    )),
                Container(
                    width: 200,
                    child: TextField(
                      obscureText: true,
                      controller: _passwordController,
                      style: TextStyle(color: Colors.white54),
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.redAccent)),
                        floatingLabelStyle: TextStyle(color: Colors.redAccent),
                        hintText: "Enter Your Password",
                        label: Text("Password"),
                        prefixIcon: Icon(
                          Icons.password,
                          color: Colors.redAccent,
                        ),
                      ),
                    )),
                    
                SizedBox(
                  height: 15,
                ),
                
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(26)),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          registerUser(
                              _usernameController.text.toString(),
                              _emailController.text.toString(),
                              _passwordController.text.toString());
                        });
                      },
                      icon: Text(
                        "Registration",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Click here if alredy Registar",
                      style: TextStyle(
                          color: Colors.white54, fontWeight: FontWeight.w100),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signin()));
                        },
                        icon: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
