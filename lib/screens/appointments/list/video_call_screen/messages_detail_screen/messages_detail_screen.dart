import 'dart:convert';

import 'package:doctorq/models/appointments_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../app_export.dart';
import '../../../../../data_files/chat_list.dart';
import '../../../../../models/chat_model.dart';
import '../../../../../widgets/bkBtn.dart';
import '../../../../../widgets/spacing.dart';
import 'widgets/chat_list.dart';
import 'package:pubnub/pubnub.dart';

// ignore: must_be_immutable
class MessagesDetailScreen extends StatefulWidget {
  AppointmentsModel appointment;
  late String uId;
  final String user;
  MessagesDetailScreen({Key? key, required this.user, required this.appointment}) : super(key: key) {

    Map<String, dynamic> userData = jsonDecode(user);
    uId = userData[
        'user_id']; // Assuming 'user_Id' is the correct key in your JSON
  }

  @override
  State<MessagesDetailScreen> createState() => _MessagesDetailScreenState();
}

class _MessagesDetailScreenState extends State<MessagesDetailScreen> {
  late PubNub pubnub;
//  late CameraController controller;
  var count = 0;
  var channel;
  var last_msg = '';
  final FocusNode myFocusNode = FocusNode();

  void Toast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg), // Explicitly casting r to String
        //    'Response Content: ${r}'), // Provide an empty string as a fallback

        duration: const Duration(seconds: 2),
        showCloseIcon: true,
      ),
    );
  }

  Future<void> sendPub(String text) async {
    myFocusNode.unfocus();
    await pubnub.publish('Channel-Barcelona', text);

    await Future.delayed(const Duration(milliseconds: 100));
    scrollDown();
    scrollDown();

    // Channel abstraction for easier usage
    //channel = pubnub.channel('Channel-Barcelona');
  }

  Future<void> initPubNub() async {

    // Initialize PubNub instance
    pubnub = PubNub(
      defaultKeyset: Keyset(
        subscribeKey: 'sub-c-f5659372-2568-4f19-bc2a-be6a5dbe4d65',
        publishKey: 'pub-c-9d2c07d1-d4b6-403b-b0c3-def8a944666e',
        userId: UserId(widget.uId),
      ),
    );

    // Subscribe to a channel
    var subscription =
        pubnub.subscribe(channels: {'Channel-Barcelona'}); // Corrected syntax

    // Listen for messages
    subscription.messages.listen((envelope) {

      setState(() {
        // Ensure setState is called to update the UI
        chatList.add(ChatModel(
          msg: envelope.content.toString(),
          isMine: widget.uId == envelope.uuid.toString(),
        ));

        textEditingController.clear();
      });

      // Scroll to the end after a short delay to allow UI to update
      Future.delayed(const Duration(milliseconds: 100)).then((_) {
        scrollDown();
      });
    });

    // Fetch historical messages
    var history2 = pubnub.channel('Channel-Barcelona').history(chunkSize: 100);
    await history2.more();

    // Clear existing messages and add historical ones
    setState(() {
      chatList.clear();
      for (var message in history2.messages) {
        //BaseMessage
        //      bool isMine = message.userMeta["userId"] == widget.uId;

        chatList.add(ChatModel(
          msg: message.content.toString(),
//            isMine: widget.uId == message. .uuid.toString(),
          isMine: !message.content
              .toString()
              .contains('{'), // Set isMine appropriately
        ));
      }
      scrollDown(); // Scroll to the end after adding historical messages
    });
  }

  @override
  void initState() {
    initPubNub();

    super.initState();
  }

  TextEditingController textEditingController = TextEditingController();
  final ScrollController _controller = ScrollController();
  void scrollDown() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    //scrollDown();
    //scrollDown();
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    bool isRtl = context.locale == Constants.arLocal;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: size.width,
              margin: getMargin(top: 26, bottom: 10),
              child: Padding(
                padding: getPadding(
                  left: 24,
                  right: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        const BkBtn(),
                        HorizontalSpace(width: 20),
                        Text(
                          widget.appointment.name,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: getFontSize(
                              26,
                            ),
                            fontFamily: 'Source Sans Pro',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            VerticalSpace(height: 20),
            Container(
              height: getVerticalSize(100),
              margin: getMargin(
                left: 20,
                right: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  getHorizontalSize(
                    12.00,
                  ),
                ),
                border: Border.all(
                  color: ColorConstant.bluegray50,
                  width: getHorizontalSize(
                    1.00,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: getSize(
                      100.00,
                    ),
                    width: getSize(
                      100.00,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            getHorizontalSize(
                              12.00,
                            ),
                          ),
                          bottomLeft: Radius.circular(
                            getHorizontalSize(
                              12.00,
                            ),
                          ),
                        ),
                        child: CommonImageView(
                          imagePath: widget.appointment.img,
                          height: getSize(
                            100.00,
                          ),
                          width: getSize(
                            100.00,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  HorizontalSpace(width: 20),
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  widget.appointment.name,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: getFontSize(
                                      16,
                                    ),
                                    fontFamily: 'Source Sans Pro',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: getPadding(
                                    top: 3,
                                  ),
                                  child: Text(
                                    widget.appointment.time,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: getFontSize(
                                        14,
                                      ),
                                      fontFamily: 'Source Sans Pro',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            VerticalSpace(height: 20),
            Expanded(
                child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              controller: _controller,
              padding: getPadding(left: 20, right: 20),
              itemCount: chatList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ChatListWidget(
                  index: index,
                );
              },
              separatorBuilder: (context, index) => VerticalSpace(height: 20),
            )),
            Padding(
              padding: getPadding(top: 20, bottom: 20, left: 20, right: 20),
              child: TextFormField(
                focusNode: myFocusNode,
                controller: textEditingController,
                onFieldSubmitted: (val) {
                  sendPub(val);
                  /*setState(() {
                    //chatList.add(ChatModel(msg: val, isMine: true));
                    
                    scrollDown();
                    textEditingController.clear();
                  });*/
                },
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.top,
                maxLines: null,
                decoration: InputDecoration(
                    hintText: 'Type a message${widget.uId}',
                    hintStyle: TextStyle(
                        color: const Color(0xFFA5ABB3),
                        fontFamily: 'Source Sans Pro',
                        fontWeight: FontWeight.w400,
                        fontSize: getFontSize(16)),
                    contentPadding: getPadding(
                        bottom: 24,
                        top: 24,
                        left: isRtl ? 0 : 24,
                        right: isRtl ? 24 : 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          24.00,
                        ),
                      ),
                      borderSide: BorderSide(
                        color: ColorConstant.bluegray50,
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: isDark
                        ? ColorConstant.darkTextField
                        : ColorConstant.whiteA700,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          24.00,
                        ),
                      ),
                      borderSide: BorderSide(
                        color: ColorConstant.blueA400,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          24.00,
                        ),
                      ),
                      borderSide: BorderSide(
                        color: ColorConstant.bluegray50,
                        width: 2,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          24.00,
                        ),
                      ),
                      borderSide: BorderSide(
                        color: ColorConstant.bluegray50,
                        width: 2,
                      ),
                    ),
                    suffixIconConstraints: BoxConstraints(
                        maxHeight: getVerticalSize(36),
                        maxWidth: getHorizontalSize(60)),
                    suffixIcon: Padding(
                      padding: getPadding(
                          left: isRtl ? 24 : 0, right: isRtl ? 0 : 24),
                      child: InkWell(
                          onTap: () {
                            //setState(() {
                            sendPub(textEditingController.text);

                            //});
                            /*Future.delayed(Duration(seconds: 7), () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LightAppointmentsListMessagingEndedScreen(
                                          appointment: widget.appointment,
                                          contactMethod: ContactMethods.message,
                                        )),
                              );
                            });*/
                          },
                          child: Image.asset(ImageConstant.send)),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
