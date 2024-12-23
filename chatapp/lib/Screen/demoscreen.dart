import 'package:flutter/material.dart';

class Demoscreen extends StatefulWidget {
  const Demoscreen({super.key});

  @override
  State<Demoscreen> createState() => _DemoscreenState();
}

class _DemoscreenState extends State<Demoscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            SizedBox(height: 100,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                    height: 40,
                    width: 200,
                    
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                      
                    ),
                    child:
                     TextField(
                      
                      decoration: InputDecoration(
                        label: Icon(Icons.search),
                        hintText: 'search',
                        border: InputBorder.none
                      ),
                    ),
                  ),
            ),          ],
        ));
  }
}
