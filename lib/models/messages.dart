import 'package:chatapp/componants/const/strings.dart';

class MessagesModel {
  final String message,id;

  MessagesModel(this.message,this.id);
  factory MessagesModel.fromJason(jason) {
    return MessagesModel(
        jason[keyMessageBody],
        jason['id']
    );
  }
}
