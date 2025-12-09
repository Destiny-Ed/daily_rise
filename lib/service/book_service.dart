import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class Book {
  final String title;
  final String author;
  final String id;
  final String coverUrl;
  final String epubUrl;

  Book({required this.title, required this.author, required this.id, required this.coverUrl, required this.epubUrl});
}

class BookService {
  static const String baseUrl = "https://gutendex.com/books";

  static Future<List<Book>> search(String query) async {
    if (query.trim().isEmpty) return [];

    final url = Uri.parse("$baseUrl?search=${Uri.encodeQueryComponent(query)}");
    final response = await http.get(url);

    if (response.statusCode != 200) return [];

    final data = json.decode(response.body);
    final results = data['results'] as List;

    return results.map((json) {
      final formats = json['formats'] as Map<String, dynamic>;
      final epubUrl = formats['application/epub+zip'] ?? formats['text/html'] ?? '';
      final coverUrl = json['formats']['image/jpeg'] ?? '';

      return Book(
        title: json['title'] ?? "Unknown Title",
        author: (json['authors'] as List).isNotEmpty ? json['authors'][0]['name'] ?? "Unknown" : "Unknown",
        id: json['id'].toString(),
        coverUrl: coverUrl,
        epubUrl: epubUrl,
      );
    }).toList();
  }

  static Future<String?> downloadBook(String url, String title) async {
    if (url.isEmpty) return null;

    try {
      final dir = await getApplicationDocumentsDirectory();
      final safeTitle = title.replaceAll(RegExp(r'[^\w\s]'), '').replaceAll(' ', '_');
      final filePath = "${dir.path}/$safeTitle.epub";

      await Dio().download(url, filePath);
      return filePath;
    } catch (e) {
      return null;
    }
  }
}