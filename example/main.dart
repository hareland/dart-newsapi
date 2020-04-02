import 'package:dart_newsapi/dartnewsapi.dart';


void main(){
  NewsAPI newsAPI = new NewsAPI('YOUR-API-KEY-HERE');

  newsAPI.topHeadlines({'country': 'no'}).then((List<Article> articles) {
    print(articles.first.source.name);
  });

  newsAPI.sources({}).then((List<Source> sources) {
    print(sources.first.name);
  });
}