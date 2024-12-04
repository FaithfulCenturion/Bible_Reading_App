import 'package:bible_reader_app/screens/bible/chapter_text_screen.dart';
import 'package:flutter/material.dart';

class BibleChapterScreen extends StatelessWidget {
  final String bookId;
  final String bookName;
  final List<Map<String, dynamic>> chapters;

  const BibleChapterScreen({
    super.key,
    required this.bookId,
    required this.bookName,
    required this.chapters,
  });

  @override
  Widget build(BuildContext context) {
    int calculateCrossAxisCount(int totalItems) {
      const int minCount = 3;
      const int maxCount = 5;

      // Return minCount if totalItems is less than minCount
      if (totalItems <= minCount) {
        return minCount;
      }

      // If totalItems is divisible by any number in range, pick it
      for (int i = maxCount; i >= minCount; i--) {
        if (totalItems % i == 0) {
          return i;
        }
      }

      // Otherwise, return the closest count within range
      return totalItems < maxCount ? totalItems : maxCount;
    }

    int crossAxisCount = calculateCrossAxisCount(chapters.length);

    return Scaffold(
      appBar: AppBar(title: Text('Chapters in $bookName')),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount, // Number of tiles per row
          crossAxisSpacing: 10, // Horizontal space between tiles
          mainAxisSpacing: 10, // Vertical space between tiles
        ),
        padding: const EdgeInsets.all(10), // Padding around the grid
        itemCount: chapters.length,
        itemBuilder: (context, index) {
          final chapter = chapters[index];

          String chapterId = chapter['id'];
          String chapterNumber = chapterId.split('.')[1];
          String displayText;

          if (chapterNumber.toLowerCase() == 'intro') {
            displayText = 'Intro';
          } else {
            displayText = 'Ch. $chapterNumber';
          }

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChapterTextScreen(
                    bookName: bookName,
                    chapterId: chapterId,
                  ),
                ),
              );
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blueAccent, // Background color of each tile
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
              child: Text(
                displayText,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          );
        },
      ),
    );
  }
}
