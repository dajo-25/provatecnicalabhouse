import 'package:flutter/material.dart';
import 'package:provatecnicalabhouse/src/api/request_provider.dart';
import 'package:provatecnicalabhouse/src/config/app_colors.dart';
import 'package:provatecnicalabhouse/src/config/app_styles.dart';
import 'package:provatecnicalabhouse/src/config/assets.dart';
import 'package:provatecnicalabhouse/src/config/routes/navigator_routes.dart';
import 'package:provatecnicalabhouse/src/models/explorers.dart';
import 'package:provatecnicalabhouse/src/provider/results_provider.dart';
import 'package:provatecnicalabhouse/src/ui/widgets/moving_gradient_circle.dart';
import 'package:provatecnicalabhouse/src/utils/dialogs_helper.dart';
import 'package:provatecnicalabhouse/src/utils/snackbar_helper.dart';
import 'package:provider/provider.dart';

import '../../config/globals.dart';
import '../../models/Result.dart';
import '../widgets/result_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _promptTextController = TextEditingController();
  late ResultsProvider _resultsProvider;

  var _flurryballs = [MovingGradientCircle(color: AppColors.coolGreen, size: 25000, velocityCap:2 + 2,),
    MovingGradientCircle(color: AppColors.coolGreen, size: 400, velocityCap:2 + 3,),
    MovingGradientCircle(color: AppColors.coolBlue, size: 200, velocityCap:2 + 2,),
    MovingGradientCircle(color: AppColors.coolGreen, size: 200, velocityCap:2 + 2,),
    MovingGradientCircle(color: AppColors.coolGreen, size: 100, velocityCap:2 + 2,),
    MovingGradientCircle(color: AppColors.coolBlue, size: 30, velocityCap:2 + 4,),
    MovingGradientCircle(color: AppColors.coolGreen, size: 20, velocityCap:2 + 4,),
    MovingGradientCircle(color: AppColors.coolBlue, size: 20, velocityCap:2 + 4,),
    MovingGradientCircle(color: AppColors.coolBlue, size: 10, velocityCap:2 + 4,),
    MovingGradientCircle(color: Colors.white, size: 20, velocityCap:2 + 7,),
    MovingGradientCircle(color: Colors.white, size: 10, velocityCap:2 + 7,),
    MovingGradientCircle(color: Colors.white, size: 10, velocityCap:2 + 4,),
    MovingGradientCircle(color: Colors.white, size: 5, velocityCap:2 + 2,),
    MovingGradientCircle(color: Colors.white, size: 5, velocityCap:2 + 3,),
    MovingGradientCircle(color: Colors.white, size: 5, velocityCap:2 + 2,),];

  @override
  void initState() {
    Provider.of<ResultsProvider>(context, listen: false).addListener(_refresh);
    _resultsProvider = Provider.of<ResultsProvider>(context, listen: false);
    _resultsProvider.getUserDataFromSharedPreferences();

    super.initState();
  }

  _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.green,
      body: SafeArea(child: _content()),
    );
  }

  _content() {

    return Stack(
      children:
      <Widget>[]..addAll(_flurryballs)..addAll(
      [
        Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _title(),
                SizedBox(height: 80,),
                _inputBox(),
                _selectExplorer(),
              ],
            ),
            _searchButton(),
          ],
        ),
      ),])
    );
  }

  _title() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Hange GPT",
          style: AppStyles.textTheme.headlineLarge?.copyWith(fontSize: 40),
        ),
        Image.asset(
          AppAssets.hangeTransparent,
          height: 100,
        )
      ],
    );
  }

  _inputBox() {
    return Form(
        child: TextFormField(
          maxLength: 140,
      maxLines: 8,
      controller: _promptTextController,
      decoration: AppStyles.inputDecoration(label: "Instrucciones").copyWith(hintText: "Prueba con frases como:\n\"Los 5 países más influyentes de Ásia.\"\n\"7 biólogos reales que hayan aparecido en una película.\"\n\"10 alimentos más picantes de la cocina nórdica.\""),
    ));
  }

  _searchButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: _historyButtonPressed, icon: Icon(Icons.history, color: AppColors.blue,)),
          ElevatedButton(
              style: AppStyles.primaryButtonStyle,
              onPressed: _onSearchButtonPressed,
              child: Text(
                "¡Buscar!",
                style: AppStyles.textTheme.titleLarge?.copyWith(color: Colors.white),
              )),
          IconButton(onPressed: _infoButtonPressed, icon: Icon(Icons.info_outlined, color: AppColors.blue,)),
        ],
      ),
    );
  }

  _onSearchButtonPressed() async {
    _resultsProvider.fetchResults(prompt: _promptTextController.text);

    Navigator.pushNamed(context, NavigatorRoutes.results);
  }

  _selectExplorer() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: SizedBox(
          height: 90,
          width: 170,
          child: Row(
            children: [
              _hangeButton(),
              _jinnButton(),
            ],
          ),
        ),
      ),
    );
  }

  _hangeButton() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: _hangeButtonTapped,
              child: Padding(
                padding: const EdgeInsets.only(right: 2.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  child: Container(
                    child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            _resultsProvider.explorer == Explorer.Hange
                                ? Colors.transparent
                                : AppColors.lightGrey,
                            BlendMode.color),
                        child: Image.asset(AppAssets.hangeTransparent)),
                    decoration: BoxDecoration(
                      color: _resultsProvider.explorer == Explorer.Hange
                          ? AppColors.blue.withOpacity(0.3)
                          : AppColors.lightGrey,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "HANGE",
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontWeight: _resultsProvider.explorer == Explorer.Hange
                      ? FontWeight.bold
                      : FontWeight.w400,
                ),
              ),
              SizedBox(
                width: 3,
              )
            ],
          )
        ],
      ),
    );
  }

  _jinnButton() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: _jinnButtonTapped,
              child: Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  child: Container(
                    child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            _resultsProvider.explorer == Explorer.Jinn
                                ? Colors.transparent
                                : AppColors.lightGrey,
                            BlendMode.saturation),
                        child: Image.asset(AppAssets.jinnTransparent)),
                    decoration: BoxDecoration(
                      color: _resultsProvider.explorer == Explorer.Jinn
                          ? AppColors.blue.withOpacity(0.3)
                          : AppColors.lightGrey,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(
              width: 3,
            ),
            Text(
              "JINN",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: _resultsProvider.explorer == Explorer.Jinn
                    ? FontWeight.bold
                    : FontWeight.w400,
              ),
            ),
          ])
        ],
      ),
    );
  }

  void _jinnButtonTapped() {
    _resultsProvider.setExplorer(explorer: Explorer.Jinn);
  }

  void _hangeButtonTapped() {
    _resultsProvider.setExplorer(explorer: Explorer.Hange);
  }

  void _historyButtonPressed() {

    DialogsHelper.showHistoryDialog(context: context);

  }

  void _infoButtonPressed() {

    DialogsHelper.showInfoDialog(context: context);

  }
}
