import 'dart:io';

import 'read_and_write_file_provider.dart';

class ReadAndWriteFileRepository {
  final ReadAndWriteFileProvider _provider = ReadAndWriteFileProvider();

  Future<void> writeData(String fileName, String fileContent) async {
    await _provider.writeCounter(fileName, fileContent);
  }

  Future<String> readData(String fileName) async {
    try {
      return await _provider.readCounter(fileName);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<FileSystemEntity>> getData() async {
    try {
      return await _provider.getListFile();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteData(String fileName) async {
    await _provider.deleteData(fileName);
  }
}
