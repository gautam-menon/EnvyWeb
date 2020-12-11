import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:envyweb/Models/OrderModel.dart';
import 'package:envyweb/Models/UserModel.dart';
import 'package:envyweb/Screens/Editor/OrderPage.dart';
import 'package:envyweb/Services/ApiFunctions%20-Admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';

class OrderChat extends StatefulWidget {
  OrderChat({this.orderid, this.user, @required this.userId});
  final String orderid;
  final String userId;
  final UserModel user;
  @override
  _OrderChatState createState() => _OrderChatState();
}

class _OrderChatState extends State<OrderChat> {
  Stream<QuerySnapshot> chatList;
  TextEditingController messageEditingController;

  Widget chatMessages() {
    return Flexible(
      child: StreamBuilder(
        stream: chatList,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  reverse: true,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    QueryDocumentSnapshot snapShot =
                        snapshot.data.documents[index];
                    String chatUserID = snapShot.get('sendBy');
                    bool isMedia = snapShot.get('type') == 'media';
                    return (chatUserID == widget.user.uid)
                        ? isMedia
                            ? getMediaLayout(
                                ChatBubbleClipper2(
                                  type: BubbleType.sendBubble,
                                ),
                                context,
                                snapShot,
                                userData: true,
                              )
                            : getSenderView(
                                ChatBubbleClipper2(
                                  type: BubbleType.sendBubble,
                                ),
                                context,
                                snapShot.get('message'),
                              )
                        : isMedia
                            ? getMediaLayout(
                                ChatBubbleClipper1(
                                  type: BubbleType.receiverBubble,
                                ),
                                context,
                                snapShot,
                                userData: false,
                                showShareOption: true,
                              )
                            : getReceiverView(
                                ChatBubbleClipper1(
                                  type: BubbleType.receiverBubble,
                                ),
                                context,
                                snapShot.get('message'));
                  },
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  @override
  void initState() {
    messageEditingController = TextEditingController();
    getChats(
      widget.orderid,
    ).then((val) {
      setState(() {
        chatList = val;
      });
    });
    super.initState();
  }

  Widget getPlanText(String planID) {
    String plan = '';
    switch (planID) {
      case '1':
        plan = 'Plan: Basic';
        break;
      case '2':
        plan = 'Plan: Premium';
        break;
      case '3':
        plan = 'Plan: Professional';
        break;
      default:
    }
    return Text(
      plan,
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  getTitleText(String title) => Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      );

  Widget getMediaLayout(
    CustomClipper clipper,
    BuildContext context,
    QueryDocumentSnapshot data, {
    bool userData = true,
    bool showShareOption = false,
  }) {
    var order = json.decode(data.get('message'));
    var orderObj = Order.fromJson(order);
    var imgURL = userData ? orderObj.editedBase64: orderObj.rawBase64;
    var tier = orderObj.tierId;
    //   var isPaymentPending = orderObj.paymentStatus == OrderStatus.Pending.status;
    var image = Image.network(
      imgURL,
      fit: BoxFit.fitHeight,
    );
    return ChatBubble(
      clipper: clipper,
      alignment: userData ? Alignment.topRight : Alignment.topLeft,
      margin: EdgeInsets.only(top: 20),
      //backGroundColor: isPaymentPending ? Colors.red[600] : Colors.blue,
      child: GestureDetector(
        onTap: () async {
          // await locator<NavigationService>().navigateTo(
          //   chatMediaViewPath,
          //   arguments: [
          //     orderObj,
          //     showShareOption,
          //   ],
          // );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(),
            Icon(
              Icons.verified,
              color: Colors.white,
            ),
            Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  child: image,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: getPlanText(
                    tier,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  getSenderView(CustomClipper clipper, BuildContext context, String message) =>
      ChatBubble(
        clipper: clipper,
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: 20),
        backGroundColor: Colors.blue,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  getReceiverView(
          CustomClipper clipper, BuildContext context, String message) =>
      ChatBubble(
        clipper: clipper,
        alignment: Alignment.centerLeft,
        backGroundColor: Color(0xffE7E7ED),
        margin: EdgeInsets.only(top: 20),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.black),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Chat',
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          chatMessages(),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: messageEditingController,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(50.0),
                          ),
                          borderSide: BorderSide.none),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      filled: true,
                    ),
                  )),
                  SizedBox(
                    width: 8.0,
                  ),
                  InkWell(
                    onTap: () async {
                      if (await prepMessage(
                        widget.userId,
                        messageEditingController.text,
                        uniqueIdText: widget.orderid,
                      )) {
                        messageEditingController.clear();
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(40)),
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderPage(
                                    orderId: widget.orderid,
                                    editorId: widget.user.uid,
                                    uid: widget.userId,
                                  )));
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(40)),
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> prepMessage(
    String uid,
    String messageString, {
    String mediaType: 'text',
    String uniqueIdText: '',
  }) async {
    var clearText = false;
    if (messageString.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        'sendBy': widget.user.uid,
        'message': messageString,
        'time': DateTime.now().millisecondsSinceEpoch.toString(),
        'type': mediaType,
        'uniqueId': uniqueIdText,
      };
      await _addMessage(
          uniqueIdText, chatMessageMap, widget.user, uid, messageString);
      clearText = true;
    }
    return clearText;
  }

  Future _addMessage(String chatRoomId, chatMessageData, UserModel user,
      String uid, String message) async {
    await FirebaseFirestore.instance
        .collection('WorkOrderChats')
        .doc(chatRoomId)
        .collection('chats')
        .add(chatMessageData)
        .then((value) async => await ApiFunctionsAdmin()
            .sendNotificationtoUser(user.name, uid, message));
  }

  getChats(String orderId) async {
    return FirebaseFirestore.instance
        .collection('WorkOrderChats')
        .doc(orderId)
        .collection('chats')
        .orderBy('time', descending: true)
        .snapshots();
  }
}
