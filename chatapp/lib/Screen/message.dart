// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class MyMessageScreen extends StatefulWidget {
//   final DocumentSnapshot<Object?> userSnapshort;
//   MyMessageScreen({super.key, required this.userSnapshort});

//   @override
//   State<MyMessageScreen> createState() => _MyMessageScreenState();
// }

// class _MyMessageScreenState extends State<MyMessageScreen> {
//   TextEditingController _mesController = TextEditingController();

//   String formaTimestamp(Timestamp timestamp) {
//     DateTime dateTime = timestamp.toDate();
//     String formatedTime = DateFormat.jm().format(dateTime); //Format Time
//     String formattedDate = DateFormat.yMMMd().format(dateTime); //Format Date
//     return "$formattedDate at $formatedTime"; //Combine Date and Time
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             CircleAvatar(
//                 child: Image.network(
//               widget.userSnapshort["profilePic"],
//             )),
//             Text(widget.userSnapshort["username"]),
//             Icon(Icons.video_call_sharp),
//             Icon(Icons.call),
//             Icon(Icons.more_vert)
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection("message")
//                   .where("receiver",
//                       isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//                   .where("sender", isEqualTo: widget.userSnapshort.id)
//                   .orderBy("timestamp")
//                   .snapshots(),
//               builder: (context, senderSnapshot) {
//                 if (senderSnapshot.hasData) {
//                   var senderMessages = senderSnapshot.data!.docs;
//                   return StreamBuilder(
//                     stream: FirebaseFirestore.instance
//                         .collection("message")
//                         .where("sender",
//                             isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//                         .where("receiver", isEqualTo: widget.userSnapshort.id)
//                         .orderBy("timestamp")
//                         .snapshots(),
//                     builder: (context, receiverSnapshot) {
//                       if (receiverSnapshot.hasData) {
//                         var receiverMessage = receiverSnapshot.data!.docs;
//                         var allMessages = [
//                           ...senderMessages,
//                           ...receiverMessage
//                         ];
//                         allMessages.sort((a, b) => (a['timestamp'] as Timestamp)
//                             .compareTo(b['timestamp'] as Timestamp));

//                         return ListView.builder(
//                           itemCount: allMessages.length,
//                           itemBuilder: (context, index) {
//                             var message = allMessages[index];
//                             String senderID = message['sender'];
//                             bool isCurrentUserIsSender = senderID ==
//                                 FirebaseAuth.instance.currentUser!.uid;

//                             return Padding(
//                               padding: EdgeInsets.all(8),
//                               child: Row(
//                                 mainAxisAlignment: isCurrentUserIsSender
//                                     ? MainAxisAlignment.end
//                                     : MainAxisAlignment.start,
//                                 children: [
//                                   if (!isCurrentUserIsSender)
//                                     CircleAvatar(
//                                       child: Text(
//                                           "${widget.userSnapshort["username"][0]}"),
//                                     )
//                                   else
//                                     SizedBox(
//                                       width: 32,
//                                     ),
//                                   SizedBox(
//                                     width: 8,
//                                   ),
//                                   Flexible(
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         color: isCurrentUserIsSender
//                                             ? Colors.blue
//                                             : Colors.amber,
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                       padding: EdgeInsets.symmetric(
//                                           vertical: 8.0, horizontal: 12.0),
//                                       child: Column(
//                                         children: [
//                                           Text(
//                                             "${message["message"]}",
//                                             style:
//                                                 TextStyle(color: Colors.pink),
//                                           ),
//                                           Text(
//                                             formaTimestamp(
//                                               message["timestamp"] as Timestamp,
//                                             ),
//                                             style:
//                                                 TextStyle(color: Colors.black),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         );
//                       } else if (receiverSnapshot.hasError) {
//                         print(
//                             "------------------------->>> ERROR ${receiverSnapshot.error}");
//                         return Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       } else {
//                         return Center(child: CircularProgressIndicator());
//                       }
//                     },
//                   );
//                 } else if (senderSnapshot.hasError) {
//                   print(
//                       "------------------------->>> ERROR ${senderSnapshot.error}");
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else {
//                   return Center(child: CircularProgressIndicator());
//                 }
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Flexible(
//                   child: TextField(
//                     controller: _mesController,
//                     decoration: InputDecoration(
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Colors.pink,
//                           ),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Colors.black,
//                             ),
//                             borderRadius: BorderRadius.circular(20)),
//                         hintText: "Type Message Here",
//                         hintStyle: TextStyle(color: Colors.grey)),
//                     style: TextStyle(color: Colors.black),
//                   ),
//                 ),
//                 IconButton(
//                     onPressed: () {
//                       String messageText = _mesController.text.toString();
//                       if (messageText.isNotEmpty) {
//                         FirebaseFirestore.instance.collection("message").add({
//                           "sender": FirebaseAuth.instance.currentUser!.uid,
//                           "receiver": widget.userSnapshort.id,
//                           "message": messageText,
//                           "timestamp": DateTime.now(),
//                         });
//                         _mesController.clear();
//                       }
//                     },
//                     icon: Icon(Icons.send))
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyMessageScreen extends StatefulWidget {
  final DocumentSnapshot<Object?> userSnapshort;
  MyMessageScreen({super.key, required this.userSnapshort});

  @override
  State<MyMessageScreen> createState() => _MyMessageScreenState();
}

class _MyMessageScreenState extends State<MyMessageScreen> {
  TextEditingController _mesController = TextEditingController();

  String formaTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formatedTime = DateFormat.jm().format(dateTime); // Format Time
    String formattedDate = DateFormat.yMMMd().format(dateTime); // Format Date
    return "$formattedDate at $formatedTime"; // Combine Date and Time
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background to black
      appBar: AppBar(
        backgroundColor: Colors.black, // AppBar background color
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
                backgroundImage: NetworkImage(
              widget.userSnapshort["profilePic"],
            )),
            Text(
              widget.userSnapshort["username"],
              style: TextStyle(color: Colors.white), // White text
            ),
            Icon(Icons.video_call_sharp, color: Colors.white),
            Icon(Icons.call, color: Colors.white),
            Icon(Icons.more_vert, color: Colors.white),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("message")
                  .where("receiver",
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .where("sender", isEqualTo: widget.userSnapshort.id)
                  .orderBy("timestamp")
                  .snapshots(),
              builder: (context, senderSnapshot) {
                if (senderSnapshot.hasData) {
                  var senderMessages = senderSnapshot.data!.docs;
                  return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("message")
                        .where("sender",
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .where("receiver", isEqualTo: widget.userSnapshort.id)
                        .orderBy("timestamp")
                        .snapshots(),
                    builder: (context, receiverSnapshot) {
                      if (receiverSnapshot.hasData) {
                        var receiverMessage = receiverSnapshot.data!.docs;
                        var allMessages = [
                          ...senderMessages,
                          ...receiverMessage
                        ];
                        allMessages.sort((a, b) => (a['timestamp'] as Timestamp)
                            .compareTo(b['timestamp'] as Timestamp));

                        return ListView.builder(
                          itemCount: allMessages.length,
                          itemBuilder: (context, index) {
                            var message = allMessages[index];
                            String senderID = message['sender'];
                            bool isCurrentUserIsSender = senderID ==
                                FirebaseAuth.instance.currentUser!.uid;

                            return Padding(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: isCurrentUserIsSender
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  if (!isCurrentUserIsSender)
                                    CircleAvatar(
                                      child: Text(
                                          "${widget.userSnapshort["username"][0]}"),
                                    )
                                  else
                                    SizedBox(
                                      width: 32,
                                    ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Flexible(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: isCurrentUserIsSender
                                            ? const Color.fromARGB(255, 126, 27, 27)
                                            : Colors.grey[800],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${message["message"]}",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            formaTimestamp(
                                              message["timestamp"] as Timestamp,
                                            ),
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else if (receiverSnapshot.hasError) {
                        print(
                            "------------------------->>> ERROR ${receiverSnapshot.error}");
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  );
                } else if (senderSnapshot.hasError) {
                  print(
                      "------------------------->>> ERROR ${senderSnapshot.error}");
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _mesController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[900], // Dark background for input
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey!
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      hintText: "Type Message Here",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    style: TextStyle(color: Colors.white), // White text
                  ),
                ),
                IconButton(
                    onPressed: () {
                      String messageText = _mesController.text.toString();
                      if (messageText.isNotEmpty) {
                        FirebaseFirestore.instance.collection("message").add({
                          "sender": FirebaseAuth.instance.currentUser!.uid,
                          "receiver": widget.userSnapshort.id,
                          "message": messageText,
                          "timestamp": DateTime.now(),
                        });
                        _mesController.clear();
                      }
                    },
                    icon: Icon(Icons.send, color: Colors.white))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
