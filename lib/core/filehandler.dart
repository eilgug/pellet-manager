import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pellet_manager/models/appdata.dart';

class FileHandler {
  static File? _file;
  static const _fileNameAppData = 'appData.json';

  FileHandler._privateConstructor();

  static final FileHandler instance = FileHandler._privateConstructor();

  Future<File> get file async {
    if (_file != null) return _file!;

    _file = await _initFile();
    return _file!;
  }

  Future<File> _initFile() async {
    final _directory = await getApplicationDocumentsDirectory();
    final _path = _directory.path;

    return File('$_path/$_fileNameAppData');
  }

  Future<void> writeAppData(AppData appData) async {
    final File fl = await file;
    await fl.writeAsString(jsonEncode(appData.toJson()));
  }

  Future<AppData> readAppData() async {
    final File fl = await file;
    final _content = await fl.readAsString();

    final AppData appData = AppData.fromJson(jsonDecode(_content));
    return appData;
  }
}
