import 'package:flutter/material.dart';

class CardBoardInfo extends StatefulWidget {
  const CardBoardInfo({super.key});

  @override
  State<CardBoardInfo> createState() => _CardBoardInfoState();
}

class _CardBoardInfoState extends State<CardBoardInfo> {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.9,
        minChildSize: 0.2,
        maxChildSize: 0.9,
        builder: ((context, scrollController) {
          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 60,
                height: 7,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [],
              ),
            ],
          );
        }));
  }
}
