# newsapi

A Dart package for newsapi.org. An API Key from newsapi.org is required to use this package. Get one for free at newsapi.org

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.


Getting started:
- Get an API key from: https://newsapi.org
Simple usage:

```dart
  import 'package:dart_newsapi/dartnewsapi.dart';
  NewsAPI newsAPI = new NewsAPI('YOUR-API-KEY-HERE');

  newsAPI.topHeadlines({'country': 'no'}).then((List<Article> articles) {
    print(articles.first.source.name);
  });

  newsAPI.sources({}).then((List<Source> sources) {
    print(sources.first.name);
  });
```