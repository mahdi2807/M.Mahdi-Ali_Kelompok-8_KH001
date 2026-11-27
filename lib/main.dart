import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'widgets/app_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Praktikum 2',
      theme: AppTheme.light,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Ganti dengan nama kamu
        title: const Text('Demo Aplikasi Mahdi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppButton(
              label: 'Buka GitHub',
              icon: Icons.code,
              url: 'https://github.com/mahdi2807',
            ),
            const SizedBox(height: 16),
            AppButton(
              label: 'Sapa',
              icon: Icons.waving_hand,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Halo dari Praktikum 2!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
