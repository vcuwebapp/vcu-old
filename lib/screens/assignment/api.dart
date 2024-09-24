import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as Path;


class PDFApi {
  static Future<File> loadNetwork(String url) async {

    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;

    return _storeFile(url, bytes);

  }

  static Future<File> _storeFile(String url, List<int>bytes) async {
      final filename = Path.basename(url);
      final dir = await getApplicationDocumentsDirectory();

      final file = File('${dir.path}/$filename');
      await file.writeAsBytes(bytes, flush: true);
      return file;
  }
}

