import 'package:coffee_card/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

// class Sandbox extends StatelessWidget {
//   const Sandbox({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.grey[800],
//         title: Text(
//           "Sandbox",
//           style: TextStyle(
//             fontSize: 24,
//             letterSpacing: 8,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Container(
//             height: 100,
//             color: Colors.red[700],
//             padding: EdgeInsets.all(20),
//             child: Text("one"),
//           ),
//           Container(
//             height: 200,
//             color: Colors.blue[500],
//             padding: EdgeInsets.all(20),
//             child: Text("two"),
//           ),
//           Container(
//             height: 300,
//             color: Colors.green[500],
//             padding: EdgeInsets.all(20),
//             child: Text("three"),
//           )
//         ],
//       ),
//     );
//   }
// }
