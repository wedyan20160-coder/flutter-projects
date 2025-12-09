import 'package:flutter/material.dart';

void main() {
  runApp(const MyLike());
}

class MyLike extends StatelessWidget {
  const MyLike({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Like Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PostsScreen(),
    );
  }
}

class LikeButton extends StatefulWidget {
  final bool initialIsLiked;

  const LikeButton({
    super.key,
    this.initialIsLiked = false,
  });

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late bool _isLiked;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.initialIsLiked;
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isLiked ? Icons.favorite : Icons.favorite_border,
        color: _isLiked ? Colors.red : Colors.grey,
        size: 24,
      ),
      onPressed: _toggleLike,
    );
  }
}

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Posts')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: const [
          PostItem(title: 'نص المنشور الأول'),
          PostItem(title: 'نص المنشور الثاني', isLiked: true),
          PostItem(title: 'نص المنشور الثالث'),
          PostItem(title: 'نص المنشور الرابع'),
        ],
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  final String title;
  final bool isLiked;

  const PostItem({
    super.key,
    required this.title,
    this.isLiked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        title: Text(title),
        trailing: LikeButton(initialIsLiked: isLiked),
      ),
    );
  }
}