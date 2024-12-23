// import 'package:chatapp/Screen/Dashbord.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class profileScreen extends StatefulWidget {
//   User? user;

//   profileScreen({super.key, required this.user});

//   @override
//   State<profileScreen> createState() => _profileScreenState();
// }

// class _profileScreenState extends State<profileScreen> {
//   TextEditingController _usernameController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();

//   Future<void> fetchDataInfo() async {
//     var document = await FirebaseFirestore.instance
//         .collection("Data")
//         .doc(widget.user!.uid)
//         .get();
//     setState(() {
//       _usernameController.text = document["username"];
//       _emailController.text = document["email"];
//       print("-------------->>>${document["username"]}");
//     });
//   }

//   Future<void> update() async {
//     var document = await FirebaseFirestore.instance
//         .collection("Data")
//         .doc(widget.user!.uid)
//         .update({"username": _usernameController.text.toString()});

//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text("Profile succes fully updated")));

//     Navigator.pop(context);
//     Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => Dashboard(user: widget.user),
//         ));
//   }

//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fetchDataInfo();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: 500,
//                 child: TextField(
//                   controller: _usernameController,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50)),
//                     label: Icon(Icons.person),
//                     hintText: 'UserName',
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Container(
//                 width: 500,
//                 child: TextField(
//                   controller: _emailController,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(50)),
//                     label: Icon(Icons.email),
//                     hintText: 'Email',
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               ElevatedButton(
//                   onPressed: () {
//                     update();
//                   },
//                   child: Text("Update"))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:chatapp/Screen/Dashbord.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class profileScreen extends StatefulWidget {
  User? user;

  profileScreen({super.key, required this.user});

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  Future<void> fetchDataInfo() async {
    var document = await FirebaseFirestore.instance
        .collection("Data")
        .doc(widget.user!.uid)
        .get();
    setState(() {
      _usernameController.text = document["username"];
      _emailController.text = document["email"];
      print("-------------->>>${document["username"]}");
    });
  }

  Future<void> update() async {
    await FirebaseFirestore.instance
        .collection("Data")
        .doc(widget.user!.uid)
        .update({"username": _usernameController.text.toString()});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Profile successfully updated")),
    );

    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Dashboard(user: widget.user),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchDataInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Black background
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 500,
                child: TextField(
                  style: TextStyle(color: Colors.white), // White text
                  controller: _usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    label: Icon(Icons.person, color: Colors.white),
                    hintText: 'UserName',
                    hintStyle: TextStyle(color: Colors.white70), // Hint text
                    filled: true,
                    fillColor: Colors.grey[900], // Input background
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 500,
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    label: Icon(Icons.email, color: Colors.white),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.grey[900],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  update();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[850], // Dark button color
                  foregroundColor: Colors.white, // Button text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
