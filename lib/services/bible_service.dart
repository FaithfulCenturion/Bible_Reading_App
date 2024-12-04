import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class BibleService {
  static const String _apiUrl = 'https://api.scripture.api.bible/v1/bibles';
  static const String _apiKey =
      '1a14c920bfecedd77101aa0b6c9dc2b2'; // My API key
  static const String _bibleId =
      'de4e12af7f28f599-01'; //ID for KJV with Apocrypha
  //'685d1470fe4d5c3b-01';  ID for ASV with Apocrypha

  /// Fetches the KJV Bible with Apocrypha
  static Future<List<Map<String, dynamic>>> fetchBibleBooks() async {
    final url = '$_apiUrl/$_bibleId/books';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
          'api-key': _apiKey,
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final books = data['data'] as List;

        // Return the list of books
        return books
            .map((book) => {
                  'id': book['id'],
                  'name': book['name'],
                })
            .toList();
      } else {
        throw Exception(
            'Failed to fetch books: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error fetching Bible books: $e');
    }
  }

  //Fetches chapters of the selected book
  static Future<List<Map<String, dynamic>>> fetchChapters(String bookId) async {
    final url = '$_apiUrl/$_bibleId/books/$bookId/chapters';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'accept': 'application/json',
          'api-key': _apiKey,
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final chapters = data['data'] as List;

        return chapters
            .map((chapter) => {
                  'id': chapter['id'],
                  'name': chapter['name'],
                })
            .toList();
      } else {
        throw Exception(
            'Failed to fetch chapters: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error fetching chapters: $e');
    }
  }

  //Fetches chapter text for the selected chapter
  static Future<List<Map<String, dynamic>>> fetchText(String chapterId) async {
    final chapterUrl = '$_apiUrl/$_bibleId/chapters/$chapterId/verses';
    try {
      final chapterResponse = await http.get(
        Uri.parse(chapterUrl),
        headers: {
          'accept': 'application/json',
          'api-key': _apiKey,
        },
      );
      if (chapterResponse.statusCode == 200) {
        final chapterData = json.decode(chapterResponse.body);
        final verses = chapterData['data'] as List;

        // Fetch full text for each verse sequentially
        final List<Map<String, dynamic>> fullTextVerses = [];
        for (final verse in verses) {
          final verseId = verse['id'];
          final verseText = await _fetchVerseText(verseId);
          if (verseText != null) {
            fullTextVerses.add({
              'id': verseId,
              'name': verse['name'],
              'text': verseText,
            });
          }
        }

        return fullTextVerses;
      } else {
        throw Exception(
            'Failed to fetch verses: ${chapterResponse.statusCode} - ${chapterResponse.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error fetching verses: $e');
    }
  }

  // Helper function to fetch individual verse text
  static Future<String?> _fetchVerseText(String verseId) async {
    final verseUrl = '$_apiUrl/$_bibleId/verses/$verseId';
    try {
      final verseResponse = await http.get(
        Uri.parse(verseUrl),
        headers: {
          'accept': 'application/json',
          'api-key': _apiKey,
        },
      );

      if (verseResponse.statusCode == 200) {
        final verseData = json.decode(verseResponse.body);
        return verseData['data']['content']; // Adjust based on API response
      } else {
        throw Exception(
            'Failed to fetch verse text: ${verseResponse.statusCode} - ${verseResponse.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching verse $verseId: $e');
      return null;
    }
  }

  // New method to fetch today's reading plan
  static Future<List<String>> fetchTodaysReadingPlanFromHive() async {
    final box = await Hive.openBox('bibleReadingBox');
    final readingPlan = box.get('todayReadingPlan') as List<String>?;

    if (readingPlan == null || readingPlan.isEmpty) {
      return []; // Return an empty list if no plan is found
    }
    return readingPlan;
  }
}
