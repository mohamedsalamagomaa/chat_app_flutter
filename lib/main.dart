import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/screens/login_screen.dart';
import 'package:chatapp/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'componants/const/colors.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,);
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        ChatScreen.id:(context)=>ChatScreen(),
        LoginScreen.id:(context)=> LoginScreen(),
        RegisterScreen.id:(context)=> RegisterScreen()
      },
      theme: ThemeData(
        scaffoldBackgroundColor:kPrimaryColor ,
        appBarTheme: const AppBarTheme(backgroundColor: kPrimaryColor),
        //fontFamily: 'Aboreto'
      ),
      debugShowCheckedModeBanner: false,
      initialRoute:LoginScreen.id ,
    );
  }
}