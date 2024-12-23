// import 'package:chatapp/Screen/Profilescreen.dart';
// import 'package:chatapp/Screen/message.dart';
// import 'package:chatapp/Screen/signin.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// class Dashboard extends StatefulWidget {
//   User? user;
//   Dashboard({super.key, required this.user});

//   @override
//   State<Dashboard> createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard> {
//   List<DocumentSnapshot>? alluser;
//   List<DocumentSnapshot>? filteruser;

//   String? username;

//   Future<void> fetchDataInfo() async {
//     var document = await FirebaseFirestore.instance
//         .collection("Data")
//         .doc(widget.user!.uid)
//         .get();
//     setState(() {
//       username = document["username"];
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     fetchDataInfo();
//   }

//   void searchData(String keyword) {
//     setState(() {
//       print(keyword);
//       if (keyword.isEmpty) {
//         filteruser = alluser;
//       } else {
//         filteruser = alluser!
//             .where((user) =>
//                 user["username"].toLowerCase().contains(keyword.toLowerCase()))
//             .toList();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.pink.shade100,
//       appBar: AppBar(

//         title: Text("Hi $username"),
//         actions: [
//           PopupMenuButton<String>(
//             icon: Icon(Icons.more_vert),
//             onSelected: (value) {
//               if (value == "Profile") {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => profileScreen(user: widget.user),
//                     ));
//               } else if (value == "Logout") {
//                 FirebaseAuth.instance.signOut();
//                 Navigator.pushReplacement(
//                     context, MaterialPageRoute(builder: (context) => Signin()));
//               }
//             },
//             itemBuilder: (context) {
//               return [
//                 PopupMenuItem(value: "Profile", child: Text("Profile")),
//                 PopupMenuItem(value: "Logout", child: Text("Logout")),
//               ];
//             },
//           )
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(colors:[const Color.fromARGB(255, 252, 229, 237),const Color.fromARGB(255, 236, 210, 241)],
//             begin: Alignment.topCenter,
//             end:Alignment.bottomCenter
//           )
//         ),
//         child: Column(

//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [

//             SizedBox(

//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 40,

//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Colors.white38,
//                   ),
//                   child:

//                    TextField(
//                     onChanged: (value) {
//                       searchData(value);
//                     },
//                     decoration: InputDecoration(
//                       label: Icon(Icons.search,color: Colors.purple,),
//                       hintText: 'search',
//                       border: InputBorder.none
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: StreamBuilder(
//                 stream: FirebaseFirestore.instance.collection("Data").snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     alluser = snapshot.data!.docs
//                         .where((element) => element.id != widget.user!.uid)
//                         .toList();
//                     filteruser ??= List.from(alluser!);

//                     return ListView.builder(
//                       itemCount: filteruser!.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: const EdgeInsets.all(10),
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                         MyMessageScreen(userSnapshort: filteruser![index]),
//                                   ));
//                             },
//                             child: Container(
//                               height: 75,

//                               child: Card(

//                                 child: Row(
//                                   children: [
//                                     SizedBox(width: 10,),
//                                     Container(
//                                       height: 50,
//                                       width: 50,
//                                       child: Image.network(filteruser![index]["profilePic"])),
//                                     SizedBox(width: 20,),
//                                     Text("${filteruser![index]["username"]}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),

//                                   ],
//                                 )
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   }

//                   return Center(child: CircularProgressIndicator());
//                 },
//               ),
//             ),
//           Container(

//           height: 100,

//           child: ClipRRect(
//             borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(35),
//                       topRight: Radius.circular(35)),

//             child: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person, color: Colors.purple),
//             label: "Profile",backgroundColor: Colors.black12,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.chat,color: Colors.purple),
//             label: "Message",backgroundColor: Colors.black12,
//           ),

//           BottomNavigationBarItem(

//             icon: Icon(Icons.settings,color:Colors.purple),

//             label: "Settings",backgroundColor: Colors.black12,

//           ),
//         ],
//             ),
//           ),

//         ),

//           ],
//         ),
//       ),

//     );
//   }
// }import 'package:chatapp/Screen/Profilescreen.dart';
import 'package:chatapp/Screen/Profilescreen.dart';
import 'package:chatapp/Screen/message.dart';
import 'package:chatapp/Screen/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  User? user;
  Dashboard({super.key, required this.user});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<DocumentSnapshot>? alluser;
  List<DocumentSnapshot>? filteruser;

  String? username;

  int _selectedIndex = 0; // Keeps track of the selected tab

  Future<void> fetchDataInfo() async {
    var document = await FirebaseFirestore.instance
        .collection("Data")
        .doc(widget.user!.uid)
        .get();
    setState(() {
      username = document["username"];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDataInfo();
  }

  void searchData(String keyword) {
    setState(() {
      if (keyword.isEmpty) {
        filteruser = alluser;
      } else {
        filteruser = alluser!
            .where((user) =>
                user["username"].toLowerCase().contains(keyword.toLowerCase()))
            .toList();
      }
    });
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      // Navigate to Profile Screen
      
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => profileScreen(user: widget.user),
        ),
      );
      
    } else if (index == 2) {
      // Show Logout Confirmation Dialog
      _showLogoutDialog();
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          title: Text(
            "Logout",
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            "Are you sure you want to logout?",
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Close dialog
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Signin()),
                );
              },
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Black background for the app
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Hi $username",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.grey.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white12,
                  ),
                  child: TextField(
                    onChanged: (value) {
                      searchData(value);
                    },
                    style: TextStyle(color: Colors.white), // White text
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.red, // Red search icon
                      ),
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.white70), // White hint
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Data").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    alluser = snapshot.data!.docs
                        .where((element) => element.id != widget.user!.uid)
                        .toList();
                    filteruser ??= List.from(alluser!);

                    return ListView.builder(
                      itemCount: filteruser!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MyMessageScreen(userSnapshort: filteruser![index]),
                                ),
                              );
                            },
                            child: Container(
                              height: 75,
                              child: Card(
                                color: Colors.grey.shade800, // Dark card color
                                child: Row(
                                  children: [
                                    SizedBox(width: 10),
                                    Container(
                                      height: 50,
                                      width: 50,
                                      child: Image.network(
                                        filteruser![index]["profilePic"],
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      "${filteruser![index]["username"]}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white), // White text
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Container(
              height: 100,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
                child: BottomNavigationBar(
                  backgroundColor: Colors.black, // Black background
                  selectedItemColor: Colors.red, // Red for selected icon
                  unselectedItemColor: Colors.white, // White for unselected icons
                  currentIndex: _selectedIndex,
                  onTap: _onBottomNavTap,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: "Profile",
                    ),
                    
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: "Settings",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
