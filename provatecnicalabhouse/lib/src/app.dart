/// TODO: Modificar rutes
import 'package:flutter/material.dart';
import 'package:provatecnicalabhouse/src/utils/context_helper.dart';
import 'config/app_localizations.dart';
import 'config/app_styles.dart';
import 'config/globals.dart';
import 'config/routes/navigator_router.dart';
import 'config/routes/navigator_routes.dart';
import 'config/app_localizations.dart';

class HangeGPT extends StatefulWidget {

  final String firstScreen;

  HangeGPT({required String this.firstScreen});

  @override
  _HangeGPTState createState() => _HangeGPTState();

}

class _HangeGPTState extends State<HangeGPT> {

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        navigatorKey: ContextHelper.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Hange GPT',
        theme: AppStyles.mainTheme,
        initialRoute: widget.firstScreen,
        onGenerateRoute: AppRouter.generateRoute,
        ///Aixó ho comento pq és per a les localizations
        // localizationsDelegates: [
        //   AppLocalizationsDelegate(),
        //   FallbackCupertinoLocalisationsDelegate(),
        // ],
        // supportedLocales: [
        //   const Locale('es'),
        //   // const Locale('en'),
        //   const Locale('ca'),
        // ],
      )
    );

  }

}
