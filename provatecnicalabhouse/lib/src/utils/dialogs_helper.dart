import 'package:flutter/material.dart';
import 'package:provatecnicalabhouse/src/config/app_styles.dart';
import 'package:provatecnicalabhouse/src/config/routes/navigator_routes.dart';
import 'package:provatecnicalabhouse/src/provider/results_provider.dart';
import 'package:provider/provider.dart';

import '../config/app_colors.dart';

class DialogsHelper {
  static void showLoaderDialog({required BuildContext context}) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColors.primary,
            strokeWidth: 7,
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showInfoDialog({required BuildContext context}) {
    AlertDialog alert = AlertDialog(
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: AppColors.blue,
            ))
      ],
      backgroundColor: Colors.white,
      elevation: 0,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "¿Cómo funciona Hange GPT?",
            maxLines: 2,
            overflow: TextOverflow.fade,
            style:
                AppStyles.textTheme.titleLarge?.copyWith(color: AppColors.blue),
          ),
          Text(
            "\nHange es un anciano aventurero que ha recorrido el mundo con el afán de recopilar toda clase de datos y poder así elaborar ránkings y colecciones de todo tipo. \n¿Tienes algo que preguntar a Hange? ¡Adelante! \n\nTen en cuenta que Hange es muy mayor, y tiene mucha información que consultar, por lo que suele tardar bastantes segundos (hasta un minuto) en encontrar una respuesta a tu pregunta.\n\nEn la parte inferior de la caja de texto podrás escojer entre Hange y Jinn. Jinn és el nieto de Hange. Aventurero, tambíen, pero mucho más inexperto. Puede responder más rápido a tus dudas, pero de manera más imprecisa y vaga.",
            overflow: TextOverflow.fade,
            style:
                AppStyles.textTheme.bodySmall?.copyWith(color: AppColors.blue),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: true,
      barrierColor: Colors.black12,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showHistoryDialog({required BuildContext context}) {
    List<Widget> children = [];

    if (Provider.of<ResultsProvider>(context, listen: false).pastResults !=
        null) {
      children = children
        ..addAll(Provider.of<ResultsProvider>(context, listen: false)
            .pastResults!
            .entries
            .map((e) => GestureDetector(
          onTap: () {
            Provider.of<ResultsProvider>(context, listen: false).fetchResults(prompt: e.key.split(".")[0], pastResults: e.value);
            Navigator.pushNamed(context, NavigatorRoutes.results);
          },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.blue.withOpacity(0.3)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(e.key.split(".")[0]),
                        Text("Primer resultado: ${e.value.first.title}"),
                      ],
                    )),
              ),
            )));
    }

    AlertDialog alert = AlertDialog(
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: AppColors.blue,
            ))
      ],
      backgroundColor: Colors.white,
      elevation: 0,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              "Historial de consultas:",
              maxLines: 2,
              overflow: TextOverflow.fade,
              style: AppStyles.textTheme.titleLarge
                  ?.copyWith(color: AppColors.blue),
            ),
          ),
          SizedBox(
            height: 230,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: true,
      barrierColor: Colors.black12,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
