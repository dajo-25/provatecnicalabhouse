import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provatecnicalabhouse/src/config/app_colors.dart';
import 'package:provatecnicalabhouse/src/config/app_styles.dart';
import 'package:provatecnicalabhouse/src/models/Result.dart';
import 'package:provatecnicalabhouse/src/provider/results_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/moving_gradient_circle.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  late ResultsProvider _resultsProvider;
  PageController _pageController = PageController();

  double _cardsOpacity = 0;
  double _loadingOpacity = 1;

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
    _resultsProvider = Provider.of<ResultsProvider>(context, listen: false);
    _resultsProvider.addListener(_refresh);

    _pageController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  void _refresh() async {
    await Future.delayed(const Duration(milliseconds: 50));
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green,
      appBar: _appBar(),
      body: _content(),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: false,
      leading: BackButton(color: AppColors.blue,),
      automaticallyImplyLeading: true,
      title: Text(_resultsProvider.prompt.toString(), style: TextStyle(color: AppColors.blue),),
    );
  }

  _content() {

    return Stack(
      children: <Widget>[]..addAll(_flurryballs)..add(_resultsProvider.results == null ? Center(child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(color: AppColors.blue,),
        ],
      ),): _resultsLayout()),
    );

    if (_resultsProvider.results == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return _resultsLayout();
    }

  }

  _resultsLayout() {
    return Stack(children: [
      Row(
        children: [
          const SizedBox(
            width: 80,
          ),
          _cardsSwipe()
        ],
      ),
      Align(alignment: Alignment.topLeft, child: _sideoutline())
    ]);
  }

  _sideoutline() {

    if(_pageController.positions.isEmpty){
      return SizedBox(width: 10, height: 10,);
    }

    return AnimatedOpacity(
      opacity: _cardsOpacity,
      duration: Duration(milliseconds: 500),
      child: Container(
        width: 80,
        decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(20)), color: Colors.white, border: Border.fromBorderSide(BorderSide(color: Colors.blueGrey.withOpacity(0.3),width: 1.5))),
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
              ]..addAll(
                  List.generate(
                    (_resultsProvider.results?.length ?? 0),
                    (index) {
                      final color = index.toDouble() <=
                              (_pageController.page?.toDouble() ?? 0)
                          ? AppColors.blue
                          : Colors.grey;
                      final colordelayed = index.toDouble() + 1 <=
                              (_pageController.page?.toDouble() ?? 0)
                          ? AppColors.blue
                          : Colors.grey;

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _onDotTapped(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.transparent),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 2,
                                    height: 10,
                                    color: index == 0
                                        ? Colors.transparent
                                        : color,
                                  ),
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundColor: color,
                                  ),
                                  Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        Container(
                                          width: 2,
                                          height: 70,
                                          color: index ==
                                                  (_resultsProvider
                                                              .results?.length ??
                                                          0) -
                                                      1
                                              ? Colors.transparent
                                              : colordelayed,
                                        ),
                                        Align(
                                            alignment: Alignment.topCenter,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 8.0),
                                              child: Container(
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: color.withOpacity(0.7)),
                                                  child: Text("${_resultsProvider
                                                      .results?[index].title
                                                      .toString()}" ??
                                                      "", maxLines: 2, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, style: TextStyle(color: color == Colors.grey ? Colors.black: Colors.white),),
                                                ),
                                              ),
                                            ))
                                      ]),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )),
        ),
      ),
    );
  }

  _cardsSwipe() {
    if (_pageController.positions.isNotEmpty) {
      return Expanded(
        child: AnimatedOpacity(
          opacity: _cardsOpacity,
          duration: Duration(milliseconds: 500),
          child: Stack(fit: StackFit.expand, children: _cards()),
        ),
      );
    } else {
      _showCards();
      return Expanded(child: _buildList());
    }
  }

  _cards() {
    return _resultsProvider.results!
        .map<Widget>(
          (e) => Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..setTranslationRaw(
                  (_resultsProvider.results!.indexOf(e) <= _pageController.page!
                          ? ((_pageController.page! -
                                  _resultsProvider.results!.indexOf(e)) *
                              -40)
                          : -(20 /
                                  pow(
                                      2,
                                      (_resultsProvider.results!.indexOf(e) -
                                          _pageController.page!))) +
                              20) -
                      5,
                  -(20 /
                      pow(
                          2,
                          (_resultsProvider.results!.indexOf(e) -
                              _pageController.page!))),
                  0)
              ..rotateY(
                  _resultsProvider.results!.indexOf(e) <= _pageController.page!
                      ? (((_pageController.page! -
                                  _resultsProvider.results!.indexOf(e)) *
                              3.14) /
                          2)
                      : 0),
            child: _card(e),
          ),
        )
        .toList()
        .reversed
        .toList()
      ..addAll([
        Container(
          color: Colors.transparent,
          child: _buildList(),
        ),
      ]);
  }

  _card(Result e) {
    return Center(
      child: Visibility(
        visible:
            _resultsProvider.results!.indexOf(e) >= _pageController.page! - 1,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                offset: Offset(
                    3 *
                        (1 /
                            pow(
                                2,
                                (_resultsProvider.results!.indexOf(e) -
                                    _pageController.page!))),
                    3 *
                        (1 /
                            pow(
                                2,
                                (_resultsProvider.results!.indexOf(e) -
                                    _pageController.page!)))),
                blurRadius: 3,
                spreadRadius: 0,
                color: e.accentColor?.withOpacity(0.3) ??
                    Colors.black.withOpacity(0.1),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            // child: BackdropFilter(
            //   filter: ImageFilter.blur(sigmaY: 4, sigmaX: 4),
            child: Container(
              height: 570,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(1),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: e.accentColor?.withOpacity(0.3) ??
                          Colors.blueGrey.withOpacity(0.3),
                      width: 1.5)),
              child: _cardContent(e),
            ),
          ),
        ),
      ),
    );
  }

  _cardContent(Result e) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _cardrankingandimage(e),
        _cardtitle(e),
        _cardinfo(e),
      ],
      // ),
    );
  }

  _cardinfo(Result e) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            _carddescription(e),
            _cardatribute(e),
          ],
        ),
      ),
    );
  }

  _cardatribute(Result e) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          e.atribute?.name.toString() ?? "null",
          style: AppStyles.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.bold, color: e.accentColor),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: Builder(
            builder: (BuildContext context) {
              final tmpValues = _resultsProvider.results
                  ?.map((e) => e.atribute?.value)
                  .toList();
              tmpValues?.sort();
              final topValue = tmpValues?.last;
              return Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      color: e.accentColor,
                      strokeWidth: 12,
                      value: ((e.atribute?.value ?? 1) / topValue!),
                    ),
                  ),
                  Center(
                    child: Text(
                      e.atribute?.value.toString() ?? "",
                      style: AppStyles.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold, color: e.accentColor),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  _carddescription(Result e) {
    return Expanded(
      child: Text(
        e.description.toString(),
        textAlign: TextAlign.justify,
        style: AppStyles.textTheme.bodySmall,
      ),
    );
  }

  _cardtitle(Result e) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        e.title.toString(),
        style: AppStyles.textTheme.headlineLarge,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  _cardrankingandimage(Result e) {
    return SizedBox(
        height: 90,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
          child: Row(
            children: [
              Text(
                "#${_resultsProvider.results!.indexOf(e).toInt() + 1}",
                style:
                    AppStyles.textTheme.headlineLarge?.copyWith(fontSize: 50),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child:
                      Image.network(e.imageUrl.toString(), fit: BoxFit.contain),
                ),
              ))
            ],
          ),
        ));
  }

  _buildList() {
    return AspectRatio(
      aspectRatio: 12.0 / 15.0,
      child: PageView.builder(
        itemCount: _resultsProvider.results?.length,
        controller: _pageController,
        itemBuilder: (context, index) {
          _refresh();

          return Container(
            color: Colors.transparent,
          );
        },
      ),
    );
  }

  _showCards() async {
    setState(() {
      _cardsOpacity = 0;
    });

    await Future.delayed(Duration(milliseconds: 1000));

    setState(() {
      _cardsOpacity = 1;
    });
  }

  _onDotTapped(index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOutQuad);
  }

}
