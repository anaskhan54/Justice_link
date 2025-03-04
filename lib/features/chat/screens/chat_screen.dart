import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:justice_link/features/auth/services/auth_service.dart';
import 'package:justice_link/features/chat/widgets/chat_widgets.dart';
import 'package:justice_link/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:justice_link/models/meeting.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({Key? key, this.meeting}) : super(key: key);
  final Meeting? meeting;
  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  late IO.Socket socket;
  final ScrollController _scrollController = ScrollController();
  final List<Message> _messageList = [
    const Message(
        content: "Hi, Bill! This is the simplest example ever.",
        ownerType: OwnerType.sender,
        ownerName: "Higor Lapa"),
  ];
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    connectToServer();
  }

  void connectToServer() {
    socket = IO.io('$uri', <String, dynamic>{
      'transports': ['websocket'],
      'autoconnect': false,
    });
    socket.connect();
    socket.on('connect', (_) {
      print('Connected to server');
    });
    socket.on(
      'message',
      (data) {
        if (!mounted) {
          return;
        }
        final user = ref.read(userProvider);
        final lawyer = ref.read(lawyerProvider);
        final message;
        if (user == null) {
          if ((data)['userId'] == lawyer!.id) {
            message = Message(
                content: data['message'],
                ownerType: OwnerType.sender,
                ownerName: lawyer.name);
          } else {
            message = Message(
              content: data['message'],
              ownerType: OwnerType.receiver,
              ownerName: lawyer.name,
            );
          }
        } else {
          if ((data)['userId'] == user.id) {
            message = Message(
                content: data['message'],
                ownerType: OwnerType.sender,
                ownerName: user.name);
          } else {
            message = Message(
              content: data['message'],
              ownerType: OwnerType.receiver,
              ownerName: user.name,
            );
          }
        }

        _messageList.add(message);
        if (mounted) {
          setState(
            () {},
          );
        }
      },
    );
  }

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final user = ref.read(userProvider);
    // final lawyer = ref.read(lawyerProvider);
    // connectToServer(user,lawyer);
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text("Chat Bot"),
        centerTitle: true,
        elevation: 5,
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF098904),
        shadowColor: const Color.fromARGB(255, 72, 73, 72),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                // connectToServer();
              },
              icon: const Icon(
                Icons.call,
                color: Colors.white,
              ),
            ),
          ),
        ],
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Color(0xFF046200)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatList(
              scrollController: _scrollController,
              children: _messageList,
            ),
          ),
          widget.meeting != null
              ? widget.meeting?.meetingStatus == 'pending'
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _textEditingController,
                                  decoration: const InputDecoration(
                                    hintText: 'Type a message...',
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.photo),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.send),
                                onPressed: () {
                                  _sendMessage(_textEditingController.text);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _textEditingController,
                              decoration: const InputDecoration(
                                hintText: 'Type a message...',
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.photo),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              _sendMessage(_textEditingController.text);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
    socket.disconnect();
  }

  void _sendMessage(String text) {
    final user = ref.read(userProvider);
    final lawyer = ref.read(lawyerProvider);
    if (text.isNotEmpty) {
      Map<String, dynamic> data = {
        'userId': user?.id ?? lawyer?.id,
        'message': text,
      };
      socket.emit('message', data);
      _textEditingController.clear();

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    }
  }
}
