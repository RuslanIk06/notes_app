import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/widgets/card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [
    Note(1, 'Belajar', 'Belajar Flutter', DateTime.now()),
    Note(2, 'Belajar', 'Belajar Flutter', DateTime.now()),
    Note(3, 'Belajar', 'Belajar Flutter', DateTime.now()),
    Note(4, 'Belajar', 'Belajar Flutter', DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Notes"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: notes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
          itemBuilder: (context, index) {
            return CardWidget(index: index, notes: notes[index]);
          },
        ),
      ),
    );
  }
}
