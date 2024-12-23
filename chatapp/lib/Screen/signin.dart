import 'package:chatapp/Screen/Dashbord.dart';
import 'package:chatapp/Screen/Registration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool isloding = false;
  Future<void> loginUser(String? email, String? password) async {
    setState(() {
      
      isloding=true;
    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);

      User? user = userCredential.user;

      print(user!.uid);

      var document = await FirebaseFirestore.instance
          .collection("Data")
          .doc(user.uid)
          .get();

      print(document["username"]);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Dashboard(
              user: user,
            ),
          ));
    } catch (e) {}
  }

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
                    "Login",
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
                    "WellCome To ChatApp",
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
                      style: TextStyle(color: Colors.white),
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
                          loginUser(_emailController.text.toString(),
                              _passwordController.text.toString());
                        });
                      },
                      icon: Text(
                        "Login",
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
                      "New? Click for Registration",
                      style: TextStyle(
                          color: Colors.white54, fontWeight: FontWeight.w100),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Registration(),
                              ));
                        },
                        icon: Text(
                          "Registration",
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
