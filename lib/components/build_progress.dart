


import 'package:flutter/material.dart';
import 'package:pharma/components/defultButton.dart';

void buildProgress({context, text, bool error = false})
=> showDialog(context: context, builder: (context) => AlertDialog(
  content: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        children: [
          if (!error) CircularProgressIndicator(),
          if (!error)
            SizedBox(
              width: 20,
            ),
          Expanded(child: Text(text)),
        ],
      ),
      if (error)
        SizedBox(height: 20),
      if (error)
        defaultButton(
          function: () {
            Navigator.pop(context);
          },
          text: "Cancel", icon: null, width: null,
        ),
    ],
  ),
),);