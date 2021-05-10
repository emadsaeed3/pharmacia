import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../size_config.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key key,
    @required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors.length, (index) => formErrorText(error: errors[index])),
    );
  }

  Row formErrorText({String error}) {
    return Row(
      children: [
        SvgPicture.asset(
          "icons/Error.svg",
          height: SizeConfig.safeBlockHorizontal *  14,
          width: SizeConfig.safeBlockHorizontal *  14,
        ),
        SizedBox(
          width: SizeConfig.safeBlockHorizontal *  10,
        ),
        Text(error),
      ],
    );
  }
}


class ErrorHandler {
  //Error Dialogs
  Future<bool> errorDialog(BuildContext context, e) {
    return showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
              ),
              title: Text('Error'),
              content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        height: 100.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0)
                        ),
                        child: Center(
                            child: Text(
                                e.message.toString()
                            )
                        )
                    ),
                    Container(
                        height: 50.0,
                        child: Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Ok')
                              )
                            ]
                        )
                    )
                  ]
              )
          );
        }
    );
  }
}
