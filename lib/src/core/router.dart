import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbit/src/features/contacts/contact_list_screen.dart';
import 'package:orbit/src/features/contacts/contact_detail_screen.dart';
import 'package:orbit/src/features/capture/capture_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/contacts', // Set initial route to contact list
    routes: <RouteBase>[
      GoRoute(
        path: '/contacts',
        builder: (BuildContext context, GoRouterState state) {
          return const ContactListScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: ':contactId', // e.g., /contacts/123
            builder: (BuildContext context, GoRouterState state) {
              final contactId = int.parse(state.pathParameters['contactId']!);
              return ContactDetailScreen(contactId: contactId);
            },
            routes: [
              GoRoute(
                path: 'capture', // e.g., /contacts/123/capture
                builder: (BuildContext context, GoRouterState state) {
                  final contactId = int.parse(state.pathParameters['contactId']!);
                  return CaptureScreen(contactId: contactId);
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
