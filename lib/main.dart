// MAD Lab #
// Date: 11/16/2021
// Website: https://codelabs.developers.google.com/codelabs/flutter#0

import 'package:flutter/cupertino.dart'; // iOS icon
import 'package:flutter/foundation.dart'; // Theme
import 'package:flutter/material.dart';

// Simplifying the main() method enables hot reload
// because hot reload doesn't rerun main().
void main() {
  runApp(
    // The home argument specifies the default screen that users see in your app.
    // In this case, it consists of a Scaffold widget that has a simple AppBar as its child widget.
    // This is typical for a Material app.
    FriendlyChatApp(),
  );
}

// specifies colors for iOS
final ThemeData kIOSTheme = ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

// specifies colors for Android
final ThemeData kDefaultTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
      .copyWith(secondary: Colors.orangeAccent[400]),
);

String _name = 'Hesper';

class FriendlyChatApp extends StatelessWidget {
  const FriendlyChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FriendlyChat',
      theme: defaultTargetPlatform == TargetPlatform.iOS
          ? kIOSTheme
          : kDefaultTheme,
      home: const ChatScreen(),
    );
  }
}

// Implement a chat message list
class ChatMessage extends StatelessWidget {
  const ChatMessage({
    required this.text,
    required this.animationController,
    Key? key,
  }) : super(key: key);

  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                  child: Text(_name[0])), // Get the initial of name for avatar
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_name, style: Theme.of(context).textTheme.headline4),
                  Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Text(text),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Press Alt+Enter (Linux and Windows) to bring up a menu
// From the menu, select Convert to StatefulWidget
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override

  // Prefixing an identifier with an underscore (_)
// makes the identifier private to its library
  State<ChatScreen> createState() => _ChatScreenState();
}

// Use the AnimationController class to specify how the animation should run
class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  // a List member called _messages to represent each chat message
  final List<ChatMessage> _messages = [];
  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isComposing = false; // if input field is blank, hide the send button

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    var message = ChatMessage(
      text: text,
      animationController: AnimationController(
        duration:
            const Duration(milliseconds: 700), // specifies animation's runtime
        vsync:
            this, // source of heartbeats (the Ticker) that drives the animation forward
        // this vsync adds a TickerProviderStateMixin mixin to the _ChatScreenState class definition
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
    _focusNode.requestFocus();
    // animation play forward whenever a message is added to the chat list
    message.animationController.forward();
  }

  @override
  // dispose animation controller of ChatMessage to free up resources
  void dispose() {
    for (var message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Dart supports single or double quotation marks,
        // but prefers single quotation marks
        // unless the text already contains a single quotation mark.
        title: const Text('FriendlyChat'),
        // The elevation property defines the z-coordinates of the AppBar
        // A z-coordinate value of 4.0 has a defined shadow (Android),
        // and a value of 0.0 has no shadow (iOS).
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, index) => _messages[index],
                itemCount: _messages.length,
              ),
            ),
            const Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child:
                  _buildTextComposer(), // to display the text input user control
            ),
          ],
        ),
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey[200]!),
                ),
              )
            : null,
      ),
    );
  }

  // a method that returns a widget that encapsulates the text input field
  Widget _buildTextComposer() {
    return Container(
      // adds a horizontal margin
      // between the edge of the screen and each side of the input field
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      // Using a Row allows you to place the Send button
      // adjacent to the input field
      child: Row(
        // The children property takes a list, rather than a single widget
        children: [
          // TextField() is a widget, thus putting it inside [] convert it to a list
          // Wrapping the TextField in a Flexible widget tells the Row to automatically size the text field
          // to use the remaining space that isn't used by the button
          Flexible(
            child: TextField(
              controller: _textController,
              onChanged: (text) {
                setState(() {
                  _isComposing = text.isNotEmpty;
                });
              },
              // The onSubmitted property was also modified
              // so that it won't add an empty string to the message list
              onSubmitted: _isComposing ? _handleSubmitted : null,
              decoration:
                  const InputDecoration.collapsed(hintText: 'Send a message'),
              focusNode: _focusNode,
            ),
          ),
          // Add the Send button
          // Then wrap with IconTheme widget
          IconTheme(
            data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Theme.of(context).platform == TargetPlatform.iOS
                  ? // MODIFIED
                  CupertinoButton(
                      // NEW
                      child: const Text('Send'), // NEW
                      onPressed: _isComposing // NEW
                          ? () => _handleSubmitted(_textController.text) // NEW
                          : null,
                    )
                  // MODIFIED
                  : IconButton(
                      icon: const Icon(Icons.send),
                      // controls the behavior and the visual appearance of the Send button
                      onPressed: _isComposing
                          ? () => _handleSubmitted(_textController.text)
                          : null,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
