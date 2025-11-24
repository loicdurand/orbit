import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:orbit/src/services/contact_repository.dart'; // Import ContactRepository
import 'package:orbit/src/core/database.dart'; // Import AppDatabase and generated types
import 'package:orbit/src/features/capture/capture_provider.dart'; // Import appDatabaseProvider

// Define a provider for ContactRepository, similar to how NoteRepository is provided
final contactRepositoryProvider = Provider((ref) {
  return ContactRepository(ref.watch(appDatabaseProvider));
});

// Provider to fetch all contacts
final contactsProvider = FutureProvider<List<ContactsTableData>>((ref) async {
  final contactRepo = ref.watch(contactRepositoryProvider);
  return contactRepo.getAllContacts();
});

class ContactListScreen extends ConsumerWidget {
  const ContactListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsAsync = ref.watch(contactsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: contactsAsync.when(
        data: (contacts) {
          if (contacts.isEmpty) {
            return const Center(child: Text('No contacts yet.'));
          }
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return ListTile(
                title: Text(contact.name),
                subtitle: Text('Last interaction: ${contact.lastInteractionDate?.toLocal().toString().split(' ')[0] ?? 'N/A'}'),
                onTap: () {
                  context.push('/contacts/${contact.id}'); // Navigate to contact detail
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}