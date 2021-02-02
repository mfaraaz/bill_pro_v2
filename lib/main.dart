import 'file:///C:/Users/muazz/AndroidStudioProjects/bill_pro_v2/lib/widget/auth_form.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:bill_pro_v2/models/customer_data.dart';
import 'package:bill_pro_v2/screens/auth_screen.dart';
import 'package:bill_pro_v2/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'models/bill_data.dart';
import 'models/item_list_data.dart';
import 'models/others_data.dart';
import 'models/product_data.dart';
import 'models/user_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => CustomerData()),
      ChangeNotifierProvider(create: (context) => ProductData()),
      ChangeNotifierProvider(create: (context) => ItemListData()),
      ChangeNotifierProvider(create: (context) => OthersData()),
      ChangeNotifierProvider(create: (context) => BillData()),
      ChangeNotifierProvider(create: (context) => UserData()),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(primaryColor: Colors.blueAccent),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if (userSnapshot.hasData)
            return MainScreen();
          else
            return AuthScreen();
        },
      ),
    );
  }
}
