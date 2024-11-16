import 'package:flutter/material.dart';

class FindContactList extends StatelessWidget implements PreferredSizeWidget {
  static const String routeName = 'find_contact';
  const FindContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Contact'),
      ),
      body: const Placeholder(),

    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
