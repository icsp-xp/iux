import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

class FakeDirectory extends Fake implements Directory {
  final String _path;

  FakeDirectory(this._path);

  @override
  String get path => _path;
}
