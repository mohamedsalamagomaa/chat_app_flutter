import 'package:chatapp/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../componants/componants.dart';
import '../componants/const/colors.dart';

class RegisterScreen extends StatefulWidget {
  static String id = 'registerScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email, password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
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
                        fontFamily: 'Pacifico',
                        color: Colors.red,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Register',
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
                      label: 'Email Address',
                      onChange: (data) {
                        email = data;
                      },
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
                      obscureText: true,
                      textInputType: TextInputType.emailAddress,
                      label: 'Password',
                      onChange: (data) {
                        password = data;
                      },
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
                        text: 'Register',
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            isLoading = true;
                            setState(() {});
                            try {
                              await register();
                              Navigator.pushNamed(context, ChatScreen.id);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'email-already-in-use') {
                                showSnackBar(context, 'email already exist');
                              } else if (e.code == 'weak-password') {
                                showSnackBar(context, 'weak password');
                              }
                            } catch (e) {
                              showSnackBar(context, 'some thing is wrong');
                            }
                          }
                          isLoading = false;
                          setState(() {});
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        ' HAVE AN ACCOUNT?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'LogIn',
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

  Future<void> register() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}
