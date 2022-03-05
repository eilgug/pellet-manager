import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pellet_manager/models/appdata.dart';

class FileHandler {
  static File? _file;
  static const _fileNameAppData = 'appData.json';

  FileHandler._privateConstructor();

  // Singleton
  static final FileHandler instance = FileHandler._privateConstructor();

  Future<File> get file async {
    if (_file != null) return _file!;

    _file = await _initFile();
    return _file!;
  }

  // create first instance of the file
  Future<File> _initFile() async {
    final _directory = await getApplicationDocumentsDirectory();
    final _path = _directory.path;

    File fl = await File('$_path/$_fileNameAppData');

    // check if file already exist
    await fl.exists().then((exist) async {
      // if NOT exist create the file and write in initial data
      if (!exist) {
        AppData appData =
            AppData(stock: 0, average: 0, userLoads: [], userOrders: []);
        await fl
            .create()
            .then((_fl) => _fl.writeAsString(jsonEncode(appData.toJson())));
      }
    });

    return fl;
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
