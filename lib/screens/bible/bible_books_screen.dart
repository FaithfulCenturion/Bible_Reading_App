import 'package:bible_reader_app/screens/bible/bible_chapter_screen.dart';
import 'package:flutter/material.dart';
import '../../services/bible_service.dart'; // Import the service

class BibleBooksScreen extends StatefulWidget {
  const BibleBooksScreen({super.key});

  @override
  _BibleBooksScreenState createState() => _BibleBooksScreenState();
}

class _BibleBooksScreenState extends State<BibleBooksScreen> {
  late Future<List<Map<String, dynamic>>> _bibleBooks;

  @override
  void initState() {
    super.initState();
    _bibleBooks = BibleService.fetchBibleBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(43, 120, 255, 1),
        title: Text(
          'KJV with Apocrypha',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.home, color: Colors.white),
          onPressed: () {
            Navigator.pop(
                context); // Go back to the previous screen (home screen)
          },
        ),
      ),
      body: Column(
  children: [
    Expanded(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: _bibleBooks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'An error occurred while fetching the books.',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.book, size: 48, color: Colors.grey),
                SizedBox(height: 16),
                Text('No books found.'),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _bibleBooks = BibleService.fetchBibleBooks();
                    });
                  },
                  child: Text('Retry'),
                ),
              ],
            );
          } else {
            final books = snapshot.data!;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              padding: const EdgeInsets.all(10),
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                final bookId = book['id']?.toString() ?? 'Unknown ID';
                final bookName = book['name'] ?? 'Unknown Book';

                return GestureDetector(
                  onTap: () async {
                    if (bookId == 'Unknown ID') {
                      print('Error: Book ID is null or invalid');
                      return;
                    }
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) =>
                          Center(child: CircularProgressIndicator()),
                    );
                    try {
                      final chapters = await BibleService.fetchChapters(bookId);
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BibleChapterScreen(
                            bookId: bookId,
                            bookName: bookName,
                            chapters: chapters,
                          ),
                        ),
                      );
                    } catch (e) {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Error'),
                          content: Text(e.toString()),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(43, 120, 255, 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      bookName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    ),
  ],
),
    );
  }
}
