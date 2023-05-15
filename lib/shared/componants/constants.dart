import 'package:market_tech/modules/login/login_screen.dart';
import 'package:market_tech/shared/network/local/cache_helper.dart';

import 'componants.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      navigateAndFinish(context, LoginScreen());
    }
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token = CacheHelper.getData(key: 'token');
