import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbit/src/core/database.dart'; // Import AppDatabase and generated types
import 'package:orbit/src/features/capture/capture_provider.dart';
import 'package:orbit/src/features/contacts/contact_detail_screen.dart'; // Import to use contactDetailProvider

class CaptureScreen extends ConsumerWidget {
  final int contactId;
  const CaptureScreen({super.key, required this.contactId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noteContent = ref.watch(captureStateProvider);
    final captureStateNotifier = ref.read(captureStateProvider.notifier);
    final contactAsync = ref.watch(contactDetailProvider(contactId));

    return Scaffold(
      appBar: AppBar(
        title: contactAsync.when(
          data: (ContactsTableData? contact) => Text('Note for ${contact?.name ?? '...'}'),
          loading: () => const Text('Loading...'),
          error: (err, stack) => const Text('Error'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter your note',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              onChanged: (value) => captureStateNotifier.setNoteContent(value),
              controller: TextEditingController(text: noteContent),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final contact = contactAsync.value;
                if (contact != null) {
                  await captureStateNotifier.saveNote(noteContent, selectedContact: contact);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Note saved!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Error: Contact not found.')),
                  );
                }
              },
              child: const Text('Save Note'),
            ),
          ],
        ),
      ),
    );
  }
}
