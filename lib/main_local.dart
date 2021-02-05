import 'package:cresce_flutter_app/app.dart';
import 'package:flutter/material.dart';

void main() {
  print('running in local mode');
  print('make sure to run web server:');
  print('docker run -d -p 5000:80 --name cresce.api alienengineer/cresce');

  runApp(makeApp(
    webApiUrl: 'http://10.0.2.2:5000',
  ));
}
