import 'package:flutter/material.dart';

import 'package:notes_app/models/note.dart';
import 'package:notes_app/pages/form_page.dart';
import 'package:notes_app/utils/notes_database.dart';

class DetailPage extends StatefulWidget {
  final Note note;
  const DetailPage({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Note note;

  Future refreshNote() async {
    note = await NotesDatabase.instance.readNote(widget.note.id!);
    setState(() {});
  }

  @override
  void initState() {
    note = widget.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FormPage(
                    note: widget.note,
                  ),
                ),
              );

              refreshNote();
            },
            icon: const Icon(Icons.edit),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () async {
              await NotesDatabase.instance.delete(widget.note.id!);
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.delete),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView(
          children: [
            Card(
              child: Text(
                note.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              note.description,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
