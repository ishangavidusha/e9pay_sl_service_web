
import 'package:file_picker/file_picker.dart';

class FileService {

  static Future<FilePickerResult> getFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );
    if(result != null) {
    return result;
    } else {
      return null;
    }
  }
}