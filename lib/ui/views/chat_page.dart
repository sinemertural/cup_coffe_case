import 'package:cup_coffe_case/ui/widgets/reusable_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart' hide ChatState, TextMessage;
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:cup_coffe_case/ui/cubit/chat_cubit.dart';
import 'package:cup_coffe_case/data/state/chat_state.dart';
import 'package:cup_coffe_case/core/theme/app_colors.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final chatCubit = context.read<ChatCubit>();
      chatCubit.loadChatHistory().then((_) {
        if (chatCubit.state is ChatInitial || 
            (chatCubit.state is ChatLoaded && (chatCubit.state as ChatLoaded).messages.isEmpty)) {
          chatCubit.sendMessage('merhaba');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<ChatCubit>().clearChat(); //reset chat
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            ReusableAppBar(title: "Live Support", onBackPressed: (){
              Navigator.pop(context);
            },
            textColor: Colors.black,
            iconColor: Colors.black,
            ),
            Expanded(child:
            BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChatLoaded) {
                  final messages = state.messages.reversed.map((msg) => TextMessage(
                    author: User(
                      id: msg.isUser ? 'user' : 'bot',
                      firstName: msg.isUser ? 'Siz' : 'Destek',
                    ),
                    id: msg.id,
                    text: msg.text,
                    createdAt: msg.timestamp.millisecondsSinceEpoch,
                  )).toList();

                  return Chat(
                    messages: messages,
                    onSendPressed: (text) {
                      context.read<ChatCubit>().sendMessage(text.text);
                    },
                    user: const User(id: 'user'),
                    theme: DefaultChatTheme(
                      primaryColor: Colors.black45,
                      backgroundColor: Colors.grey[50]!,
                      inputBackgroundColor: Colors.white,
                      inputTextColor: Colors.black,
                    ),
                  );
                } else if (state is ChatError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, size: 64, color: Colors.red[300]),
                        const SizedBox(height: 16),
                        Text(
                          state.message,
                          style: TextStyle(color: Colors.red[600]),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }
                return const Center(
                  child: Text(
                    'Hoş geldiniz! Size nasıl yardımcı olabilirim?',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              },
            ),)
          ],
        )
      ),
    );
  }
}