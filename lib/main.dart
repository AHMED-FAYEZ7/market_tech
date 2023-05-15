import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_tech/shared/bloc_observer.dart';
import 'package:market_tech/shared/componants/constants.dart';
import 'package:market_tech/shared/cubit/cubit.dart';
import 'package:market_tech/shared/cubit/states.dart';
import 'package:market_tech/shared/network/local/cache_helper.dart';
import 'package:market_tech/shared/network/remote/dio_helper.dart';
import 'package:market_tech/shared/styles/theme.dart';

import 'layout/shop_layout.dart';
import 'modules/login/login_screen.dart';
import 'modules/on_boarding/on_boarding_screen.dart';

void main() {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      DioHelper.init();
      await CacheHelper.init();
      Widget? widget;
      bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
      if (onBoarding != null) {
        if (token != null) {
          widget = const ShopLayout();
        } else {
          widget = LoginScreen();
        }
      } else {
        widget = OnBoardingScreen();
      }
      runApp(MyApp(widget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp(this.startWidget);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()
        ..getHomeData()
        ..getCategories()
        ..getFavorites()
        ..getProfile(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
