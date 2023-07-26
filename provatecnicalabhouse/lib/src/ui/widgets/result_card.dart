import 'package:flutter/material.dart';

import '../../models/Result.dart';

class ResultCard extends StatefulWidget {
  final Result result;

  const ResultCard({Key? key, required this.result}) : super(key: key);

  @override
  State<ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(widget.result.title.toString()),
                Text(widget.result.description.toString()),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(widget.result.atribute!.name.toString()),
                    SizedBox(
                      width: 10,
                    ),
                    Text(widget.result.atribute!.value.toString())
                  ],
                )
              ],
            ),
          ),
          Expanded(
              flex: 3, child: Image.network(widget.result.imageUrl.toString()))
        ],
      ),
    );
  }
}
