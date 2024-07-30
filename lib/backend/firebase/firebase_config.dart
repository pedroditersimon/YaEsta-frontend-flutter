import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCUCXgQ--2hJysW8gcd6iNVWYI93pyq5sA",
            authDomain: "yaesta-c9ea4.firebaseapp.com",
            projectId: "yaesta-c9ea4",
            storageBucket: "yaesta-c9ea4.appspot.com",
            messagingSenderId: "844944575677",
            appId: "1:844944575677:web:ec1349970078fdae24fbd4"));
  } else {
    await Firebase.initializeApp();
  }
}
