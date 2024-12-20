import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key, required this.email});
  final String email;

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late Box notesBox;

  @override
  void initState() {
    super.initState();
    openBox();
  }

  Future<void> openBox() async {
    await Hive.initFlutter();
    notesBox = await Hive.openBox('${widget.email}_notes');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        title: Text(
          // 'My Notes (${widget.email})',
          'My Notes ',

          style: const TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: notesBox.isOpen
          ? ValueListenableBuilder(
              valueListenable: notesBox.listenable(),
              builder: (context, box, _) {
                if (box.isEmpty) {
                  return const Center(
                    child: Text(
                      'No notes added yet.',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final note = box.getAt(index);
                    return ListTile(
                      title: Text(
                        note['title'] ?? 'Untitled Note',
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        note['content'] ?? '',
                        style: const TextStyle(color: Colors.grey),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          box.deleteAt(index);
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NoteEditor(
                              note: note,
                              index: index,
                              email: widget.email,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteEditor(email: widget.email),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class NoteEditor extends StatefulWidget {
  final Map<String, dynamic>? note;
  final int? index;
  final String email;

  const NoteEditor({this.note, this.index, required this.email, super.key});

  @override
  State<NoteEditor> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late Box notesBox;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?['title']);
    _contentController = TextEditingController(text: widget.note?['content']);
    openBox();
  }

  Future<void> openBox() async {
    notesBox = await Hive.openBox('${widget.email}_notes');
    setState(() {});
  }

  void saveNote() {
    final note = {
      'title': _titleController.text,
      'content': _contentController.text,
      'createdAt': DateTime.now().toIso8601String(),
    };
    if (widget.index != null) {
      notesBox.putAt(widget.index!, note);
    } else {
      notesBox.add(note);
    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text('Edit Note', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: Colors.white),
            onPressed: saveNote,
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
            Expanded(
              child: TextField(
                controller: _contentController,
                style: const TextStyle(color: Colors.white),
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Write your note here...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
