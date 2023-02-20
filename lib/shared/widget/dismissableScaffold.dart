import 'package:flutter/material.dart';

class DismissibleScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final Color backgroundColor;
  final Color appBarColor;
  final double leadingWidth;
  final bool shouldAddBack;

  const DismissibleScaffold(
      {Key? key,
      this.title,
      this.leadingWidth = 20,
      this.shouldAddBack = true,
      required this.body,
      this.backgroundColor = Colors.white,
      this.appBarColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: body,
          ),
        ));
  }
}
