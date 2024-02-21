import 'read_and_write_file_provider.dart';

class ReadAndWriteFileRepository {
  final ReadAndWriteFileProvider provider = ReadAndWriteFileProvider();

  Future<void> writeData(String fileName, String fileContent) async {
    await provider.writeCounter(fileName, fileContent);
  }

  Future<String> readData(String fileName) async {
    try {
      return await provider.readCounter(fileName);
    } catch (e) {
      rethrow;
    }
  }
}
