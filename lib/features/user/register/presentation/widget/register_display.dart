import 'package:flutter/material.dart';

import 'register_form_widget.dart';

class RegisterDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: true,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4.0, 20.0, 4.0, 16.0),
          child: RegisterFormWidget(32.0, false),
        ),
      ],
    );
  }
}