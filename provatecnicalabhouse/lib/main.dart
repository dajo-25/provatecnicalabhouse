import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provatecnicalabhouse/src/app.dart';
import 'package:provatecnicalabhouse/src/config/routes/navigator_routes.dart';
import 'package:provatecnicalabhouse/src/provider/results_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  String _firstScreen = NavigatorRoutes.home;

  ///Precachejo els assets de la primera screen, que sino tarda molt en carregar i queda lleig.
  // await Future.wait([
  //   precachePicture(
  //     ExactAssetPicture(
  //         SvgPicture.svgStringDecoderBuilder, AppAssets.starCircleCut),
  //     null,
  //   ),
  // ]);

  /// Ens assegurem que l'app sempre es mostri en PORTRAIT.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]).then((_) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    runApp(MultiProvider(providers: [
      ChangeNotifierProvider<ResultsProvider>(
        create: (_) => ResultsProvider(),
      ),
    ], child: HangeGPT(firstScreen: _firstScreen)));
  });
}
