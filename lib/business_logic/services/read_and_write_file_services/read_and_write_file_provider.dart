import 'dart:io';

import 'package:path_provider/path_provider.dart';

class ReadAndWriteFileProvider {
  Future<String> get _localPath async {
    final Directory directory = await getApplicationDocumentsDirectory();

    return '${directory.path}/flash_note';
  }

  Future<File> _localFile(String fileName) async {
    final String path = await _localPath;
    final Directory subFolder = Directory(path);
    if (!(await subFolder.exists())) {
      subFolder.create();
    }
    return File('$path/$fileName');
  }

  Future<File> writeCounter(String fileName, String content) async {
    final File file = await _localFile(fileName);

    // Write the file
    return file.writeAsString(content);
  }

  Future<String> readCounter(String fileName) async {
    try {
      final File file = await _localFile(fileName);

      // Read the file
      final String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return e.toString();
    }
  }

  Future<List<FileSystemEntity>> getListFile() async {
    try {
      final Directory directory = Directory(await _localPath);

      return directory.listSync();
    } catch (e) {
      // If encountering an error, return 0
      throw Exception(e);
    }
  }
}
