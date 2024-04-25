import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studentprofile/profile_form.dart';
import 'package:studentprofile/services/firestore.dart';
import 'package:studentprofile/student_dashboard.dart';
import 'package:studentprofile/student_edit-profile.dart';

class ProfileScreen extends StatefulWidget {
  final Student student;

  ProfileScreen({required this.student});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Set<String> _selectedButton = {'Details'};

  void updateSelected(Set<String> newSelection) {
    setState(() {
      _selectedButton = newSelection;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.student.student_name),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  // Navigate to the MainPage
                  //Navigator.pushAndRemoveUntil(
                    //context,
                    //MaterialPageRoute(builder: (context) => MainPage()),
                    //(route) => false,
                 // );
                } catch (e) {
                  print('Error signing out: $e');
                }
              },
              child: Text('LogOut'),
            )
          ],
        ),
        body: Stack(
          children: [
            Image.network(
              'https://marketplace.canva.com/EAE1oe3H6Sc/1/0/1600w/canva-black-elegant-minimalist-profile-linkedin-banner-nc0eALdRvKU.jpg',
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0, .2],
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: height * .13),
                    Padding(
                      padding:
                          EdgeInsets.fromLTRB(width * .08, 0, width * .08, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(28),
                                child: Image.network(widget.student.dpURL,
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          SizedBox(width: width * .05),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  children: [
                                    Text(
                                      widget.student.student_name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Text(widget.student.student_designation),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                               MaterialPageRoute(
                                 builder: (context) => ProfileForm(),
                                ),
                              );
                            },
                            icon: Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          width * .08, width * 0.03, width * .08, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.student.about,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: width * 0.08),
                          Column(
                            children: [
                              Text(
                                'Contact :',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.phone,
                                        size: 30,
                                      )),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.email,
                                        size: 30,
                                      )),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.location_on,
                                        size: 30,
                                      )),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: width * 0.08),
                          Center(
                            child: SegmentedButton(
                              segments: <ButtonSegment<String>>[
                                ButtonSegment(
                                    value: 'Details', label: Text('Details')),
                                ButtonSegment(
                                    value: 'Posts', label: Text('Posts')),
                              ],
                              selected: _selectedButton,
                              onSelectionChanged: updateSelected,
                            ),
                          ),
                          SizedBox(height: width * 0.08),
                          if (_selectedButton.contains('Details'))
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                               
                                SkillsSection(skills: widget.student.skills),
                              ],
                            )
                          else
                            PostsSection(
                              studentId: widget.student.studentId,
                              firestoreService: FirestoreService(),
                            ),
                        ],
                      ),
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

// class UserInfoSection extends StatelessWidget {
//   final Alumni alumni;

//   UserInfoSection({required this.alumni});

//   @override
//   Widget build(BuildContext context) {
//     Color color2566be = Color(0xFF2566BE);
//     LinearGradient gradient = LinearGradient(
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//       colors: [
//         color2566be.withOpacity(0.5),
//         color2566be,
//       ],
//     );

//     return Container(
//       padding: EdgeInsets.all(16.0),
//       decoration: BoxDecoration(
//         gradient: gradient,
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           CircleAvatar(
//             radius: 60,
//             // backgroundImage: AssetImage('assets/profile_photo.jpg'),
//           ),
//           SizedBox(width: 20),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   alumni.alumni_name,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     fontSize: 24,
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   alumni.alumni_designation,
//                   style: TextStyle(fontSize: 18, color: Colors.white),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Posts: 100',
//                   style: TextStyle(fontSize: 18, color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => EditProfileForm(),
//                 ),
//               );
//             },
//             icon: Icon(Icons.edit),
//           ),
//         ],
//       ),
//     );
//   }
// }

// SkillsSection
class SkillsSection extends StatelessWidget {
  final List<dynamic> skills;

  SkillsSection({required this.skills});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skills',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 5),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: skills
              .map((skill) => Chip(
                    label: Text(skill),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

// EmailSection
class EmailSection extends StatelessWidget {
  final String email;

  EmailSection({required this.email});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 5),
          Text(
            email,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

// CompanySection


// PostsSection
class PostsSection extends StatefulWidget {
  final String studentId;
  final FirestoreService firestoreService;
  bool isView = false;

  PostsSection({
    required this.studentId,
    required this.firestoreService,
  });

  PostsSection.withView({
    required this.studentId,
    required this.firestoreService,
    required this.isView,
  });

  @override
  _PostsSectionState createState() => _PostsSectionState();
}

class _PostsSectionState extends State<PostsSection> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: widget.firestoreService.getStudentProfilePosts(
            studentId: widget.studentId,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No data available'));
            }

            List studentProfilePostList = snapshot.data!.docs;
            return GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
              ),
              itemCount: studentProfilePostList.length,
              itemBuilder: (BuildContext context, int index) {
                // Get each individual doc
                DocumentSnapshot document = studentProfilePostList[index];
                // String docID = document.id;

                // Get note from each doc
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String? imgURL = data['imageURL'];

                // Delete post function
                void deletePost() {
                  setState(() {
                    studentProfilePostList.removeAt(index);
                  });
                }

                return ProfileSquarePost(
                  imageURL: imgURL ?? '',
                  postId: document.id,
                  studentId: widget.studentId,
                  isView: widget.isView,
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class ProfileSquarePost extends StatefulWidget {
  final String imageURL;
  final String postId;
  final String studentId;
  bool isView = false;

  ProfileSquarePost({
    required this.imageURL,
    required this.postId,
    required this.studentId,
    required this.isView,
  });

  @override
  State<ProfileSquarePost> createState() => _ProfileSquarePostState();
}

class _ProfileSquarePostState extends State<ProfileSquarePost> {
  FirestoreService firestoreService = FirestoreService();
  void _areYouSure() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
              width: double.maxFinite,
              child: ListTile(
                title: Text('Are you sure?'),
              )),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                firestoreService.deletePost(
                    studentId: widget.studentId, postId: widget.postId);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Post Deleted'),
                  ),
                );
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showForm() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Options'),
          content: Container(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditPostForm(
                                studentId: widget.studentId,
                                postId: widget.postId)));
                  },
                  child: ListTile(
                    title: Text('Edit Post'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    _areYouSure();
                    // Navigator.of(context).pop();
                  },
                  child: ListTile(
                    title: Text('Delete Post'),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle tap if needed
        if (!widget.isView) {
          _showForm();
        }
      },
      onLongPress: () {
        // Long press to delete the post

        // showDialog(
        //     context: context,
        //     builder: (context) => Dialog(
        //           child: Container(
        //             height: MediaQuery.of(context).size.height * .2,
        //             child: Text('Sample Text'),
        //           ),
        //         ));
      },
      child: Card(
        margin: EdgeInsets.all(2.0),
        elevation: 5.0,
        child: AspectRatio(
          aspectRatio: 1.0,
          child: widget.imageURL.isNotEmpty
              ? Image.network(
                  widget.imageURL,
                  fit: BoxFit.cover,
                )
              : Container(child: Icon(Icons.abc)),
        ),
      ),
    );
  }
}
