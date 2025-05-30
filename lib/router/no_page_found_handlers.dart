import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import '../providers/sidemenu_provider.dart';
import '../ui/views/no_page_found.dart';

class NoPageFoundHandlers {
  static Handler noPageFound = Handler(handlerFunc: (context, params) {
    Provider.of<SideMenuProvider>(context!, listen: false).setCurrentPageUrl('/404');
    return const NoPageFoundView();
  });
}