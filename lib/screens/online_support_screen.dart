import 'package:flutter/material.dart';
import 'chat_screen.dart';

class OnlineSupportScreen extends StatelessWidget {
  const OnlineSupportScreen({Key? key}) : super(key: key);

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
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text('Active Chats', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _chatTile(context, title: 'Support Assistant', subtitle: "Hello! I'm here to assist you", trailing: '2 Min Ago'),
            const SizedBox(height: 20),
            const Text('Ended Chats', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _chatTile(context, title: 'Help Center', subtitle: 'Your account is ready to use…', trailing: 'Feb 08 - 2024'),
            _chatTile(context, title: 'Support Assistant', subtitle: 'Hello! I\'m here to assist you', trailing: 'Dec 24 - 2023'),
            _chatTile(context, title: 'Support Assistant', subtitle: 'Hello! I\'m here to assist you', trailing: 'Sep 10 - 2023'),
            _chatTile(context, title: 'Help Center', subtitle: 'Hi, how are you today?', trailing: 'June 12 - 2023'),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatScreen())),
                style: ElevatedButton.styleFrom(backgroundColor: primary, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                child: const Text('Start Another Chat', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chatTile(BuildContext context, {required String title, required String subtitle, required String trailing}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(color: Color(0xFF14C996), shape: BoxShape.circle),
            child: const Icon(Icons.support_agent, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.black54)),
            ]),
          ),
          Text(trailing, style: const TextStyle(color: Colors.black45, fontSize: 12)),
        ],
      ),
    );
  }
}
