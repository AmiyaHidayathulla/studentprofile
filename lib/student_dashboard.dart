// ignore_for_file: prefer_final_fields, non_constant_identifier_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studentprofile/services/firestore.dart';
import 'package:studentprofile/student_newpost.dart';
import 'package:studentprofile/student_notification.dart';
import 'package:studentprofile/student_page.dart';
import 'package:studentprofile/student_post_card.dart';
import 'package:studentprofile/student_profile.dart';

class Student {
  String studentId;
  String student_name;
  String student_designation;
  List<dynamic> skills;
  String about;
  String company;
  String? linkedIn;
  String? twitter;
  String? mail;
  String dpURL;

  Student({
    required this.studentId,
    required this.student_name,
    required this.student_designation,
    required this.skills,
    required this.about,
    required this.company,
    this.linkedIn,
    this.twitter,
    this.mail,
    required this.dpURL,
  });
}

class Student_Dashboard extends StatefulWidget {
  const Student_Dashboard({
    super.key,
  });

  @override
  State<Student_Dashboard> createState() => _Student_DashboardState();
}

class _Student_DashboardState extends State<Student_Dashboard> {
  final FirestoreService _firestoreService = FirestoreService();
  final currentUser = FirebaseAuth.instance.currentUser;

  late String student_name = 'john doe';
  late String student_designation = 'CS Engineer';
  late List<dynamic> skills = ['null'];
  late String studentId='56';
  late String about = 'eg';
  late String company = 'eg';
  late String? linkedIn = 'eg';
  late String? twitter = 'eg';
  late String? mail = 'eg';
  String dpURL = '';

  Map<String, dynamic>? _postData;

  @override
  void initState() {
    super.initState();
    _fetchDetails();
  }

  int _selectedIndex = 0;

  Future<void> _fetchDetails() async {
    //studentId = currentUser!.email!;
    final postSnapshot = await _firestoreService.getStudent(
      studentId: studentId.toString(),
    );

    Map<String, dynamic>? postData;
    if (postSnapshot.exists) {
      postData = postSnapshot.data() as Map<String, dynamic>;
    } else {
      // Handle the case when the post is not found
      postData = null;
    }

    if (postData != null) {
      student_name = postData['studentName'] as String;
      student_designation = postData['studentDesignation'] as String;
      studentId = currentUser!.email!;
      skills = (postData['skills'] as List<dynamic>).cast<String>();
      about = postData['about'] as String;
      company = postData['company'] as String;
      linkedIn = postData['linkedIn'] as String;
      twitter = postData['twitter'] as String;
      mail = postData['mail'] as String;
      dpURL = postData['dpURL'] as String;
    } else {
      student_name = 'john doe';
      student_designation = 'CS Engineer';
      skills = ['null'];
      about = 'eg';
      company = 'eg';
      linkedIn = 'eg';
      twitter = 'eg';
      mail = 'eg';
      dpURL = 'eg';

      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('Account details not found'),
      //     duration: Duration(seconds: 3),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      StudentPage(),
      StudentPage(),
      StudentNewPostPage(
          student: Student(
        student_name: student_name,
        studentId: studentId,
        student_designation: student_designation,
        skills: skills,
        about: about,
        company: company,
        linkedIn: linkedIn,
        twitter: twitter,
        mail: mail,
        dpURL: dpURL,
      )),
      StudentPage(),
      StudentNotification(),
    ];

    return FutureBuilder(
      future: _fetchDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Student'),
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                              student: Student(
                            student_name: student_name,
                            studentId: studentId,
                            student_designation: student_designation,
                            skills: skills,
                            about: about,
                            company: company,
                            linkedIn: linkedIn,
                            twitter: twitter,
                            mail: mail,
                            dpURL: dpURL,
                          )),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(dpURL),
                      radius: 20.0,
                    ),
                  ),
                ),
              ],
            ),
            body: IndexedStack(
              index: _selectedIndex,
              children: widgetOptions,
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: 'Alumni',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'Post',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today),
                  label: 'Events',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: 'Notification',
                ),
              ],
            ),
          );
        }
      },
    );
  }
}