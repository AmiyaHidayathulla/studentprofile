import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
    final CollectionReference student_posts =
      FirebaseFirestore.instance.collection('student_posts');
    final CollectionReference student =
      FirebaseFirestore.instance.collection('student');

     Future<void> addStudentPosts({
    
    required String studentId,
    required String studentName,
    required String studentDesignation,
    required String caption,
    required String description,
    String? imageURL,
    String? dpURL,
  }) {
    String unique = DateTime.now().toIso8601String();
    student_posts.doc('$studentId$unique').set({
      
      'studentId': studentId,
      'studentName': studentName,
      'studentDesignation': studentDesignation,
      'caption': caption,
      'description': description,
      'imageURL': imageURL,
      'dpURL' : dpURL,
      'likes': [],
      'timestamp': Timestamp.now(),
    });


   

    //Adding post to student user data
    DocumentReference StudentId = student.doc(studentId);
    return StudentId.collection('posts').doc('$studentId$unique').set({
      'studentId': studentId,
      'studentName': studentName,
      'studentDesignation': studentDesignation,
      'caption': caption,
      'description': description,
      'imageURL': imageURL,
      'timestamp': Timestamp.now(),
    });
  }
   //To add student details
  Future<void> addStudent({
    required String? studentMail,
    required String studentName,
    required String studentDesignation,
    required String company,
    required String about,
    required List<String> skills,
    String? dpURL,
    String? linkedIn,
    String? twitter,
    String? mail,
  }) {
    return student.doc('$studentMail').set({
      'studentMail': studentMail,
      'studentId': studentMail,
      'studentName': studentName,
      'studentDesignation': studentDesignation,
      'skills': skills,
      'company': company,
      'about': about,
      'dpURL': dpURL,
      'linkedIn': linkedIn,
      'twitter': twitter,
      'mail': mail,
    });
  }
   // Update/Edit post data
  List StudentPostInstances({
    required String postId,
    required String studentId,
  }) {
    // Update the post in the student_posts collection
    DocumentReference studentRef = student_posts.doc(postId);

    // Update the post in the student user data
    DocumentReference studentPostRef =
        student.doc(studentId).collection('posts').doc(postId);

    return [studentRef, studentPostRef];
  }
  Future<DocumentSnapshot> getStudent({
    required String studentId,
  }) async {
    print(studentId);
    final postSnapshot = await student.doc(studentId).get();
    return postSnapshot;
  }

   Stream<QuerySnapshot> getStudentPostsStream() {
    final studentPostsStream =
        student_posts.orderBy('timestamp', descending: true).snapshots();
    return studentPostsStream;
  }


  Stream<QuerySnapshot> getStudentProfilePosts({required String studentId}) {
    print(studentId);
    final studentProfileStream = student
        .doc(studentId)
        .collection('posts')
        .orderBy('timestamp', descending: true)
        .snapshots();
    return studentProfileStream;
  }
  //To get a single alumni post
  Future<DocumentSnapshot> getStudentPost({
    required String studentId,
    required String postId,
  }) async {
    print(studentId);
    final studentRef = student.doc(studentId);
    final postSnapshot = await studentRef.collection('posts').doc(postId).get();
    return postSnapshot;
  }
  //To delete data inside the profile posts and student_posts
  Future<void> deletePost({
    required String studentId,
    required String postId,
  }) async {
    try {
      // Delete the document in student profile
      await student.doc(studentId).collection('posts').doc(postId).delete();
      // Delete the post in student_posts
      await student_posts.doc(postId).delete();

      print('Post deleted successfully');
    } catch (e) {
      print('Error deleting post: $e');
    }
  }
   // Update/Edit post data
  Future<void> updateStudentPost({
    required String postId,
    required String studentId,
    required String caption,
    required String description,
  }) async {
    // Update the post in the alumni_posts collection
    await student_posts.doc(postId).update({
      'caption': caption,
      'description': description,
      'timestamp': Timestamp.now(),
      'edited': true,
    });

    // Update the post in the alumni user data
    DocumentReference studentRef = student.doc(studentId);
    await studentRef.collection('posts').doc(postId).update({
      'caption': caption,
      'description': description,
      'timestamp': Timestamp.now(),
      'edited': true,
    });
  }

  // Update/Edit post data
  List studentPostInstances({
    required String postId,
    required String studentId,
  }) {
    // Update the post in the student_posts collection
    DocumentReference studentRef = student_posts.doc(postId);

    // Update the post in the student user data
    DocumentReference studentPostRef =
        student.doc(studentId).collection('posts').doc(postId);

    return [studentRef, studentPostRef];
  }
  }
