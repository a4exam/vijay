import 'package:flutter/foundation.dart';

class IndexProvider with ChangeNotifier {
  int _indexsolution = 0;

  int get indexsolution => _indexsolution;

  void updateIndex(int newIndex) {
    _indexsolution = newIndex;
    notifyListeners();
  }
}
