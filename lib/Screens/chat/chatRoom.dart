import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:fcv_trucker/Screens/chat/chatRoomCtr.dart';
import 'package:fcv_trucker/myConstants.dart';
import 'package:fcv_trucker/myVoids.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final ChatRoomCtr gc = Get.find<ChatRoomCtr>();

  bool isSender = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(authCtr.selectedUser.name!),
        centerTitle: true,
        backgroundColor: Color(0xff024855),
        elevation: 10,
      ),
      body: Container(
          alignment: Alignment.topCenter,
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Landing page – 1.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: GetBuilder<ChatRoomCtr>(
            builder:(ctr)=> Stack(
              children: [
                gc.messagesWidgets.isNotEmpty
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Column(children: gc.messagesWidgets),
                            SizedBox(height: 90)
                          ],
                        )
                      )
                    : Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 115.0),
                    child: Text('send your first message',
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18
                      ),
                    ),
                  ),
                ),
                MessageBar(
                  onSend: (msg) {
                    print('## message: $msg');
                    gc.sendMessage(msg);
                  },
                  replyWidgetColor: Colors.black54,
                  sendButtonColor: Colors.green,
                  messageBarColor: darkGreen,
                  actions: [
                    InkWell(
                      child: Icon(
                        Icons.add,
                        color: Colors.green,
                        size: 24,
                      ),
                      onTap: () {},
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: InkWell(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.green,
                          size: 24,
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
