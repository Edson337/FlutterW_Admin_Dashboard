import 'package:fluro/fluro.dart';

import '../ui/views/no_page_found.dart';

class NoPageFoundHandlers {
  static Handler noPageFound = Handler(
      handlerFunc: (context, params) {
        return const NoPageFoundView();
      }
  );
}