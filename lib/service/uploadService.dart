import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

class UploadService {
  final String initUrl = 'http://35.226.43.228';
  Future<Map<String, dynamic>> uploadData(FilePickerResult filePickerResult, String name, String phoneNumber) async {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('$initUrl/upload'));
    request.files.add(
      http.MultipartFile.fromBytes(
        'file', 
        filePickerResult.files.single.bytes,
        filename: filePickerResult.files.single.name,
        contentType: MediaType('video', filePickerResult.files.single.extension),
      )
    );
    request.fields.addAll(
      {
        "name" : name.trim().replaceAll(new RegExp(r"\s+"), ""),
        "phone" : phoneNumber.trim(),
      }
    );
    request.headers.addAll(
      {
        "Access-Control-Allow-Origin" : "*",
        HttpHeaders.contentTypeHeader : "multipart/form-data",
      }
    );
    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        String result = await response.stream.bytesToString();
        Map<String, dynamic> resultMap = jsonDecode(result);
        print(resultMap["fileInfos"]);
        return {
          "result" : true,
          "fileName" : initUrl + '/files/' + resultMap["fileInfos"],
        };
      } else {
        print(response.statusCode);
        return {
          "result" : false,
          "msg" : await response.stream.bytesToString()
        };
      }
    } catch (e) {
      print(e.toString());
      return {
        "result" : false,
        "msg" : e.toString()
      };
    }
    
  }
}