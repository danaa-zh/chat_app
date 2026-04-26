// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:chat_app/features/app/ui/app.dart';
// import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await dotenv.load(fileName: ".env");  // ← load env FIRST

//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   runApp(const App());
// }

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:chat_app/features/app/ui/app.dart';
// import 'firebase_options.dart';

// const bool bypassAuth = bool.fromEnvironment('BYPASS_AUTH', defaultValue: false);

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await dotenv.load(fileName: ".env");

//   if (!bypassAuth) {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//   }

//   runApp(App(bypassAuth: bypassAuth));
// }