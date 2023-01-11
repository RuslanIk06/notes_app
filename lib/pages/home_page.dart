import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/pages/form_page.dart';
import 'package:notes_app/utils/notes_database.dart';
import 'package:notes_app/widgets/card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [
    Note(
        id: 1,
        title: "Belajar",
        description: 'Belajar Flutter',
        time: DateTime.now()),
    Note(
        id: 2,
        title: "Belajar",
        description: 'Belajar Flutter',
        time: DateTime.now()),
    Note(
        id: 3,
        title: "Belajar",
        description: 'Belajar Flutter',
        time: DateTime.now()),
    Note(
        id: 4,
        title: "Belajar",
        description: 'Belajar Flutter',
        time: DateTime.now()),
  ];

  bool isLoading = false;

  Future refreshNote() async {
    setState(() {
      isLoading = true;
    });

    notes = await NotesDatabase.instance.readAllNotes();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    refreshNote();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    NotesDatabase.instance.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Notes"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FormPage(),
            ),
          );
          refreshNote();
        },
        child: const Icon(Icons.note_add_outlined),
      ),
    );
  }
}
