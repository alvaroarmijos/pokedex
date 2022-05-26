import 'package:flutter/material.dart';
import 'package:pokedex/core/global/styles.dart';

class MessageDisplay extends StatelessWidget {
  final String message;
  final bool showRechargeIcon;
  const MessageDisplay({
    Key? key,
    required this.message,
    this.showRechargeIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          style: TitleStyle(),
        ),
      ],
    );
  }
}
