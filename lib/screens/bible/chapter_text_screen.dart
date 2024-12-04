import 'package:bible_reader_app/services/bible_service.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html_parser;

class ChapterTextScreen extends StatelessWidget {
  final String bookName;
  final String chapterId;

  const ChapterTextScreen({
    required this.bookName,
    required this.chapterId,
    super.key,
  });

  String parseHtml(String htmlString) {
    final document = html_parser.parse(htmlString);
    return document.body?.text ?? 'No content available';
  }

  @override
  Widget build(BuildContext context) {
    String chapterTitle = '';
    if (chapterId.split('.')[1] == 'intro') {
      chapterTitle = 'Intro';
    } else {
      chapterTitle = 'Ch. ${chapterId.split('.')[1]}';
    }

    return Scaffold(
      appBar: AppBar(title: Text('$bookName: $chapterTitle')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: BibleService.fetchText(chapterId), // Call the service function
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading spinner while fetching data
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Show error message if fetching data fails
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Show a message if no data is available
            return const Center(
              child: Text('No verses available for this chapter.'),
            );
          }

          // Build a list of verses if data is fetched successfully
          final verses = snapshot.data!;
          return ListView.builder(
            itemCount: verses.length,
            itemBuilder: (context, index) {
              final verse = verses[index];
              final verseId = verse['id']; // Always present
              final verseParts = verseId.split('.');
              final verseNumber =
                  verseParts.isNotEmpty ? verseParts.last : 'Unknown';
              return ListTile(
                leading: Text(
                  verseNumber, // Display verse ID
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  parseHtml(verse['text'])
                      .replaceFirst(
                        RegExp(
                            r'^\d+\s*'), // Match the verse number (digits) at the start of the text, followed by optional spaces
                        '', // Remove the number and any spaces
                      )
                      .trim(), // Trim any leading or trailing spaces
                ), // Render the HTML text content Html(style: {
              );
            },
          );
        },
      ),
    );
  }
}
