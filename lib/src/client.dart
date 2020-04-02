import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart';
import './model/Article.dart';
import './model/Source.dart';

/// This module provides access to the News API
/// https://newsapi.org/
///
/// Author: Kristian Hareland
///
/// The API provides access to recent news headlines
/// from many popular news sources.
///
/// The author of this code has no formal relationship with NewsAPI.org and does not
/// claim to have created any of the facilities provided by NewsAPI.org.
class NewsAPI {
  final String _apiKey;
  String _host = 'https://newsapi.org';

  List<String> _allowedQueryParameters = [
    'q',
    'country',
    'category',
    'sources',
    'pageSize',
    'page'
  ];

  ///NewsAPI Constructor.
  NewsAPI(this._apiKey) {
    if (_apiKey.isEmpty) {
      throw new Exception("NewsAPI: Missing required API Key.");
    }
  }

  Future<List<Article>> topHeadlines(Map<String, dynamic> options) async {
    Response response = await _fetch(
      _createUrlFromEndpointAndOptions('/v2/top-headlines', options),
      options,
    );

    return _transformResponseToArticleList(response);
  }

  Future<List<Article>> everything(Map<String, dynamic> options) async {
    Response response = await _fetch(
      _createUrlFromEndpointAndOptions('/v2/everything', options),
      options,
    );

    return _transformResponseToArticleList(response);
  }

  Future<List<Source>> sources(Map<String, dynamic> options) async {
    Response response = await _fetch(
      _createUrlFromEndpointAndOptions('/v2/sources', options),
      options,
    );

    return _transformResponseToSourceList(response);
  }

  String _createUrlFromEndpointAndOptions(
      String endpoint, Map<String, dynamic> options) {
    Uri hostUri = Uri.parse(_host);
    List<String> pathSegments = hostUri.pathSegments.toList();

    //Remove empty segments from the endpoint
    endpoint.split('/').forEach((String s) {
      if (s.isNotEmpty) pathSegments.add(s);
    });

    Uri finalUri = Uri(
        scheme: hostUri.scheme,
        host: hostUri.host,
        port: hostUri.port,
        pathSegments: pathSegments,
        queryParameters: _getQueryParameters(options));
    return finalUri.toString();
  }

  Map<String, dynamic> _getQueryParameters(Map<String, dynamic> options) {
    Map<String, dynamic> out = {};

    options.forEach((String k, value) {
      if (_allowedQueryParameters.indexOf(k) != -1) {
        out[k] = value;
      }
    });

    return out;
  }

  ///Simply fetch data from a URL
  Future<Response> _fetch(String url, Map<String, dynamic> options) async {
    return await get(url, headers: _getHeaders(options));
  }

  ///Create headers for the request based on options and API Key
  Map<String, String> _getHeaders(Map<String, dynamic> options) {
    Map<String, String> headers = {};
    if (options.containsKey('noCache') && options['noCache'] == true) {
      headers['X-No-Cache'] = 'true';
    }

    if (_apiKey.isNotEmpty) {
      headers['X-Api-Key'] = _apiKey;
    }

    return headers;
  }

  List<Article> _transformResponseToArticleList(Response response) {
    if (response.statusCode != 200) {
      throw new Exception(
          "NewsAPI: Response from $_host did not return HTTP 200 OK.");
    }

    Map decoded = json.decode(response.body);

    //Simple validation of response
    if (!decoded.containsKey('status') ||
        !decoded.containsKey('totalResults') ||
        !decoded.containsKey('articles')) {
      throw new Exception(
          "NewsAPI: Missing either: status, totalResults or articles from response body.");
    }

    //Handle actual transformation
    return (decoded['articles'] as List)
        .map((article) => Article.fromMap(article))
        .toList();
  }

  List<Source> _transformResponseToSourceList(Response response) {
    if (response.statusCode != 200) {
      throw new Exception(
          "NewsAPI: Response from $_host did not return HTTP 200 OK.");
    }

    Map decoded = json.decode(response.body);

    if (!decoded.containsKey('status') || !decoded.containsKey('sources')) {
      throw new Exception(
          "NewsAPI: Missing either: status or sources from response body.");
    }

    return (decoded['sources'] as List)
        .map((source) => Source.fromMap(source))
        .toList();
  }
}
