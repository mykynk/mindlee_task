import 'package:flutter/material.dart';
import 'package:mindlee_task/core/extensions/l10n_extensions.dart';

import '../constants/size.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: deviceHeightSize(context, 4),
            left: deviceWidthSize(context, 20),
            right: deviceWidthSize(context, 20),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              context.localize.daily_message,
              style: TextStyle(
                fontSize: deviceFontSize(context, 16),
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: deviceFontSize(context, 14),
              ),
              onPressed: () {
                // Navigator.pop(context);
              },
            ),
            actions: [
              PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    child: Text("Mindlee"),
                  ),
                  const PopupMenuItem(
                    child: Text("Mindlee"),
                  ),
                ],
              )
            ],
          ),
        ),
        const Divider(
          color: Color(0x33ECEFF3),
          thickness: 1,
          height: 1,
        ),
      ],
    );
  }
}
