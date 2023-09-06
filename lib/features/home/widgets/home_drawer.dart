import 'package:flutter/material.dart';
import 'package:flutter_anime_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                await ref
                    .read(authControllerProvider.notifier)
                    .signOut(context);
              },
              child: Text("Sign Out"),
            ),
          ],
        ),
      ),
    );
  }
}
