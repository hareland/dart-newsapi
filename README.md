# dart_newsapi

A Dart package for newsapi.org. An API Key from newsapi.org is required to use this package. Get one for free at newsapi.org

## Getting Started
- Get an API key from: https://newsapi.org

## Simple usage:

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