import 'package:chatapp/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../componants/componants.dart';
import '../componants/const/colors.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id='LoginScreen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email, password;

  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    //package for loading circle progress
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Center(
          child: Container(
            color: kPrimaryColor,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Chat App',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontFamily: 'Pacifico'),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Singin',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: defaultTextFromFiled(
                      textInputType: TextInputType.emailAddress,
                      onChange: (data) {
                        email = data;
                      },
                      label: 'Email Address',
                      controller: TextEditingController(),
                      validator: (String? value) {
                        if (value == null) {
                          return ('Email Address Must not be null');
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: defaultTextFromFiled(
                      onFieldSubmitted: (data)async{
                        if(formKey.currentState!.validate()){
                          isLoading = true;
                          setState(() {
                          });
                          try {
                            await logIn();
                            Navigator.pushNamed(context, ChatScreen.id,arguments: email);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              showSnackBar(context, 'user-not-found');
                            } else if (e.code == 'wrong-password') {
                              showSnackBar(context, 'wrong-password');
                            }
                          }catch(e){
                            showSnackBar(context, 'some thing is wrong');
                          }
                          isLoading=false;
                          setState(() {

                          });
                        }
                      },
                      obscureText: true,
                      textInputType: TextInputType.emailAddress,
                      onChange: (data) {
                        password = data;
                      },
                      label: 'Password',
                      controller: TextEditingController(),
                      validator: (String? value) {
                        if (value == null) {
                          return ('Password Must not be null');
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: defaultButton(
                        text: 'Login',
                        onPressed: ()async {
                        if(formKey.currentState!.validate()){
                          isLoading = true;
                          setState(() {
                          });
                          try {
                            await logIn();
                            Navigator.pushNamed(context, ChatScreen.id,arguments: email);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              showSnackBar(context, 'user-not-found');
                            } else if (e.code == 'wrong-password') {
                              showSnackBar(context, 'wrong-password');
                            }
                          }catch(e){
                            showSnackBar(context, 'some thing is wrong');
                          }
                          isLoading=false;
                          setState(() {

                          });
                        }
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'DON\'T HAVE AN ACCOUNT?',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RegisterScreen.id);
                          },
                          child: const Text(
                            'REGISTER NOW',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> logIn() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.signInWithEmailAndPassword(
        email: email!, password: password!);
  }
}
