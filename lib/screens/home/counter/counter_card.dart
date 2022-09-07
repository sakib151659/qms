// import 'package:flutter/material.dart';
//
// class CounterCard extends StatefulWidget {
//   const CounterCard({Key? key}) : super(key: key);
//
//   @override
//   _CounterCardState createState() => _CounterCardState();
// }
//
// class _CounterCardState extends State<CounterCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(7),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.grey,
//             offset: Offset(0.0, 1.0), //(x,y)
//             blurRadius: 2.0,
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Text('\n'+document['email'],
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//               )),
//
//           Text('\n'+document[MyTexts.branchName].toString() +' , ' + document[MyTexts.counterNumber].toString()+'\n',
//               style: const TextStyle(
//                 color: Colors.white,
//                 //fontWeight: FontWeight.bold,
//                 fontSize: 15,
//                 letterSpacing: 2,
//               )),
//         ],
//       ),
//     );
//   }
// }
