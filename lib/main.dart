import 'package:firebase_core/firebase_core.dart';
import 'package:studentprofile/student_dashboard.dart';
import 'firebase_options.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_app_check/firebase_app_check.dart';





import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.photos.request();
  await Permission.storage.request();


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate();
  runApp(MaterialApp(
    home: const Student_Dashboard(),
  ));
}
