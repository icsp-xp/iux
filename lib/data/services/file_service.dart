import 'dart:io';

abstract class FileService {
  final File _file;

  FileService(this._file);

  Future<void> create() => _file.create(recursive: true);

  Future<String?> readAsString() async {
    if (!_file.existsSync()) {
      return null;
    }

    return await _file.readAsString();
  }

  Future<void> writeAsString(String content) => _file.writeAsString(content);
}
