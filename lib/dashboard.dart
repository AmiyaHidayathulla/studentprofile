
// import 'package:flutter/material.dart';
// import 'package:studentprofile/student_newpost.dart';
// import 'package:studentprofile/student_notification.dart';
// import 'package:studentprofile/student_page.dart';
// import 'package:studentprofile/student_post_card.dart';

// class Student {
//   String studentId;
//   String student_name;
//   String student_designation;
//   List<dynamic> skills;
//   String about;
//   String company;
//   String? linkedIn;
//   String? twitter;
//   String? mail;
//   String dpURL;

//   Student({
//     required this.studentId,
//     required this.student_name,
//     required this.student_designation,
//     required this.skills,
//     required this.about,
//     required this.company,
//     this.linkedIn,
//     this.twitter,
//     this.mail,
//     required this.dpURL,
//   });
// }

// class Student_Dashboard extends StatefulWidget {
//   const Student_Dashboard({super.key});

//   @override
//   State<Student_Dashboard> createState() => _Student_DashboardState();
// }

// class _Student_DashboardState extends State<Student_Dashboard> {
//   @override
//   int _selectedIndex = 0;

//   static List<Widget> _widgetOptions = <Widget>[
//     StudentPage(),
//     StudentPage(),
//     StudentNewPostPage(),
//     StudentPage(),
//     StudentNotification(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: IndexedStack(
//           index: _selectedIndex,
//           children: _widgetOptions,
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         currentIndex: _selectedIndex,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         selectedItemColor: Colors.black,
//         unselectedItemColor: Colors.grey,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.people),
//             label: 'Alumni',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.add),
//             label: 'Post',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.calendar_today),
//             label: 'Events',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications),
//             label: 'Notification',
//           ),
//         ],
//       ),
//     );
//   }
// }
