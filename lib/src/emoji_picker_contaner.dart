import 'package:flutter/material.dart';

Future<void> showEmojiPicker({
  required BuildContext context,
}) async {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        color: Colors.white,
        height: 200,
        child: Center(
          child: Text(
            "Emoji Picker",
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    },
  );
}
