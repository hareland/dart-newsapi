import 'Source.dart';

class Article {
  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;
  final String content;

  Article(
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  );

  factory Article.fromMap(Map art) {
    return Article(
      Source.fromMap(art['source']),
      art['author'],
      art['title'],
      art['description'],
      art['url'],
      art['urlToImage'],
      DateTime.parse(art['publishedAt']),
      art['content'],
    );
  }
}
