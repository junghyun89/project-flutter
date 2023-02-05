import 'package:flutter/material.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          onPressed: () {
            AuthMethods().signOut();
          },
          icon: const Icon(Icons.exit_to_app),
        ),
      ),
    );
  }
}
