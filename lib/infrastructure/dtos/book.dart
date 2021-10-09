class Book {
  final String id;

  final Uri? selfLink;

  final String title;

  final List<String> authors;

  final String publisher;

  final String description;

  final List<String> categories;

  final double averageRating;

  final int ratingsCount;

  final String image;

  final String language;

  const Book({
    required this.id,
    required this.selfLink,
    required this.title,
    required this.authors,
    required this.publisher,
    required this.description,
    required this.categories,
    required this.averageRating,
    required this.ratingsCount,
    required this.image,
    required this.language,
  });

  static Book fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'];

    return Book(
      id: json['id'],
      selfLink: Uri.parse(json['selfLink']),
      title: volumeInfo['title'] ?? '',
      authors: volumeInfo['authors'] != null
          ? volumeInfo['authors'].cast<String>()
          : [],
      publisher: volumeInfo['publisher'] ?? '',
      description: volumeInfo['description'] ?? '',
      categories: volumeInfo['categories'] != null
          ? volumeInfo['categories'].cast<String>()
          : [],
      averageRating: ((volumeInfo['averageRating'] ?? 0) as num).toDouble(),
      ratingsCount: volumeInfo['ratingsCount'] ?? 0,
      image: volumeInfo['imageLinks'] != null
          ? volumeInfo['imageLinks']['thumbnail']
          : "",
      language: volumeInfo['language'] ?? '',
    );
  }
}
