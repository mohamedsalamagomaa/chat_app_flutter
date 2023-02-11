import 'package:chatapp/models/messages.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../componants/componants.dart';
import '../componants/const/strings.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chatScreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
// create and add collection
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  String? onChangeData;
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)?.settings.arguments;
    //widget help you build ui depend data come from data base
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreateAt, descending: true).snapshots(),
        //snapshot = data come from data base
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            List<MessagesModel> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(MessagesModel.fromJason(snapshot.data!.docs[i]));
            }
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'chat',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image(
                      image: AssetImage('assets/images/chat.png'),
                      height: 40,
                      width: 40,
                    )
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _controller,
                      reverse: true,
                      itemCount: messagesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return messagesList[index].id == email
                            ? chatBubble(message: messagesList[index])
                            : chatBubbleForFriend(message: messagesList[index]);
                      },
                    ),
                  ),
                  buildTextField(controller: TextEditingController())
                ],
              ),
            );
          } else {
            return Scaffold(
                body: Center(
                    child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.white,
                        child: const Text(
                          'Loading....',
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        ))));
          }
        });
  }

  Widget buildTextField({TextEditingController? controller}) {
    var id = ModalRoute.of(context)?.settings.arguments;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        onChanged: (data) {
          onChangeData = data;
        },
        controller: controller,
        onSubmitted: (data) {
          //add filed to body of data
          messages
              .add({keyMessageBody: data, kCreateAt: DateTime.now(), 'id': id});
          controller?.clear();
          _controller.animateTo(_controller.position.minScrollExtent,
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn);
        },
        decoration: InputDecoration(
          hintText: 'Send Message',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.grey, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              messages.add({
                keyMessageBody: onChangeData,
                kCreateAt: DateTime.now(),
                'id': id
              });
              controller?.clear();
              _controller.animateTo(_controller.position.minScrollExtent,
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn);
            },
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
