import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final List<_Msg> _messages = [
    const _Msg(sender: 'Support Assistant', text: 'Welcome, I am your virtual assistant.'),
    const _Msg(sender: 'Support Assistant', text: 'How can I help you today?'),
  ];

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF14C996);
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        centerTitle: true,
        title: const Text('Online Support', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
        actions: [IconButton(icon: const Icon(Icons.notifications_outlined, color: Colors.black), onPressed: () {})],
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: Color(0xFFE8F5F1), borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (_, i) => _bubble(_messages[i]),
              ),
            ),
            _composer(primary),
          ],
        ),
      ),
    );
  }

  Widget _bubble(_Msg m) {
    final isUser = m.sender == 'You';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isUser ? const Color(0xFF14C996) : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          m.text,
          style: TextStyle(color: isUser ? Colors.white : Colors.black87),
        ),
      ),
    );
  }

  Widget _composer(Color primary) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.photo_camera_outlined)),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(hintText: 'Write Here...', border: InputBorder.none),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(onPressed: _send, icon: const Icon(Icons.send)),
        ],
      ),
    );
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_Msg(sender: 'You', text: text));
    });
    _controller.clear();
    // TODO: integrate with chat API
  }
}

class _Msg {
  final String sender;
  final String text;
  const _Msg({required this.sender, required this.text});
}
