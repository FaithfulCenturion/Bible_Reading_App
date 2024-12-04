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
          'Bible Books',
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
          // FutureBuilder for Bible Books
          FutureBuilder<List<Map<String, dynamic>>>(
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
                return SizedBox(
                  height: 500, // Set your desired height
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Number of tiles per row
                      crossAxisSpacing: 10, // Horizontal space between tiles
                      mainAxisSpacing: 10, // Vertical space between tiles
                    ),
                    padding:
                        const EdgeInsets.all(10), // Padding around the grid
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];
                      // Null safety with fallback values
                      final bookId = book['id']?.toString() ?? 'Unknown ID';
                      final bookName = book['name'] ?? 'Unknown Book';

                      return GestureDetector(
                        onTap: () async {
                          if (bookId == 'Unknown ID') {
                            // Handle invalid data scenario
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
                            // Navigate to chapters page or fetch chapters
                            final chapters =
                                await BibleService.fetchChapters(bookId);
                            Navigator.pop(
                                context); // Dismiss the loading indicator
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
                            Navigator.pop(
                                context); // Dismiss the loading indicator
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
                            color: const Color.fromRGBO(43, 120, 255,
                                1), // Background color of each tile
                            borderRadius:
                                BorderRadius.circular(8), // Rounded corners
                          ),
                          child: Text(
                            bookName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
