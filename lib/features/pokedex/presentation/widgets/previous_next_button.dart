import 'package:flutter/material.dart';

class PreviousNextButton extends StatelessWidget {
  final bool next;
  final String label;
  final Function onTap;
  const PreviousNextButton(
      {Key? key, required this.next, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onTap(),
      child: Row(
        children: [
          if (!next) ...[Icon(Icons.arrow_back_ios, color: Colors.white)],
          Text(
            label,
            style: TextStyle(color: Colors.white),
          ),
          if (next) ...[Icon(Icons.arrow_forward_ios, color: Colors.white)]
        ],
      ),
    );
  }
}
