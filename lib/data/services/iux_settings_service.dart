import 'package:iux/data/services/file_service.dart';
import 'package:path_provider/path_provider.dart';

final class IuxSettingsService extends FileService {
  IuxSettingsService(super.iuxSettingsFile);

  Future<String> getDefaultProjectsDirPath() async =>
      (await getApplicationDocumentsDirectory()).path;
}
