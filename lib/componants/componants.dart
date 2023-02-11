import 'package:chatapp/componants/const/colors.dart';
import 'package:chatapp/models/messages.dart';
import 'package:flutter/material.dart';

Widget defaultTextFromFiled(
        {bool obscureText = false,
          Function(String data)? onFieldSubmitted,
        Function(String value)? onChange,
        TextEditingController? controller,
        InputDecoration? decoration,
        required TextInputType textInputType,
        required String? label,
        Icon? prefix,
        IconButton? suffix,
        required FormFieldValidator<String> validator}) =>
    TextFormField(
      style: const TextStyle(
          fontSize: 20, fontFamily: 'Regular', color: Colors.white),
      validator: (data) {
        if (data!.isEmpty) {
          return 'filed is required';
        }
        return null;
      },
      onFieldSubmitted:onFieldSubmitted ,
      onChanged: onChange,
      controller: controller,
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        fillColor: Colors.grey,
        focusColor: Colors.red,
        label: Text(
          label!,
          style: TextStyle(color: Colors.white),
        ),
        prefixIcon: prefix,
        suffixIcon: suffix,
        border: const OutlineInputBorder(),
      ),
      keyboardType: textInputType,
      obscureText: obscureText,
    );

Widget defaultButton(
        {Color backgroundColor = Colors.red,
        double width = double.infinity,
        required Function() onPressed,
        required String text,
        bool isUpperCase = true}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor,
      ),
      width: double.infinity,
      child: MaterialButton(
          onPressed: onPressed,
          child: Text(
            isUpperCase ? text.toUpperCase() : text,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

Widget chatBubble({
 required MessagesModel? message}
    ) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20))),
      child:  Text(message!.message,style: const TextStyle(color: Colors.white,fontSize: 18),),
    ),

  );
}

Widget chatBubbleForFriend({
  required MessagesModel? message}
    ) {
  return Align(
    alignment: Alignment.centerRight,
    child: Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20))),
      child:  Text(message!.message,style: const TextStyle(color: Colors.white,fontSize: 18),),
    ),

  );
}