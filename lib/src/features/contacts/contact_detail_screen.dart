import "dart:convert";
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart'; // Import go_router
import 'package:orbit/src/core/database.dart'; // Re-add this import for generated types
import 'package:orbit/src/features/capture/capture_provider.dart'; // Import providers

// Provider to fetch a single contact by ID
final contactDetailProvider = FutureProvider.family<ContactsTableData?, int>((ref, contactId) async {
  final contactRepo = ref.watch(contactRepositoryProvider);
  return contactRepo.getContactById(contactId);
});

// Provider to fetch notes for a specific contact
final contactNotesProvider = FutureProvider.family<List<NotesTableData>, int>((ref, contactId) async {
  final noteRepo = ref.watch(noteRepositoryProvider);
  return noteRepo.getNotesForContact(contactId);
});

class ContactDetailScreen extends ConsumerWidget {
  final int contactId;
  const ContactDetailScreen({super.key, required this.contactId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactAsync = ref.watch(contactDetailProvider(contactId));
    final notesAsync = ref.watch(contactNotesProvider(contactId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Details'),
      ),
      body: contactAsync.when(
        data: (contact) {
          if (contact == null) {
            return const Center(child: Text('Contact not found.'));
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${contact.name}', style: Theme.of(context).textTheme.headlineSmall),
                Text('Created At: ${contact.createdAt.toLocal().toString().split(' ')[0]}'),
                Text('Last Interaction: ${contact.lastInteractionDate?.toLocal().toString().split(' ')[0] ?? 'N/A'}'),
                Text('Relationship Score: ${contact.relationshipScore}'),
                const SizedBox(height: 20),
                Text('Notes:', style: Theme.of(context).textTheme.headlineSmall),
                notesAsync.when(
                  data: (notes) {
                    if (notes.isEmpty) {
                      return const Text('No notes for this contact.');
                    }
                    return Expanded(
            const SizedBox(height: 20),
            Text("AI Profile Data:", style: Theme.of(context).textTheme.headlineSmall),
            if (contact.aiProfileData != null && contact.aiProfileData!.isNotEmpty) ...[
              Builder(
                builder: (context) {
                  final profile = jsonDecode(contact.aiProfileData!);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Family: ${profile["family"]?.join(", ") ?? "N/A"}"),
                      Text("Interests: ${profile["interests"]?.join(", ") ?? "N/A"}"),
                      Text("Events: ${profile["events"]?.map((e) => e["description"]).join(", ") ?? "N/A"}"),
                    ],
                  );
                },
              ),
            ] else Text("No AI data available."),
                      child: ListView.builder(
                        itemCount: notes.length,
                        itemBuilder: (context, index) {
                          final note = notes[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(note.content),
                                  Text('Date: ${note.date.toLocal().toString().split(' ')[0]}', style: Theme.of(context).textTheme.bodySmall),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  loading: () => const CircularProgressIndicator(),
                  error: (err, stack) => Text('Error loading notes: $err'),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/contacts/$contactId/capture'); // Navigate to capture screen for this contact
        },
        child: const Icon(Icons.note_add),
      ),
    );
  }
}
