import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Book Library',
      debugShowCheckedModeBanner: false,
      home: LibraryPage(),
    );
  }
}

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final List<Map<String, String>> _books = [
    {'title': 'The Alchemist', 'author': 'Paulo Coelho'},
    {'title': '1984', 'author': 'George Orwell'},
    {'title': 'Rich Dad Poor Dad', 'author': 'Robert Kiyosaki'},
  ];

  void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void showAddBookDialog(BuildContext context) {
    final titleController = TextEditingController();
    final authorController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Book"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Book Title",
                  hintText: "e.g. Atomic Habits",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: authorController,
                decoration: const InputDecoration(
                  labelText: "Author",
                  hintText: "e.g. James Clear",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                String title = titleController.text.trim();
                String author = authorController.text.trim();

                if (title.isNotEmpty && author.isNotEmpty) {
                  setState(() {
                    _books.add({'title': title, 'author': author});
                  });
                  Navigator.pop(context);
                  showSnackBar(context, "Book added!");
                } else {
                  showSnackBar(context, "Please fill all fields");
                }
              },
              child: const Text("Add"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Library"),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            onPressed: () => showSnackBar(context, "Settings Clicked"),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Center(
                child: Text(
                  "Library Menu",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () => showSnackBar(context, "Home Clicked"),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("About"),
              onTap: () => showSnackBar(context, "About Clicked"),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Books in Your Library",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _books.length,
                itemBuilder: (context, index) {
                  final book = _books[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.book),
                      title: Text(book['title']!),
                      subtitle: Text("by ${book['author']}"),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => showAddBookDialog(context),
              icon: const Icon(Icons.add),
              label: const Text("Add Book"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
