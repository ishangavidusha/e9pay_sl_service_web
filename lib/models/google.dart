import 'package:googleapis/serviceconsumermanagement/v1.dart';

// ignore: non_constant_identifier_names
final CREDENTIAL = ServiceAccountConfig.fromJson(
  {
    "web":{
        "client_id":"231252319349-9orf1hmo9m77ci6bbaatu0lma3dk52fm.apps.googleusercontent.com",
        "project_id":"e9pass-cs","auth_uri":"https://accounts.google.com/o/oauth2/auth",
        "token_uri":"https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":"https://www.googleapis.com/oauth2/v1/certs",
        "client_secret":"bLq_KbMeLmSdJz3C_XOEaJ6A",
        "redirect_uris":["https://e9pass-cs.firebaseapp.com/__/auth/handler"],
        "javascript_origins":["http://localhost","http://localhost:5000","https://e9pass-cs.firebaseapp.com"]
    }
  }
);