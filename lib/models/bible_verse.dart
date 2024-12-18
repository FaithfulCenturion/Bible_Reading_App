class Verse {
  final String book;
  final int chapter;
  final int verseNumber;
  final String text;

  Verse({
    required this.book,
    required this.chapter,
    required this.verseNumber,
    required this.text,
  });

  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      book: json['book'],
      chapter: json['chapter'],
      verseNumber: json['verse_number'],
      text: json['text'],
    );
  }
}
