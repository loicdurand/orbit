import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:orbit/src/core/router.dart'; // Import GoRouter

void main() {
  runApp(
    const ProviderScope( // Wrap the app with ProviderScope
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget { // Change to ConsumerWidget for Riverpod
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) { // Add WidgetRef
    final router = ref.watch(routerProvider); // Use the routerProvider

    return MaterialApp.router( // Use MaterialApp.router for GoRouter
      title: 'Orbit',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router, // Assign the router configuration
    );
  }
}
