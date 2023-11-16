import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui/Auth/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    //for web
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyATWQYW4sIgTRwRN9J2JwW-N4mDNDBX3r0",
            authDomain: "juicehub-53aa4.firebaseapp.com",
            projectId: "juicehub-53aa4",
            storageBucket: "juicehub-53aa4.appspot.com",
            messagingSenderId: "80039370554",
            appId: "1:80039370554:web:0dc7a4d23c450731feba03",
            measurementId: "G-RSY9XT0H0J"));
  } else {
    //for android
    await Firebase.initializeApp();
  }

  runApp(App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // bool? b;
  // keeplog() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   if (pref.containsKey('name')) {
  //     b = true;
  //   } else {
  //     b = false;
  //   }
  // }

  // @override
  // void initState() {
  //   keeplog();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: signup(),
    );
    // b == false ? FollowList() : page2());
  }
}

// Variant: debugAndroidTest
// Config: debug
// Store: C:\Users\Hp\.android\debug.keystore
// Alias: AndroidDebugKey
// MD5: 04:31:E3:85:04:9E:9C:B5:C7:5C:16:50:E0:72:52:6C
// SHA1: A1:D7:A1:81:1E:09:36:21:04:2C:61:8A:57:6E:83:15:34:D2:8C:40
// SHA-256: 20:79:38:37:55:77:1A:38:F3:DB:18:2C:66:7D:50:DB:C2:86:A9:07:4D:0E:38:E6:20:B9:6F:03:51:0A:DF:D7
