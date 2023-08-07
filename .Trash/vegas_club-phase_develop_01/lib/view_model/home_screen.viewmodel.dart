import 'package:fast_i18n_flutter/fast_i18n_flutter.dart';

class HomeScreenViewModel extends ChangeNotifier {
  int page = 0;

  void changePage(int indexPage) {
    page = indexPage;
    notifyListeners();
  }
}
